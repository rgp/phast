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
estatuto : expresion ';' { vaciar_pOperandos } /* Vaciar pila y temporales */ 
         | bloque_while
         | bloque_do 
         | bloque_verbose
         | bloque_if
         | bloque_for
         | bloques_declarativos { disminuye_scope }
         | WORD_RETURN expresion {return_quad } ';' { vaciar_pOperandos }
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
      | estatico {fun1(llama_cte(@curr_token[1])) }
      | { openArreglo } arreglo { closeArreglo }
      | '('{fun4} expresion ')'{fun5}
llamada: ID tipo_llamada 

tipo_llamada: { fun1(llame_var(@prev_token[1])) } vars 
            | funcs
funcs: { fun_prepare @prev_token[1] } '(' argumentos ')' { fun_call }
        /*| OP_INCREMENT*/
        /*| OP_DECREMENT*/
vars: arr_acc asign
    | asign
arr_acc: '[' expresion { access_array_index } ']' arr_acc
       |
asign: OP_ASIGN {fun2} expresion {fun3 3}  
     |
estatico: numero
        | STRING { guarda_cte @curr_token[1], String(@curr_token[1]) , 4 }
        /*| OP_INCREMENT ID {}*/
        /*| OP_DECREMENT ID {}*/
        | WORD_TRUE { guarda_cte @curr_token[1], true , 1 }
        | WORD_FALSE { guarda_cte @curr_token[1], false , 1 }
        | WORD_NULL { guarda_cte @curr_token[1], nil , 0 }
argumentos:  expresion { argument } args_aux
          |
args_aux: ',' expresion { argument } args_aux
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

numero: int
      | float
int : INT { guarda_cte @curr_token[1], Integer(@curr_token[1]) , 2 }
float: FLOAT { guarda_cte @curr_token[1], Float(@curr_token[1]) , 3 }
arreglo: '[' arr_elems ']'
arr_elems: arr_elem arr_elems_aux
          |
arr_elems_aux: ',' arr_elem arr_elems_aux
          | 
arr_elem: arr_elem_wrapper { copy_value } 
arr_elem_wrapper: expresion 
              /*| int OP_KEYVAL expresion */
# Bloques
bloque_if : WORD_IF  '(' expresion ')' {if_quad 1} '{' estatutos '}' else {if_quad 2} 
else: WORD_ELSE {if_quad 3} aux_else
     |
aux_else: bloque_if
       | '{' estatutos '}'
bloque_while : WORD_WHILE {while_quad 1} '(' expresion ')' {while_quad 2} '{' estatutos '}' {while_quad 3}
bloque_do : WORD_DO {do_while_quad 1} '{' estatutos '}' WORD_WHILE '(' expresion ')' {do_while_quad 2} ';' 
bloque_verbose :  {p @curr_token} BLOCK_VERBOSE  { verbose @curr_token[1] }
bloque_for : WORD_FOR '('comparando ';' expresion ';' expresion ')' '{' estatutos '}'
bloque_fun : WORD_FUN ID { aumenta_scope @curr_token[1] } '(' params ')' '{' estatutos { end_fun } '}'

bloque_class: WORD_CLASS ID { aumenta_scope @curr_token[1] } class_extras '{' class_body '}'
class_body: class_body_aux  class_body
           |
class_body_aux: /* NOMBRE COMPLETO  CLASE*/ bloque_fun { disminuye_scope }
           | ID { llame_var @curr_token[1] } class_def_var_aux ';'
class_def_var_aux: OP_ASIGN 
                  |
class_extras: WORD_EXTENDS ID
             |

params: ID { param(llame_var(@curr_token[1])) }  def_param params_aux
       |
params_aux: ','  ID { param(llame_var(@curr_token[1])) } def_param params_aux
           |
def_param: '=' estatico { fun1(llama_cte(@curr_token[1])) }
          |
end

---- header ----

require_relative 'lib/Quad'
require_relative 'lib/Scope'
require_relative 'lib/Var'
require_relative 'lib/Arr'
require_relative 'lib/Instrucciones'

---- inner ----

    def initialize(scanner)
        #Lexico
        @scanner = scanner
        @curr_token = nil #Token en análisis
        @prev_token = nil #Token anterior

        #Scopes
        @scopes = {:global => Scope.new(nil), :constantes => Scope.new(nil)} #Hash de objetos Scope
        @scopes[:constantes].variables[:lng_ver] = Var.new(1.0,3,1.0,0,-1)
        @scope_actual = @scopes[:global]
        
        #Pilas
        @pOper = [] #Pila de operadores
        @pOperandos = [] #Pila de operandos (Vars)
        @pSaltos = [] #Pila para saltos (if,else, etc.)
        @pFnCall = [] #Pila de llamadas pendientes (Quads)
        @funToCall = []
        
        @pArr = []

        @verboseCount = 0;


    end

    def parse #Parsea mami parsea
        do_parse
        process_output
    end

    def next_token  #Correr tokens
        @prev_token = @curr_token
        @curr_token = @scanner.next_token
    end

    def load_arr
        arr_id = @pOperandos.pop
        tmp = Var.new(nil,nil,nil,@scope_actual.temporales.length,nil)
        @scope_actual.temporales.push tmp
        @pOperandos.push tmp
        genera(Phast::ARRLD,arr_id,nil,tmp)
    end

    def access_array_index
        arr_index = @pOperandos.pop
        arr_tmp = @pOperandos.last
        genera(Phast::ARRVAL,arr_index,arr_tmp,nil) # VAL RNG
        tmp = Var.new(nil,nil,nil,@scope_actual.temporales.length,nil)
        @scope_actual.temporales.push tmp
        genera(Phast::ARRIND,arr_tmp,arr_index,tmp)
        @pOperandos.push tmp
    end

    def openArreglo
        tmp = ArrDefinition.new(Var.new(nil,nil,nil,@scope_actual.temporales.length,nil))
        @scope_actual.temporales.push tmp.id
        @pArr.push tmp
    end

    def closeArreglo
        arr = @pArr.pop
        genera(Phast::ARRDEC,arr.length,nil,arr.id)
        arr.initQuads.each do |q|
            @scope_actual.quads.push q
        end
        @pOperandos.push arr.id
    end

    def copy_value
        de = @pOperandos.pop
        @pArr.last.initQuads.push Quad.new(Phast::ARRINI, de, @pArr.last.id, @pArr.last.length)
        @pArr.last.length += 1
    end

    def llame_var cual
        if @scope_actual.variables.include? cual
            @scope_actual.variables[cual]
        else
            if @pArr.last != nil
                guarda_cte("NULL",nil,0)
            else
                guarda_var cual
            end
        end
    end

    def guarda_var nombre
        @scope_actual.variables[nombre] = Var.new(nombre,nil,nil,@scope_actual.variables.length,$lineno)
    end

    def guarda_cte(nombre,valor,tipo)
        if !@scopes[:constantes].variables.include? nombre
            @scopes[:constantes].variables[nombre] = Var.new(valor,tipo,valor,@scopes[:constantes].variables.length,$lineno)
        else
            return @scopes[:constantes].variables[nombre]
        end
    end

    def llama_cte nombre
        cte = @scopes[:constantes].variables[nombre]
        return cte
    end

    def vaciar_pOperandos
        while !@pOperandos.empty?
            @pOperandos.pop
        end
    end

    def aumenta_scope nombre
        nuevo_scope = Scope.new(@scope_actual)
        @scope_actual = nuevo_scope
        @scopes[nombre] = @scope_actual
    end

    def disminuye_scope
        @scope_actual = @scope_actual.papa
    end
    
    def rellena(quad)
        quad.registro = @scope_actual.quads.length
    end

    def genera(w,x,y,z)
        tmp = Quad.new(w,x,y,z)
        @scope_actual.quads.push tmp
        tmp
    end

    def fun_prepare cual
        @funToCall.push cual
        @pOper.push "("
    end
        

    def fun_call
        if @funToCall.last == nil
            p "Compile Error"
            exit
        end
        cual = @funToCall.pop
        if(cual == "print")
            genera(Phast::PRT,nil,nil,nil)
        elsif(cual == "println")
            genera(Phast::PRTLN,nil,nil,nil)
        else
            @pFnCall.push genera(Phast::CALL,nil,nil,cual)
            tmp = Var.new(nil,nil,nil,@scope_actual.temporales.length,nil)
            @scope_actual.temporales.push tmp
            @pOperandos.push tmp
            genera(Phast::REV,nil,nil,tmp)
        end
        @pOper.pop
    end

    def argument
        genera(Phast::ARG,nil,nil,@pOperandos.pop)
    end

    def return_quad
        genera(Phast::RET,nil,nil,@pOperandos.last)
    end

    def end_fun
        return_quad
    end
    
    def param variable
        genera(Phast::PAR,nil,nil,variable)
    end
    
    def fun1 cual
        @pOperandos.push cual
    end

    def fun2
        @pOper.push Phast.op_to_inst(@curr_token[1])
    end

    def fun3(nivel)
        # puts "Checar el top de Poper tiene operador pendiente"
        if !@pOper.empty?
            op = @pOper.last
            case
            when nivel == 0
                if(op == Phast::MUL || op == Phast::DIV)
                    fun3_aux
                end
            when nivel == 1
                if(op == Phast::SUM || op == Phast::REST)
                    fun3_aux
                end
            when nivel == 2
                if(op == Phast::AND || op == Phast::OR || op == Phast::GT || op == Phast::LT || op == Phast::ELT || op == Phast::EGT || op == Phast::EQ)
                    fun3_aux
                end
            when nivel == 3
                if(op == Phast::ASIG)
                    @pOper.pop
                    oper = @pOperandos.pop
                    oper1 = @pOperandos.last
                    genera(op, oper, nil, oper1)
                end
            end
        end
    end

    def fun3_aux
        op = @pOper.pop
        oper = @pOperandos.pop
        oper1 = @pOperandos.pop
        tmp = Var.new(nil,nil,nil,@scope_actual.temporales.length,nil)
        @scope_actual.temporales.push tmp
        @pOperandos.push tmp

        genera(op, oper1, oper, @pOperandos.last)
    end

    def fun4
        @pOper.push "("
    end
    def fun5
        @pOper.pop
    end

    def if_quad(step)
        case
        when step == 1
            condicion = @pOperandos.pop
            @pSaltos.push genera(Phast::GOTOF, condicion, nil, nil)
        when step ==  2
            rellena(@pSaltos.pop)
        when step == 3
            f = @pSaltos.pop
            @pSaltos.push genera(Phast::GOTO, nil, nil, nil)
            rellena(f)
        end
    end

    def while_quad(step)
        case
        when step == 1
            @pSaltos.push @scope_actual.quads.length #Valor deshechable
        when step ==  2
            condicion = @pOperandos.pop
            @pSaltos.push genera(Phast::GOTOF, condicion, nil, nil)
        when step == 3
            f = @pSaltos.pop
            genera(Phast::GOTO, nil, nil, @pSaltos.pop)
            rellena(f)
        end
    end

    def do_while_quad(step)
        case
        when step == 1
            @pSaltos.push @scope_actual.quads.length
        when step ==  2
            condicion = @pOperandos.pop
            genera(Phast::GOTOV, condicion, nil, @pSaltos.pop)
        end
    end

    def process_output

        @reg_counter = 0 #TODO
        @mem_offset = 0 #TODO

        @salida = [0]

        @salida.push @scopes[:constantes].variables.length
        @salida.push @scopes[:global].variables.length
        @salida.push @scopes[:global].temporales.length

        @scopes[:constantes].variables.each do |k,c|
            @salida.push "#{c.direccion_virtual}\t#{c.tipoDato}\t#{c.valor}"
        end

        scope_global = @scopes.delete(:global)
        scope_constantes = @scopes.delete(:constantes)
        
        @scopes.each do |key, s|
            s.registro = @reg_counter
            @mem_offset = s.variables.length
            s.temporales.each do |v|
                v.direccion_virtual += @mem_offset
            end
            print_quads s.quads
        end

        @mem_offset = 0 #scope_constantes.variables.length
        #Correr variables
        # scope_global.variables.each do |k,v|
        #     v.direccion_virtual += @mem_offset
        # end

        @mem_offset += scope_global.variables.length
        scope_global.temporales.each do |v|
            v.direccion_virtual += @mem_offset
        end
        
        @salida[0] = @reg_counter
        print_quads scope_global.quads

        @pFnCall.each do |q|
            q.op1 = @scopes[q.registro].variables.length
            q.op2 = @scopes[q.registro].temporales.length
            q.registro = @scopes[q.registro].registro
        end

        puts @salida
        # print @salida

    end

    def print_quads(quads)
        reg_offset = @reg_counter
        until quads.empty?
            quad = quads.shift
            quad.saltos reg_offset
            @salida.push quad
            @reg_counter += 1
        end
    end

    def on_error(t,val,vstack)
        raise ParseError, sprintf("\nError de sintaxis. Se encontro %s (%s) inesperado en la linea #{$lineno}", val.inspect, token_to_str(t) || '?')
    end

    def verbose (v)
        genera(Phast::VERB, nil, nil, (-1)*@scopes[:constantes].variables.count)
        guarda_cte "verbose"+String(@verboseCount), String(v), 4
        @verboseCount += 1
    end
