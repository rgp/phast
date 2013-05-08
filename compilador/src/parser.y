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

phast :  PH_OT class_decs estatutos PH_CT {}
class_decs: bloque_class class_decs
          |
estatutos: estatuto estatutos
         |
estatuto : expresion ';' { vaciar_pOperandos } /* Vaciar pila y temporales */ 
         | bloque_while
         | bloque_do 
         | bloque_verbose
         | bloque_if
         | bloque_for
         | bloque_fun { disminuye_scope }
         | WORD_RETURN expresion {return_quad } ';' { vaciar_pOperandos }
# Expresiones
expresion: comparando {fun3 2} comparando_aux
comparando_aux: op_comp {fun2} comparando {fun3 2} comparando_aux
           |
comparando: termino {fun3 1} termino_aux
termino_aux: op_term {fun2} termino {fun3 1} termino_aux
           | 
termino: factor_unary_operand {fun3 0} factor_aux
factor_aux: op_fact {fun2} factor_unary_operand {fun3 0} factor_aux 
          | 
factor_unary_operand: factor    
             |  op_unary {@pOper.push Phast::NOT} factor {fun3 -1}
factor: llamada 
      | estatico {fun1(llama_cte(@curr_token[1])) }
      |  arreglo 
      | '('{fun4} expresion ')'{fun5}
llamada: ID tipo_llamada 
       | OP_INCREMENT ID { pre_affect "+" }
       | OP_DECREMENT ID { pre_affect "-" }
       | WORD_NEW CLASS_ID { crea_instancia } '(' ')'
tipo_llamada: { fun1(llame_var(@prev_token[1])) } vars 
            | funcs
funcs: { fun_prepare @prev_token[1] } {@pArgs.push []} '(' argumentos ')' { fun_call }
vars: arr_acc asign
    | { post_affect "+" } OP_INCREMENT
    | { post_affect "-" } OP_DECREMENT
    | { @inst = @prev_token[1] } '.' ID { llame_attr @curr_token[1] } arr_acc asign
arr_acc:  { load_arr } '[' expresion { access_array_index } ']'  arr_acc
       |
asign: OP_ASIGN {fun2} expresion {fun3 3}  
     |
estatico: numero
        | STRING { guarda_cte @curr_token[1], String(@curr_token[1]) , 4 }
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
       | WORD_XOR

op_term: OP_PLUS
       | OP_MINUS
op_fact: OP_MULTIPLY
       | OP_DIVIDE
op_unary: WORD_NOT
numero: int
      | float
int : INT { guarda_cte @curr_token[1], Integer(@curr_token[1]) , 2 }
float: FLOAT { guarda_cte @curr_token[1], Float(@curr_token[1]) , 3 }
arreglo: { openArreglo } '[' arr_elems ']' { closeArreglo }
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
bloque_verbose :  BLOCK_VERBOSE  { verbose @curr_token[1] }
bloque_for : WORD_FOR '('comparando ';' expresion ';' expresion ')' '{' estatutos '}'
bloque_fun : WORD_FUN fun_mem ID { aumenta_scope @curr_token[1] } { memento } '(' params ')' '{' estatutos { end_fun } '}'
fun_mem: {@mem = true } WORD_MEM
       |
bloque_class: WORD_CLASS CLASS_ID { define_objeto @curr_token[1] } class_extras '{' class_body '}' { termina_objeto }
class_body: class_body_aux  class_body
           |
class_body_aux: /* NOMBRE COMPLETO CLASE*/ bloque_fun 
           | ID { define_attr @curr_token[1] } class_def_var_aux ';' { vaciar_pOperandos }
class_def_var_aux: OP_ASIGN {fun2} pos_vars { asign_attr }
                  |
pos_vars: estatico {fun1(llama_cte(@curr_token[1])) }
        | arreglo 
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
require_relative 'lib/Objeto'

---- inner ----

    def initialize(scanner,output = "bin.pho")
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
        @pArgs = []

        @object_def = {}
        @inst_defs = []

        @verboseCount = 0;
        @outfile = output
        @mem = false


    end

    def parse #Parsea mami parsea
        do_parse
        process_output
    end

    def next_token  #Correr tokens
        @prev_token = @curr_token
        @curr_token = @scanner.next_token
    end

    def crea_instancia
        clase = @curr_token[1]

        @pFnCall.push genera(Phast::CALL,nil,nil,clase)
        tmp = Var.new(nil,[:object,clase],nil,@scope_actual.temporales.length,nil)
        @scope_actual.temporales.push tmp
        @pOperandos.push tmp
        genera(Phast::REV,nil,nil,tmp)
    end

    def llame_attr cual
        inst = @scope_actual.variables[@inst]
        if !inst.tipoDato.kind_of?(Array)
            p "Error, #{@inst} no es un objeto"
            exit
        end

        class_def = @object_def[inst.tipoDato[1]]

        if class_def.attributos.include? cual
            class_def.attributos[cual]
        else
            p "Error objeto: #{@inst} no contiene atributo #{cual}"
            exit
        end
        inst = @pOperandos.pop
        tmp = Var.new(nil,nil,nil,@scope_actual.temporales.length,nil)
        @scope_actual.temporales.push tmp
        genera(Phast::ATTR_ACC,inst,class_def.attributos[cual],tmp)
        @pOperandos.push tmp
    end

    def define_objeto quien
        if( @object_def.include? quien)
            p "Error, clase #{quien} previamente definida"
            exit
        end
        @obejota = Objeto.new(quien,@scope_actual)
        aumenta_scope quien
        v = Var.new(nil,nil,nil,@scope_actual.temporales.length,nil)
        @obejota.id = v
        @scope_actual.temporales.push v
        genera(Phast::OBJ,nil,nil,v)
    end

    def define_attr nombre
        guarda_var nombre
        v = Var.new(nombre,nil,nil,@obejota.attributos.length,$lineno)
        @pOperandos.push v
        @obejota.attributos[nombre] = v
    end

    def asign_attr
        @pOper.pop
        oper = @pOperandos.pop
        oper1 = @pOperandos.last
        if oper.tipoDato.kind_of?(Array)
            oper1.tipoDato = oper.tipoDato
        end
        genera(Phast::ATTR, oper, @obejota.id, oper1)
    end

    def termina_objeto
        @object_def[@obejota.nombre] = @obejota
        genera(Phast::RET,nil,nil,@scope_actual.temporales.first)
        disminuye_scope
    end

    def pre_affect (op)
        uno = guarda_cte("1",1,2) # Guardamos la constante 1
        var = llame_var @curr_token[1]

        # Partiendo de que ++a === (a=a+1) =>
        fun4 # Metemos fondo falso
        @pOperandos.push var # Metemos "a"
        @pOper.push Phast.op_to_inst("=")  #fun2 metemos "="
        fun1 var  # Metemos "a"
        @pOper.push Phast.op_to_inst(op)  #fun2 metemos suma o resta
        @pOperandos.push uno  # metemos el 1
        fun3_aux # generamos cuádruplo de suma
        fun3 3 # Generamos cuádruplo de asignación de resultado en var
        fun5 # Quitamos fondo falso
    end

    def post_affect (op)
        uno = guarda_cte("1",1,2) # Guardamos la constante 1
        val_actual = Var.new(nil,nil,nil,@scope_actual.temporales.length,nil)
        @scope_actual.temporales.push val_actual
        mas_uno = Var.new(nil,nil,nil,@scope_actual.temporales.length,nil)
        @scope_actual.temporales.push mas_uno
        var = @pOperandos.pop
        @pOperandos.push val_actual
        genera(Phast::ASIG, var, nil, val_actual)
        genera(Phast.op_to_inst(op), var, uno, mas_uno) # incrementa/decrementa
        genera(Phast::ASIG, mas_uno, nil, var)
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
        arr_tmp = @pOperandos.pop
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

    def aumenta_scope nombre, is_class = false
        if( @scopes.include? nombre )
            p "Error #{nombre} previamente definido"
            exit
        end
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
        @scope_actual.quads.concat @pArgs.pop
        cual = @funToCall.pop
        if(cual == "print")
            genera(Phast::PRT,nil,nil,nil)
        elsif(cual == "println")
            genera(Phast::PRTLN,nil,nil,nil)
        elsif(cual == "link")
            genera(Phast::LNK,nil,nil,nil)
        elsif(cual == "link_hard")
            genera(Phast::LNKH,nil,nil,nil)
        elsif(cual == "exists")
            tmp = Var.new(nil,nil,nil,@scope_actual.temporales.length,nil)
            @scope_actual.temporales.push tmp
            @pOperandos.push tmp
            genera(Phast::EXST,nil,nil,tmp)
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
        @pArgs.last.push Quad.new(Phast::ARG,nil,nil,@pOperandos.pop)
    end

    def memento
        if @mem
            genera(Phast::MEM,nil,nil,nil)
        end
    end

    def return_quad
        genera(Phast::RET,nil,nil,@pOperandos.last)
    end

    def end_fun
        @mem = false
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
            when nivel == -1
                if(op == Phast::NOT)
                    fun3_aux2
                end
            when nivel == 0
                if(op == Phast::MUL || op == Phast::DIV)
                    fun3_aux
                end
            when nivel == 1
                if(op == Phast::SUM || op == Phast::REST)
                    fun3_aux
                end
            when nivel == 2
                if(op == Phast::AND || op == Phast::OR || op == Phast::XOR || op == Phast::GT || op == Phast::LT || op == Phast::ELT || op == Phast::EGT || op == Phast::EQ || op == Phast::NOTEQ)
                    fun3_aux
                end
            when nivel == 3
                if(op == Phast::ASIG)
                    @pOper.pop
                    oper = @pOperandos.pop
                    oper1 = @pOperandos.last
                    if oper.tipoDato.kind_of?(Array)
                        oper1.tipoDato = oper.tipoDato
                    end
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

    def fun3_aux2
        op = @pOper.pop
        oper = @pOperandos.pop
        tmp = Var.new(nil,nil,nil,@scope_actual.temporales.length,nil)
        @scope_actual.temporales.push tmp
        @pOperandos.push tmp

        genera(op, oper, nil, @pOperandos.last)
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

        @reg_counter = 0 
        @mem_offset = 0

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

        @mem_offset = 0
        @mem_offset += scope_global.variables.length
        scope_global.temporales.each do |v|
            v.direccion_virtual += @mem_offset
        end
        
        @salida[0] = @reg_counter
        print_quads scope_global.quads

        @pFnCall.each do |q|
            if( @scopes[q.registro] == nil)
                p "Funcion #{q.registro} indefinida"
                exit
            end
            q.op1 = @scopes[q.registro].variables.length
            q.op2 = @scopes[q.registro].temporales.length
            q.registro = @scopes[q.registro].registro
        end

        # puts @salida
        # print @salida
        write_file @salida
        puts "Compiled #{$lineno} lines."
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

    def write_file(lines)
        fout = File.open(@outfile, 'w')
        # fout.puts lines
        lines.each do |l|
            fout.puts l.to_s + "\0"
        end
        fout.close
    end

    def on_error(t,val,vstack)
        raise ParseError, sprintf("\nError de sintaxis. Se encontro %s (%s) inesperado en la linea #{$lineno}", val.inspect, token_to_str(t) || '?')
    end

    def verbose (v)
        v_exec = guarda_cte "verbose"+String(@verboseCount), String(v), 4
        @verboseCount += 1
        genera(Phast::VERB, nil, nil, v_exec)
    end
