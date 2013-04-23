/*
Cubo semantico:

Operadores aritmeticos: (+,-,*,/,++,--)

        String  Int     Float       Bool
String  String  String  String      Bool
Int     String  Int     Float       Int
Float   String  Float   Float       Bool
Bool    Bool    Int    Bool        Bool

Operadores lógicos: (AND,OR, &&, ||, !, >, <, >=, <=, ==, !=)

        String  Int     Float       Bool
String  Bool    Bool    Bool        Bool
Int     Bool    Bool    Bool        Bool
Float   Bool    Bool    Bool        Bool
Bool    Bool    Bool    Bool        Bool

Jerarquía de tipos de datos:

    NULO = 0,
    BOLEANO = 1,
    ENTERO = 2,
    FLOTANTE = 3,
    CADENA = 4
*/

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
         | WORD_RETURN expresion {return_quad @latest_var } ';'
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
      | estatico {fun1 @curr_token[1]}
      | '('{fun4} expresion ')'{fun5}
llamada: ID tipo_llamada 

tipo_llamada: { llame_var @prev_token[1] }{ fun1 @prev_token[1] } vars 
            | funcs
funcs: { fun_prepare @prev_token[1] } '(' { @operandos.push "(" }  argumentos { clean_operandos } ')' { fun_call }
        /*| OP_INCREMENT*/
        /*| OP_DECREMENT*/
vars: OP_ASIGN {fun2} expresion {fun3 3} 
    | '[' expresion ']'
    |
estatico: numero
        | STRING
        | arreglo
        /*| OP_INCREMENT ID {}*/
        /*| OP_DECREMENT ID {}*/
        | WORD_TRUE
        | WORD_FALSE
        | WORD_NULL
argumentos:  expresion { argument @latest_var } args_aux
          |
args_aux: ',' expresion { argument @latest_var } args_aux
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

numero : INT { guarda_cte @curr_token[1], Integer(@curr_token[1]) , 2 }
       | FLOAT { guarda_cte @curr_token[1], Float(@curr_token[1]) , 3 }
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
bloque_fun : WORD_FUN ID { nombre_scope } '(' params ')' '{' estatutos { end_fun } '}'

bloque_class: WORD_CLASS ID class_extras '{' class_body '}'
class_body: class_body_aux  class_body
           |
class_body_aux: { aumenta_scope } bloque_fun { disminuye_scope }
           | ID { llame_var @curr_token[1] } class_def_var_aux ';'
class_def_var_aux: OP_ASIGN 
                  |
class_extras: WORD_EXTENDS ID
             |

params: ID { llame_var @curr_token[1] } { param @latest_var } def_param params_aux
       |
params_aux: ','  ID { llame_var @curr_token[1] } { param @latest_var } def_param params_aux
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
        @undeclared_funcs = []
        $declared_funcs = {}

        @function_to_call = nil
        @latest_var = nil
        @tmp_var_id = 0
        @ctes = {}
        @llave_quads = [:main]
        @curr_token = nil
        @call_quads = []

        @output[@llave_quads.last] = {}

    end

    def parse
        do_parse
        process_output
    end

    def next_token
        @prev_token = @curr_token
        @curr_token = @scanner.next_token
    end

    def llame_var cual
        if @scopes.last.include? cual
            @latest_var = @scopes.last[cual]
        else
            @latest_var = guarda_var cual
        end
    end

    def guarda_var(nombre)
        var = Var.new(nombre,nil,nil,@scope,@lineno) #[Name,type,direccion,scope,declared_at]
        @scopes.last[nombre] = var
        return var
    end

    def guarda_cte(nombre,valor,tipo)
        if !@ctes.include? nombre
            @ctes[nombre] = Var.new(valor,tipo,valor,-2,@lineno)
        end
    end

    def clean_operandos
        while @operandos.last != "("
            @operandos.pop
        end
        @operandos.pop
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
        @output[@llave_quads.last][:mem_info] = Var.reset_scope(@scope)
        @llave_quads.pop
        @scope -= 1
    end
    
    def rellena(n)
        incomplete_quad = @quads.last.delete_at n
        @quads.last.insert(n, Quad.new(incomplete_quad.instruccion, incomplete_quad.op1, nil, @next_quad))
    end

    def genera(w,x,y,z)
        @next_quad += 1
        tmp = Quad.new(w,x,y,z)
        @quads.last.push tmp
        tmp
    end

    def fun_prepare cual
        @function_to_call = cual
    end
        

    def fun_call
        if @function_to_call == nil
            p "Compile Error"
            exit
        end
        cual = @function_to_call
        @function_to_call = nil
        if(cual == "print")
            @output["print"] = {}
            @output["print"][:mem_info] = nil
            @output["print"][:quads] = {}
            $declared_funcs["print"] = nil
            genera(Phast::PRT,nil,nil,nil)
        else
            @undeclared_funcs.push cual if !$declared_funcs.include? cual
            @call_quads.push genera(Phast::CALL,nil,nil,cual)
            @tmp_var_id += 1
            @operandos.push Var.new("t#{@tmp_var_id}",nil,nil,-1,-1)
            genera(Phast::REV,nil,nil,@operandos.last)
        end
    end

    def argument name
        genera(Phast::ARG,nil,nil,name)
    end

    def return_quad var
        genera(Phast::RET,nil,nil,var)
    end

    def end_fun
        return_quad nil
    end
    
    def param a
        genera(Phast::PAR,nil,nil,a)
    end
    
    def fun1(cual)
        # puts "Meter #{@curr_token[1]} a pila Operandos" 
        if @scopes.last.include? cual
            @latest_var = @scopes.last[cual]
            @operandos.push @scopes.last[cual]
        else #Constantes
            @latest_var = @ctes[cual]
            @operandos.push @ctes[cual]
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
                    @latest_var = @operandos.last
                    genera(Phast.op_to_inst(op), oper1, oper,@operandos.last)
                end
            when nivel == 1
                if(op == '+' || op == '-')
                    @poper.pop
                    oper = @operandos.pop
                    oper1 = @operandos.pop
                    @tmp_var_id += 1
                    @operandos.push Var.new("t#{@tmp_var_id}",nil,nil,-1,-1)
                    @latest_var = @operandos.last
                    genera(Phast.op_to_inst(op), oper1, oper, @operandos.last)
                end
            when nivel == 2
                if(op == "and" || op == "or" || op == "<" || op == ">" || op == "<=" || op == ">=")
                    @poper.pop
                    oper = @operandos.pop
                    oper1 = @operandos.pop
                    @tmp_var_id += 1
                    @operandos.push Var.new("t#{@tmp_var_id}",nil,nil,-1,-1)
                    @latest_var = @operandos.last
                    genera(Phast.op_to_inst(op), oper1, oper, @operandos.last)
                end
            when nivel == 3
                if(op == "=")
                    @poper.pop
                    oper = @operandos.pop
                    oper1 = @operandos.pop
                    @operandos.push oper1
                    @latest_var = @operandos.last
                    genera(Phast.op_to_inst(op), oper, nil, oper1)
                end
            end
        end
    end

    def fun4
        @poper.push "("
    end
    def fun5
        @poper.pop
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

        @salida = []

        @output[@llave_quads.last][:quads] = @quads.pop
        @output[@llave_quads.last][:var_info] = @scopes.pop

        Var.map_mem
        mems = Var.mem_info
        if $debug 
            @salida.push "CTS\t#{mems[0]}"
            @salida.push "GLBL\t#{mems[1]}"
            @salida.push "TMP\t#{mems[3]}"
            @salida.push "SCPS\t#{mems[2]}"
        else
            @salida.push "#{mems[0]}"
            @salida.push "#{mems[1]}"
            @salida.push "#{mems[2]}"
            @salida.push "#{mems[3]}"
        end
        @ctes.each do |k,c|
            @salida.push "#{c}\t#{c.valor}\t#{c.tipo}"
        end

        @reg_counter = 0
        main_quads = @output[:main]
        @output.delete(:main)
        @output.each do |key, value|
            $declared_funcs[key] = @reg_counter
            @undeclared_funcs.delete(key)
            @salida.push "SOSM:\t#{key}" if $debug
            print_quads value[:quads]
            @salida.push "EOSM" if $debug
        end
        # if !@undeclared_funcs.empty?
        #     raise ParseError, sprintf("Funcion #{@undeclared_funcs.last} no declarada")
        # end
        @salida.unshift @reg_counter
        @salida.push "SOQ" if $debug
        print_quads main_quads[:quads]
        @salida.push "EOQ" if $debug

        @call_quads.each do |q|
            q.op1 = @output[q.registro][:mem_info].to_s
            q.registro = $declared_funcs[q.registro]
        end
        puts @salida

    end

    def print_quads(quads)
        reg_offset = @reg_counter
        until quads.empty?
            quad = quads.shift
            quad.saltos reg_offset
            # @salida.push "#{@reg_counter}: \t#{quad.imprime reg_offset}"
            @salida.push quad
            @reg_counter += 1
        end
    end

    def on_error(t,val,vstack)
        raise ParseError, sprintf("\nError de sintaxis. Se encontro %s (%s) inesperado", val.inspect, token_to_str(t) || '?')
    end
