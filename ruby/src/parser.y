class Phast::Parser

rule

phast :  PH_OT estatutos PH_CT
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
#Expresiones
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

numero : INT {}
       | FLOAT {}
arreglo: '[' arr_elems ']'
arr_elems: arr_elem arr_elems_aux
          |
arr_elems_aux: ',' arr_elem arr_elems_aux
          |
arr_elem: arr_val arr_elem_aux
arr_elem_aux: '=' '>' arr_val
             |
arr_val: expresion

bloque_while : WORD_WHILE '(' expresion ')' '{' estatutos '}'
bloque_do : WORD_DO '{' estatutos '}' WORD_WHILE '(' expresion ')' ';' 
bloque_verbose : VERBOSE_BLOCK
bloque_if : WORD_IF  '(' expresion ')' '{' estatutos '}' else
else: WORD_ELSE aux_else
     |
aux_else: bloque_if
       | '{' estatutos '}'
bloque_for : WORD_FOR '('comparando ';' expresion ';' expresion ')' '{' estatutos '}'
bloque_fun : WORD_FUN ID '(' params ')' '{' estatutos '}'

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

---- inner ----

    def initialize(scanner)
        @scanner = scanner
        @scope = 0
        @poper = []
        @operandos = []
        @tmp_var_id = 0
        @tmp_v = []
    end

    def parse
        @scopes = [{}]
        do_parse
    end

    def next_token
        @curr_token = @scanner.next_token
    end

    def llame_var
        if @scopes.last.include? @curr_token[1]
        else
        guarda_var
        end
    end

    def guarda_var
        @scopes.last[@curr_token[1]] = [@scope,nil,$lineno] #[scope,type,declared_at]
    end

    def aumenta_scope
        @scopes.push Hash.new
        @scope += 1
    end

    def disminuye_scope
        last_scope = @scopes.pop
        @scope -= 1
    end
    
    def fun1
        # puts "Meter #{@curr_token[1]} a pila Operandos" 
        @operandos.push @curr_token[1]
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
                    @operandos.push "t#{@tmp_var_id}"
                    puts "#{op}\t#{oper1}\t#{oper}\tt#{@tmp_var_id}"
                end
            when nivel == 1
                if(op == '+' || op == '-')
                    @poper.pop
                    oper = @operandos.pop
                    oper1 = @operandos.pop
                    @tmp_var_id += 1
                    @operandos.push "t#{@tmp_var_id}"
                    puts "#{op}\t#{oper1}\t#{oper}\tt#{@tmp_var_id}"
                end
            when nivel == 2
                if(op == "and" || op == "or")
                    @poper.pop
                    oper = @operandos.pop
                    oper1 = @operandos.pop
                    @tmp_var_id += 1
                    @operandos.push "t#{@tmp_var_id}"
                    puts "#{op}\t#{oper1}\t#{oper}\tt#{@tmp_var_id}"
                end
            when nivel == 3
                if(op == "=")
                    @poper.pop
                    oper = @operandos.pop
                    oper1 = @operandos.pop
                    # @tmp_var_id += 1
                    @operandos.push oper1
                    puts "#{op}\t#{oper}\t\t#{oper1}"
                end
            end
        end
    end

    def fun4
    end

    def fun5
    end

    def on_error(t,val,vstack)
        raise ParseError, sprintf("\nError de sintaxis. Se encontro %s (%s) inesperado", val.inspect, token_to_str(t) || '?')
    end
