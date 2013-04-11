class Phast::Parser

rule

phast :  PH_OT estatutos PH_CT {}
estatutos: estatuto estatutos
         |
estatuto : expresion ';' 
         | bloque_while
         | bloque_do 
         | bloque_verbose
         | bloque_if
         | bloque_for
         | { aumenta_scope } bloques_declarativos { disminuye_scope }
bloques_declarativos: bloque_fun
                    | bloque_class

# Expresiones
expresion: comparando {fun3 2} comparando_aux
comparando_aux: op_comp {fun2} comparando {fun3 2} comparando_aux
           |
comparando: termino {fun3 1} termino_aux
termino_aux: op_term {fun2} termino {fun3 1} termino_aux
           | 
termino: factor {fun3 0} factor_aux
factor_aux: op_fact {fun2} factor {fun3 0} factor_aux 
          | 
factor: llamada 
      | estatico {fun1}
llamada: ID { llame_var}{ fun1 } id_call
estatico: numero
        | STRING
        | arreglo
        /*| OP_INCREMENT ID {}*/
        /*| OP_DECREMENT ID {}*/
        | WORD_TRUE
        | WORD_FALSE
        | WORD_NULL
        | '('{fun4} expresion ')'{fun5}

id_call: '(' argumentos ')'
        | '[' expresion ']'
        /*| OP_INCREMENT*/
        /*| OP_DECREMENT*/
        | OP_ASIGN {fun2} expresion {fun3 3} 
        |
argumentos: expresion args_aux
          |
args_aux: ',' expresion args_aux
        |
op_comp: OP_EQUAL
       | OP_NOT_EQUAL  
       | OP_GREATER  
       | OP_GREATER_EQUAL
       | OP_LESS  
       | OP_LESS_EQUAL
       | WORD_AND  
       | WORD_OR 

op_term: OP_PLUS
       | OP_MINUS

op_fact: OP_MULTIPLY
       | OP_DIVIDE

numero : INT { guarda_cte @curr_token[1], Integer(@curr_token[1]) , "int" }
       | FLOAT { guarda_cte @curr_token[1], Float(@curr_token[1]) , "float" }
arreglo: '[' arr_elems ']'
arr_elems: arr_elem arr_elems_aux
          |
arr_elems_aux: ',' arr_elem arr_elems_aux
          |
arr_elem: arr_val arr_elem_aux
arr_elem_aux: '=' '>' arr_val
             |
arr_val: expresion

# Bloques
bloque_if : WORD_IF  '(' expresion ')' {if_quad 1} '{' estatutos '}' else {if_quad 2} 
else: WORD_ELSE {if_quad 3} aux_else
     |
aux_else: bloque_if
       | '{' estatutos '}'
bloque_while : WORD_WHILE {while_quad 1} '(' expresion ')' {while_quad 2} '{' estatutos '}' {while_quad 3}
bloque_do : WORD_DO {do_while_quad 1} '{' estatutos '}' WORD_WHILE '(' expresion ')' {do_while_quad 2} ';' 
bloque_verbose : VERBOSE_BLOCK
bloque_for : WORD_FOR '('comparando ';' expresion ';' expresion ')' '{' estatutos '}'
bloque_fun : WORD_FUN ID { nombre_scope } '(' params ')' '{' estatutos '}'

bloque_class: WORD_CLASS ID class_extras '{' class_body '}'
class_body: class_body_aux  class_body
           |
class_body_aux: { aumenta_scope } bloque_fun { disminuye_scope }
           | ID { llame_var } class_def_var_aux ';'
class_def_var_aux: OP_ASIGN 
                  |
class_extras: WORD_EXTENDS ID
             |

params: ID { llame_var } def_param params_aux
       |
params_aux: ',' ID { llame_var } def_param params_aux
           |
def_param: '=' estatico
          |
end

---- header ----

require_relative 'lib/Quad'
require_relative 'lib/Var'
require_relative 'lib/Instrucciones'

---- inner ----

    def initialize(scanner)
        @scanner = scanner

        #Scopes
        @scope = 0
        @scopes = [{}]
        
        #Quads
        @quads = [[]]
        @next_quad = 0

        #Pilas
        @poper = []
        @operandos = []
        @psaltos = []
        @output = {}

        @tmp_var_id = 0
        @ctes = {}
        @llave_quads = [:main]

        @output[@llave_quads.last] = {}

        #Global config
        $debug = true
    end

    def parse
        do_parse
        process_output
    end

    def next_token
        @curr_token = @scanner.next_token
    end

    def llame_var
        if @scopes.last.include? @curr_token[1]
            @scopes.last[@curr_token[1]]
        else
            if @scopes.first.include? @curr_token[1]
            @scopes.first[@curr_token[1]]
            else
            guarda_var @curr_token[1]
            end
        end
    end

    def guarda_var(nombre)
        @scopes.last[nombre] = Var.new(nombre,nil,nil,@scope,@lineno) #[Name,type,direccion,scope,declared_at]
    end

    def guarda_cte(nombre,valor,tipo)
        @ctes[nombre] = Var.new(valor,tipo,valor,-2,@lineno)
    end

    def nombre_scope
        @llave_quads.push @curr_token[1]
    end

    def aumenta_scope
        @scopes.push Hash.new
        @quads.push Array.new
        @scope += 1
        @next_quad = 0
    end

    def disminuye_scope
        @output[@llave_quads.last] = {}
        @output[@llave_quads.last][:quads] = @quads.pop
        @output[@llave_quads.last][:var_info] = @scopes.pop
        @llave_quads.pop
        @scope -= 1
    end
    
    def rellena(n)
        incomplete_quad = @quads.last.delete_at n
        @quads.last.insert(n, Quad.new(incomplete_quad.instruccion, incomplete_quad.op1, nil, @next_quad))
    end

    def genera(w,x,y,z)
        @quads.last.push Quad.new(w,x,y,z)
        @next_quad += 1
    end
    
    def fun1
        # puts "Meter #{@curr_token[1]} a pila Operandos" 
        # @operandos.push @curr_token[1]
        if @scopes.last.include? @curr_token[1]
            @operandos.push @scopes.last[@curr_token[1]]
        else #Constantes
            @operandos.push @ctes[@curr_token[1]]
        end
    end

    def fun2
        # puts "Meter #{@curr_token[1]} a pila Operadores" 
        @poper.push @curr_token[1]
    end

    def fun3(nivel)
        # puts "Checar el top de Poper tiene operador pendiente"
        if !@poper.empty?
            op = @poper.last
            case
            when nivel == 0
                if(op == '*' || op == '/')
                    @poper.pop
                    oper = @operandos.pop
                    oper1 = @operandos.pop
                    @tmp_var_id += 1
                    @operandos.push Var.new("t#{@tmp_var_id}",nil,nil,-1,-1)

                    genera(op, oper1, oper,@operandos.last)
                end
            when nivel == 1
                if(op == '+' || op == '-')
                    @poper.pop
                    oper = @operandos.pop
                    oper1 = @operandos.pop
                    @tmp_var_id += 1
                    @operandos.push Var.new("t#{@tmp_var_id}",nil,nil,-1,-1)
                    genera(op, oper1, oper, @operandos.last)
                end
            when nivel == 2
                if(op == "and" || op == "or" || op == "<" || op == ">" || op == "<=" || op == ">=")
                    @poper.pop
                    oper = @operandos.pop
                    oper1 = @operandos.pop
                    @tmp_var_id += 1
                    @operandos.push Var.new("t#{@tmp_var_id}",nil,nil,-1,-1)
                    genera(op, oper1, oper, @operandos.last)
                end
            when nivel == 3
                if(op == "=")
                    @poper.pop
                    oper = @operandos.pop
                    oper1 = @operandos.pop
                    @operandos.push oper1
                    genera(op, oper, nil, oper1)
                end
            end
        end
    end

    def if_quad(step)
        case
        when step == 1
            @psaltos.push @next_quad
            condicion = @operandos.pop
            genera(Phast::GOTOF, condicion, nil, nil)
        when step ==  2
            rellena(@psaltos.pop)
        when step == 3
            f = @psaltos.pop
            @psaltos.push @next_quad
            genera(Phast::GOTO, nil, nil, nil)
            rellena(f)
        end
    end

    def while_quad(step)
        case
        when step == 1
            @psaltos.push @next_quad
        when step ==  2
            condicion = @operandos.pop
            @psaltos.push @next_quad
            genera(Phast::GOTOF, condicion, nil, nil)
        when step == 3
            f = @psaltos.pop
            r = @psaltos.pop
            genera(Phast::GOTO, nil, nil, r)
            rellena(f)
        end
    end

    def do_while_quad(step)
        case
        when step == 1
            @psaltos.push @next_quad
        when step ==  2
            condicion = @operandos.pop
            genera(Phast::GOTOV, condicion, nil, @psaltos.pop)
        end
    end

    def process_output

        @output[@llave_quads.last][:quads] = @quads.pop
        @output[@llave_quads.last][:var_info] = @scopes.pop

        Var.map_mem
        mems = Var.mem_info
        puts "CTS\t#{mems[0]}"
        puts "GLBL\t#{mems[1]}"
        puts "SCPS\t#{mems[2]}"
        puts "TMP\t#{mems[3]}"

        main_quads = @output[:main]
        @output.delete(:main)
        @output.each {|key, value| print_quads value[:quads] }
        print_quads main_quads[:quads]

    end

    def print_quads(quads)
        puts "SOQ"
        i = 0;
        until quads.empty?
            quad = quads.shift
            puts "#{i}: \t#{quad.to_s}"
            i += 1
        end
        puts "EOQ"
    end

    def on_error(t,val,vstack)
        raise ParseError, sprintf("\nError de sintaxis. Se encontro %s (%s) inesperado", val.inspect, token_to_str(t) || '?')
    end
