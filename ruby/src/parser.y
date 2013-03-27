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
expresion: comparando {} comparando_aux
comparando_aux: op_comp {} comparando {} comparando_aux
           |
comparando: termino {} termino_aux
termino_aux: op_term {} termino {} termino_aux
           | 
termino: factor {} factor_aux
factor_aux: op_fact {} factor {} factor_aux 
          | 
factor: llamada 
      | estatico {}
llamada: ID { llame_var } id_call
estatico: numero
        | STRING
        | arreglo
        /*| OP_INCREMENT ID {}*/
        /*| OP_DECREMENT ID {}*/
        | WORD_TRUE
        | WORD_FALSE
        | WORD_NULL
        | '('{} expresion ')'{}

id_call: '(' argumentos ')'
        | '[' expresion ']'
        /*| OP_INCREMENT*/
        /*| OP_DECREMENT*/
        | OP_ASIGN expresion {} 
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
        @scopes.last[@curr_token[1]] = [$lineno]
    end

    def aumenta_scope
        @scopes.push Hash.new
    end

    def disminuye_scope
        @scopes.pop
    end

    def on_error(t,val,vstack)
        raise ParseError, sprintf("\nError de sintaxis. Se encontro %s (%s) inesperado", val.inspect, token_to_str(t) || '?')
    end
