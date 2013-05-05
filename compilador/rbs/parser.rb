#
# DO NOT MODIFY!!!!
# This file is automatically generated by Racc 1.4.9
# from Racc grammer file "".
#

require 'racc/parser.rb'


require_relative 'lib/Quad'
require_relative 'lib/Scope'
require_relative 'lib/Var'
require_relative 'lib/Arr'
require_relative 'lib/Instrucciones'

module Phast
  class Parser < Racc::Parser

module_eval(<<'...end parser.y/module_eval...', 'parser.y', 151)

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

        @verboseCount = 0;
        @outfile = output


    end

    def parse #Parsea mami parsea
        do_parse
        process_output
    end

    def next_token  #Correr tokens
        @prev_token = @curr_token
        @curr_token = @scanner.next_token
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
        p @pOperandos
        p @pOper
        fun3_aux # generamos cuádruplo de suma
        p @pOperandos
        p @pOper
        fun3 3 # Generamos cuádruplo de asignación de resultado en var
        fun5 # Quitamos fondo falso
    end

    def post_affect (op)
        var = @prev_token[1]
        p var
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
        fout.puts lines
        fout.close
    end

    def on_error(t,val,vstack)
        raise ParseError, sprintf("\nError de sintaxis. Se encontro %s (%s) inesperado en la linea #{$lineno}", val.inspect, token_to_str(t) || '?')
    end

    def verbose (v)
        genera(Phast::VERB, nil, nil, (-1)*@scopes[:constantes].variables.count)
        guarda_cte "verbose"+String(@verboseCount), String(v), 4
        @verboseCount += 1
    end
...end parser.y/module_eval...
##### State transition tables begin ###

racc_action_table = [
    13,    22,   135,    23,    24,    25,   -35,    79,    80,    27,
    28,    29,    30,    13,    22,   119,    23,    24,    25,   -35,
   158,   114,    27,    28,    29,    30,    33,    34,    35,    83,
    84,   113,    36,    37,  -107,    39,    40,    41,   158,    33,
    34,    35,    83,    84,   122,    36,    37,  -107,    39,    40,
    41,    13,    22,    40,    23,    24,    25,   -35,    35,   202,
    27,    28,    29,    30,    13,    22,   123,    23,    24,    25,
   -35,    40,   125,    27,    28,    29,    30,    33,    34,    35,
    79,    80,    96,    36,    37,  -107,    39,    40,    41,   111,
    33,    34,    35,   110,   108,   104,    36,    37,  -107,    39,
    40,    41,    13,    22,   100,    23,    24,    25,   -35,   132,
   115,    27,    28,    29,    30,    13,    22,   136,    23,    24,
    25,   -35,    99,   139,    27,    28,    29,    30,    33,    34,
    35,   140,   141,   110,    36,    37,  -107,    39,    40,    41,
   148,    33,    34,    35,   149,   151,   152,    36,    37,  -107,
    39,    40,    41,    13,    22,   153,    23,    24,    25,   -35,
    97,    65,    27,    28,    29,    30,    13,    22,    64,    23,
    24,    25,   -35,    63,   162,    27,    28,    29,    30,    33,
    34,    35,    62,    59,   165,    36,    37,  -107,    39,    40,
    41,   166,    33,    34,    35,    58,   168,   170,    36,    37,
  -107,    39,    40,    41,    22,   171,    23,    24,    25,    57,
   -53,   176,    27,    28,    29,    30,    22,   -45,    23,    24,
    25,    51,   179,    45,    27,    28,    29,    30,   182,    33,
    34,    43,   -49,   -51,   -53,    22,    96,    23,    24,    25,
   185,    33,    34,    27,    28,    29,    30,    22,   148,    23,
    24,    25,   188,   189,   190,    27,    28,    29,    30,   191,
    33,    34,   193,   194,    42,   198,    22,     2,    23,    24,
    25,   203,    33,    34,    27,    28,    29,    30,    22,   204,
    23,    24,    25,   170,     3,   182,    27,    28,    29,    30,
   208,    33,    34,   nil,   nil,   nil,   nil,    22,   nil,    23,
    24,    25,   nil,    33,    34,    27,    28,    29,    30,    22,
   nil,    23,    24,    25,   nil,   nil,   nil,    27,    28,    29,
    30,   nil,    33,    34,   nil,   nil,   nil,   nil,    22,   nil,
    23,    24,    25,   nil,    33,    34,    27,    28,    29,    30,
    22,   nil,    23,    24,    25,   nil,   nil,   nil,    27,    28,
    29,    30,   nil,    33,    34,    69,    70,    71,    72,    73,
    74,    75,    76,   nil,   nil,    33,    34,    22,   nil,    23,
    24,    25,   nil,   -89,   nil,    27,    28,    29,    30,    22,
   nil,    23,    24,    25,   nil,   nil,   nil,    27,    28,    29,
    30,   nil,    33,    34,   nil,   nil,   nil,   nil,    22,   nil,
    23,    24,    25,   nil,    33,    34,    27,    28,    29,    30,
    22,   nil,    23,    24,    25,   nil,   nil,   nil,    27,    28,
    29,    30,   nil,    33,    34,   nil,   nil,   nil,   nil,    22,
   nil,    23,    24,    25,   nil,    33,    34,    27,    28,    29,
    30,    22,   nil,    23,    24,    25,   nil,   nil,   nil,    27,
    28,    29,    30,   nil,    33,    34,    27,    28,    29,    30,
    22,   -67,    23,    24,    25,   nil,    33,    34,    27,    28,
    29,    30,   nil,    33,    34,    69,    70,    71,    72,    73,
    74,    75,    76,   nil,   nil,    33,    34 ]

racc_action_check = [
     2,     2,   120,     2,     2,     2,     2,   143,   143,     2,
     2,     2,     2,   202,   202,    98,   202,   202,   202,   202,
   156,    94,   202,   202,   202,   202,     2,     2,     2,   144,
   144,    93,     2,     2,     2,     2,     2,     2,   140,   202,
   202,   202,    49,    49,   101,   202,   202,   202,   202,   202,
   202,   165,   165,   156,   165,   165,   165,   165,   195,   195,
   165,   165,   165,   165,   191,   191,   102,   191,   191,   191,
   191,   140,   103,   191,   191,   191,   191,   165,   165,   165,
    48,    48,    91,   165,   165,   165,   165,   165,   165,    89,
   191,   191,   191,    86,    85,    66,   191,   191,   191,   191,
   191,   191,   100,   100,    61,   100,   100,   100,   100,   117,
    95,   100,   100,   100,   100,   149,   149,   121,   149,   149,
   149,   149,    60,   123,   149,   149,   149,   149,   100,   100,
   100,   124,   125,   129,   100,   100,   100,   100,   100,   100,
   133,   149,   149,   149,   134,   136,   137,   149,   149,   149,
   149,   149,   149,   168,   168,   138,   168,   168,   168,   168,
    56,    41,   168,   168,   168,   168,     5,     5,    40,     5,
     5,     5,     5,    39,   146,     5,     5,     5,     5,   168,
   168,   168,    38,    35,   150,   168,   168,   168,   168,   168,
   168,   151,     5,     5,     5,    25,   153,   154,     5,     5,
     5,     5,     5,     5,   148,   155,   148,   148,   148,    24,
   162,   164,   148,   148,   148,   148,   152,    23,   152,   152,
   152,    21,   167,     6,   152,   152,   152,   152,   169,   148,
   148,     4,    54,    54,    54,    13,    54,    13,    13,    13,
   173,   152,   152,    13,    13,    13,    13,   166,   175,   166,
   166,   166,   176,   177,   178,   166,   166,   166,   166,   179,
    13,    13,   182,   184,     3,   192,   105,     0,   105,   105,
   105,   196,   166,   166,   105,   105,   105,   105,   106,   197,
   106,   106,   106,   199,     1,   205,   106,   106,   106,   106,
   206,   105,   105,   nil,   nil,   nil,   nil,   107,   nil,   107,
   107,   107,   nil,   106,   106,   107,   107,   107,   107,   110,
   nil,   110,   110,   110,   nil,   nil,   nil,   110,   110,   110,
   110,   nil,   107,   107,   nil,   nil,   nil,   nil,   116,   nil,
   116,   116,   116,   nil,   110,   110,   116,   116,   116,   116,
   115,   nil,   115,   115,   115,   nil,   nil,   nil,   115,   115,
   115,   115,   nil,   116,   116,   142,   142,   142,   142,   142,
   142,   142,   142,   nil,   nil,   115,   115,    51,   nil,    51,
    51,    51,   nil,    51,   nil,    51,    51,    51,    51,    52,
   nil,    52,    52,    52,   nil,   nil,   nil,    52,    52,    52,
    52,   nil,    51,    51,   nil,   nil,   nil,   nil,    63,   nil,
    63,    63,    63,   nil,    52,    52,    63,    63,    63,    63,
    99,   nil,    99,    99,    99,   nil,   nil,   nil,    99,    99,
    99,    99,   nil,    63,    63,   nil,   nil,   nil,   nil,    59,
   nil,    59,    59,    59,   nil,    99,    99,    59,    59,    59,
    59,   122,   nil,   122,   122,   122,   nil,   nil,   nil,   122,
   122,   122,   122,   nil,    59,    59,   170,   170,   170,   170,
    97,    97,    97,    97,    97,   nil,   122,   122,    97,    97,
    97,    97,   nil,   170,   170,    47,    47,    47,    47,    47,
    47,    47,    47,   nil,   nil,    97,    97 ]

racc_action_pointer = [
   265,   284,    -5,   264,   228,   161,   219,   nil,   nil,   nil,
   nil,   nil,   nil,   229,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   210,   nil,   211,   201,   187,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   177,   nil,   nil,   143,   167,
   160,   153,   nil,   nil,   nil,   nil,   nil,   456,    53,    13,
   nil,   361,   373,   nil,   223,   nil,   154,   nil,   nil,   423,
   116,    70,   nil,   392,   nil,   nil,    91,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,    82,    75,   nil,   nil,    82,
   nil,    69,   nil,    22,    11,    99,   nil,   454,     8,   404,
    97,    40,    60,    29,   nil,   260,   272,   291,   nil,   nil,
   303,   nil,   nil,   nil,   nil,   334,   322,   102,   nil,   nil,
    -5,    82,   435,   115,    97,   124,   nil,   nil,   nil,   115,
   nil,   nil,   nil,   122,   110,   nil,   108,   142,   148,   nil,
    30,   nil,   336,   -20,     0,   nil,   162,   nil,   198,   110,
   150,   185,   210,   162,   153,   170,    12,   nil,   nil,   nil,
   nil,   nil,   199,   nil,   176,    46,   241,   215,   148,   210,
   442,   nil,   nil,   227,   nil,   230,   216,   218,   247,   225,
   nil,   nil,   254,   nil,   259,   nil,   nil,   nil,   nil,   nil,
   nil,    59,   230,   nil,   nil,    25,   267,   244,   nil,   239,
   nil,   nil,     8,   nil,   nil,   267,   255,   nil,   nil ]

racc_action_default = [
  -132,  -132,    -3,  -132,  -132,    -3,  -132,    -5,    -6,    -7,
    -8,    -9,   -10,   -35,   -13,   -14,   -15,   -21,   -27,   -33,
   -34,  -132,   -37,   -42,  -132,  -132,   -60,   -61,   -62,   -63,
   -64,   -83,   -84,   -85,   -86,  -132,  -101,  -104,  -132,  -132,
  -132,  -132,   209,    -1,    -2,    -4,   -11,   -20,   -26,   -32,
   -36,   -35,   -35,   -39,   -56,   -44,  -132,   -40,   -41,   -35,
  -132,  -132,  -108,   -35,  -110,  -113,  -132,   -16,   -17,   -71,
   -72,   -73,   -74,   -75,   -76,   -77,   -78,   -22,   -23,   -79,
   -80,   -28,   -29,   -81,   -82,  -132,   -91,   -92,   -93,  -132,
   -43,   -59,   -48,  -132,  -132,  -132,   -57,   -35,  -132,   -35,
    -3,  -132,  -132,  -123,   -12,   -35,   -35,   -35,   -87,   -88,
   -35,   -38,   -47,   -50,   -52,   -35,   -35,  -132,   -65,   -94,
  -132,  -132,   -35,  -126,  -132,  -132,   -18,   -24,   -30,   -91,
   -54,   -58,   -46,   -70,  -132,  -102,  -132,  -132,  -132,  -124,
  -116,  -122,   -20,   -26,   -32,   -90,  -132,   -66,   -35,    -3,
  -132,  -132,   -35,  -132,  -131,  -132,  -116,  -117,  -118,   -19,
   -25,   -31,   -56,   -68,  -132,    -3,   -35,  -132,    -3,  -129,
  -132,  -114,  -115,  -121,   -55,   -70,   -98,  -132,  -132,  -132,
  -111,  -125,  -132,  -130,  -132,  -120,   -69,   -95,   -96,  -103,
  -105,    -3,  -132,  -127,  -119,  -132,  -132,  -132,  -112,  -131,
   -97,   -99,    -3,  -106,  -109,  -129,  -132,  -128,  -100 ]

racc_goto_table = [
     4,    91,    46,    44,    86,    67,    81,    77,   169,   109,
    92,   157,   101,   147,   181,   155,    60,   128,   106,    49,
   107,   144,   183,    50,    52,    53,    90,   157,    55,    54,
   117,   172,    56,    48,   127,    93,    94,   146,   116,   142,
    88,    89,   133,   175,    85,   105,    47,   112,    98,   187,
   207,   134,   145,   205,   126,   186,   200,   195,   143,   150,
    61,   196,   138,   129,   102,   192,   124,    66,   103,   184,
   173,   201,     1,   154,   199,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   118,   nil,   120,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   121,    88,
   159,   161,   160,   nil,   130,   131,   nil,   nil,   nil,   174,
   nil,   137,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   163,   nil,   nil,
   nil,   167,   nil,   nil,   nil,   nil,   nil,   164,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   178,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   177,   nil,   nil,   180,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   197,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   206 ]

racc_goto_check = [
     2,    43,     4,     2,    57,    15,    27,    21,    78,    58,
    44,    12,    14,    51,    79,    73,    64,    26,    24,    28,
    30,    31,    33,    34,    36,    37,    38,    12,    39,    40,
    41,    73,    42,    22,    20,    45,    46,    48,    49,    19,
     4,     4,    52,    53,    56,    18,    16,    44,     4,    60,
    79,    61,    58,    78,    14,    51,    62,    63,    25,    65,
    66,    67,    69,    57,    70,    71,    72,    11,    74,    76,
    77,     8,     1,    80,    81,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,     4,   nil,     4,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,     2,     4,
    15,    27,    21,   nil,     4,     4,   nil,   nil,   nil,    43,
   nil,     4,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,     4,   nil,   nil,
   nil,     4,   nil,   nil,   nil,   nil,   nil,     2,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,     4,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,     2,   nil,   nil,     2,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,     2,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
     2 ]

racc_goto_pointer = [
   nil,    72,    -2,   nil,   -11,   nil,   nil,   nil,  -124,   nil,
   nil,    21,  -129,   nil,   -51,   -42,    30,   nil,   -23,   -87,
   -72,   -41,    16,   nil,   -60,   -69,   -90,   -43,     1,   nil,
   -62,  -107,   nil,  -148,     2,   nil,     2,     2,   -28,     5,
     6,   -67,     9,   -53,   -44,   -19,   -18,   nil,   -93,   -58,
   nil,  -120,   -76,  -120,   nil,   nil,    -7,   -47,   -77,   nil,
  -127,   -68,  -139,  -131,   -20,   -76,    23,  -129,   nil,   -61,
     0,  -115,   -37,  -125,     3,   nil,  -104,   -88,  -146,  -155,
   -66,  -119 ]

racc_goto_default = [
   nil,   nil,   nil,     5,     6,     7,     8,     9,    10,    11,
    12,   nil,    14,    15,    16,   nil,   nil,    68,   nil,   nil,
    17,   nil,   nil,    78,   nil,   nil,    18,   nil,   nil,    82,
   nil,   nil,    19,    20,   nil,    21,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,    95,   nil,   nil,
    26,   nil,   nil,   nil,    31,    32,   nil,   nil,   nil,    87,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,    38,   nil,
   nil,   nil,   nil,   nil,   nil,   156,   nil,   nil,   nil,   nil,
   nil,   nil ]

racc_reduce_table = [
  0, 0, :racc_error,
  3, 46, :_reduce_1,
  2, 47, :_reduce_none,
  0, 47, :_reduce_none,
  2, 48, :_reduce_4,
  1, 48, :_reduce_none,
  1, 48, :_reduce_none,
  1, 48, :_reduce_none,
  1, 48, :_reduce_none,
  1, 48, :_reduce_none,
  1, 48, :_reduce_10,
  0, 56, :_reduce_11,
  4, 48, :_reduce_12,
  1, 55, :_reduce_none,
  1, 55, :_reduce_none,
  0, 61, :_reduce_15,
  3, 49, :_reduce_none,
  0, 63, :_reduce_17,
  0, 64, :_reduce_18,
  5, 60, :_reduce_none,
  0, 60, :_reduce_none,
  0, 67, :_reduce_21,
  3, 59, :_reduce_none,
  0, 69, :_reduce_23,
  0, 70, :_reduce_24,
  5, 66, :_reduce_none,
  0, 66, :_reduce_none,
  0, 73, :_reduce_27,
  3, 65, :_reduce_none,
  0, 75, :_reduce_29,
  0, 76, :_reduce_30,
  5, 72, :_reduce_none,
  0, 72, :_reduce_none,
  1, 71, :_reduce_none,
  1, 71, :_reduce_34,
  0, 80, :_reduce_35,
  2, 71, :_reduce_36,
  0, 81, :_reduce_37,
  4, 71, :_reduce_38,
  2, 77, :_reduce_none,
  2, 77, :_reduce_40,
  2, 77, :_reduce_41,
  0, 85, :_reduce_42,
  2, 82, :_reduce_none,
  1, 82, :_reduce_none,
  0, 87, :_reduce_45,
  4, 84, :_reduce_46,
  2, 83, :_reduce_none,
  1, 83, :_reduce_none,
  0, 90, :_reduce_49,
  2, 83, :_reduce_none,
  0, 91, :_reduce_51,
  2, 83, :_reduce_none,
  0, 92, :_reduce_53,
  0, 93, :_reduce_54,
  6, 88, :_reduce_none,
  0, 88, :_reduce_none,
  0, 94, :_reduce_57,
  3, 89, :_reduce_58,
  0, 89, :_reduce_none,
  1, 78, :_reduce_none,
  1, 78, :_reduce_61,
  1, 78, :_reduce_62,
  1, 78, :_reduce_63,
  1, 78, :_reduce_64,
  0, 97, :_reduce_65,
  3, 86, :_reduce_none,
  0, 86, :_reduce_none,
  0, 98, :_reduce_68,
  4, 96, :_reduce_none,
  0, 96, :_reduce_none,
  1, 62, :_reduce_none,
  1, 62, :_reduce_none,
  1, 62, :_reduce_none,
  1, 62, :_reduce_none,
  1, 62, :_reduce_none,
  1, 62, :_reduce_none,
  1, 62, :_reduce_none,
  1, 62, :_reduce_none,
  1, 68, :_reduce_none,
  1, 68, :_reduce_none,
  1, 74, :_reduce_none,
  1, 74, :_reduce_none,
  1, 95, :_reduce_none,
  1, 95, :_reduce_none,
  1, 99, :_reduce_85,
  1, 100, :_reduce_86,
  3, 79, :_reduce_none,
  2, 101, :_reduce_none,
  0, 101, :_reduce_none,
  3, 103, :_reduce_none,
  0, 103, :_reduce_none,
  1, 102, :_reduce_92,
  1, 104, :_reduce_none,
  0, 106, :_reduce_94,
  9, 53, :_reduce_95,
  0, 108, :_reduce_96,
  3, 105, :_reduce_none,
  0, 105, :_reduce_none,
  1, 107, :_reduce_none,
  3, 107, :_reduce_none,
  0, 109, :_reduce_101,
  0, 110, :_reduce_102,
  9, 50, :_reduce_103,
  0, 111, :_reduce_104,
  0, 112, :_reduce_105,
  11, 51, :_reduce_none,
  0, 113, :_reduce_107,
  2, 52, :_reduce_108,
  11, 54, :_reduce_none,
  0, 115, :_reduce_110,
  0, 116, :_reduce_111,
  10, 57, :_reduce_none,
  0, 119, :_reduce_113,
  7, 58, :_reduce_none,
  2, 118, :_reduce_none,
  0, 118, :_reduce_none,
  1, 120, :_reduce_117,
  0, 122, :_reduce_118,
  4, 120, :_reduce_none,
  1, 121, :_reduce_none,
  0, 121, :_reduce_none,
  2, 117, :_reduce_none,
  0, 117, :_reduce_none,
  0, 125, :_reduce_124,
  4, 114, :_reduce_none,
  0, 114, :_reduce_none,
  0, 126, :_reduce_127,
  5, 124, :_reduce_none,
  0, 124, :_reduce_none,
  2, 123, :_reduce_130,
  0, 123, :_reduce_none ]

racc_reduce_n = 132

racc_shift_n = 209

racc_token_table = {
  false => 0,
  :error => 1,
  :PH_OT => 2,
  :PH_CT => 3,
  ";" => 4,
  :WORD_RETURN => 5,
  "(" => 6,
  ")" => 7,
  :ID => 8,
  :OP_INCREMENT => 9,
  :OP_DECREMENT => 10,
  "[" => 11,
  "]" => 12,
  :OP_ASIGN => 13,
  :STRING => 14,
  :WORD_TRUE => 15,
  :WORD_FALSE => 16,
  :WORD_NULL => 17,
  "," => 18,
  :OP_EQUAL => 19,
  :OP_NOT_EQUAL => 20,
  :OP_GREATER => 21,
  :OP_GREATER_EQUAL => 22,
  :OP_LESS => 23,
  :OP_LESS_EQUAL => 24,
  :WORD_AND => 25,
  :WORD_OR => 26,
  :OP_PLUS => 27,
  :OP_MINUS => 28,
  :OP_MULTIPLY => 29,
  :OP_DIVIDE => 30,
  :INT => 31,
  :FLOAT => 32,
  :WORD_IF => 33,
  "{" => 34,
  "}" => 35,
  :WORD_ELSE => 36,
  :WORD_WHILE => 37,
  :WORD_DO => 38,
  :BLOCK_VERBOSE => 39,
  :WORD_FOR => 40,
  :WORD_FUN => 41,
  :WORD_CLASS => 42,
  :WORD_EXTENDS => 43,
  "=" => 44 }

racc_nt_base = 45

racc_use_result_var = true

Racc_arg = [
  racc_action_table,
  racc_action_check,
  racc_action_default,
  racc_action_pointer,
  racc_goto_table,
  racc_goto_check,
  racc_goto_default,
  racc_goto_pointer,
  racc_nt_base,
  racc_reduce_table,
  racc_token_table,
  racc_shift_n,
  racc_reduce_n,
  racc_use_result_var ]

Racc_token_to_s_table = [
  "$end",
  "error",
  "PH_OT",
  "PH_CT",
  "\";\"",
  "WORD_RETURN",
  "\"(\"",
  "\")\"",
  "ID",
  "OP_INCREMENT",
  "OP_DECREMENT",
  "\"[\"",
  "\"]\"",
  "OP_ASIGN",
  "STRING",
  "WORD_TRUE",
  "WORD_FALSE",
  "WORD_NULL",
  "\",\"",
  "OP_EQUAL",
  "OP_NOT_EQUAL",
  "OP_GREATER",
  "OP_GREATER_EQUAL",
  "OP_LESS",
  "OP_LESS_EQUAL",
  "WORD_AND",
  "WORD_OR",
  "OP_PLUS",
  "OP_MINUS",
  "OP_MULTIPLY",
  "OP_DIVIDE",
  "INT",
  "FLOAT",
  "WORD_IF",
  "\"{\"",
  "\"}\"",
  "WORD_ELSE",
  "WORD_WHILE",
  "WORD_DO",
  "BLOCK_VERBOSE",
  "WORD_FOR",
  "WORD_FUN",
  "WORD_CLASS",
  "WORD_EXTENDS",
  "\"=\"",
  "$start",
  "phast",
  "estatutos",
  "estatuto",
  "expresion",
  "bloque_while",
  "bloque_do",
  "bloque_verbose",
  "bloque_if",
  "bloque_for",
  "bloques_declarativos",
  "@1",
  "bloque_fun",
  "bloque_class",
  "comparando",
  "comparando_aux",
  "@2",
  "op_comp",
  "@3",
  "@4",
  "termino",
  "termino_aux",
  "@5",
  "op_term",
  "@6",
  "@7",
  "factor",
  "factor_aux",
  "@8",
  "op_fact",
  "@9",
  "@10",
  "llamada",
  "estatico",
  "arreglo",
  "@11",
  "@12",
  "tipo_llamada",
  "vars",
  "funcs",
  "@13",
  "argumentos",
  "@14",
  "arr_acc",
  "asign",
  "@15",
  "@16",
  "@17",
  "@18",
  "@19",
  "numero",
  "args_aux",
  "@20",
  "@21",
  "int",
  "float",
  "arr_elems",
  "arr_elem",
  "arr_elems_aux",
  "arr_elem_wrapper",
  "else",
  "@22",
  "aux_else",
  "@23",
  "@24",
  "@25",
  "@26",
  "@27",
  "@28",
  "params",
  "@29",
  "@30",
  "class_extras",
  "class_body",
  "@31",
  "class_body_aux",
  "class_def_var_aux",
  "@32",
  "def_param",
  "params_aux",
  "@33",
  "@34" ]

Racc_debug_parser = false

##### State transition tables end #####

# reduce 0 omitted

module_eval(<<'.,.,', 'parser.y', 32)
  def _reduce_1(val, _values, result)
    
    result
  end
.,.,

# reduce 2 omitted

# reduce 3 omitted

module_eval(<<'.,.,', 'parser.y', 35)
  def _reduce_4(val, _values, result)
     vaciar_pOperandos 
    result
  end
.,.,

# reduce 5 omitted

# reduce 6 omitted

# reduce 7 omitted

# reduce 8 omitted

# reduce 9 omitted

module_eval(<<'.,.,', 'parser.y', 41)
  def _reduce_10(val, _values, result)
     disminuye_scope 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 42)
  def _reduce_11(val, _values, result)
    return_quad 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 42)
  def _reduce_12(val, _values, result)
     vaciar_pOperandos 
    result
  end
.,.,

# reduce 13 omitted

# reduce 14 omitted

module_eval(<<'.,.,', 'parser.y', 47)
  def _reduce_15(val, _values, result)
    fun3 2
    result
  end
.,.,

# reduce 16 omitted

module_eval(<<'.,.,', 'parser.y', 48)
  def _reduce_17(val, _values, result)
    fun2
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 48)
  def _reduce_18(val, _values, result)
    fun3 2
    result
  end
.,.,

# reduce 19 omitted

# reduce 20 omitted

module_eval(<<'.,.,', 'parser.y', 50)
  def _reduce_21(val, _values, result)
    fun3 1
    result
  end
.,.,

# reduce 22 omitted

module_eval(<<'.,.,', 'parser.y', 51)
  def _reduce_23(val, _values, result)
    fun2
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 51)
  def _reduce_24(val, _values, result)
    fun3 1
    result
  end
.,.,

# reduce 25 omitted

# reduce 26 omitted

module_eval(<<'.,.,', 'parser.y', 53)
  def _reduce_27(val, _values, result)
    fun3 0
    result
  end
.,.,

# reduce 28 omitted

module_eval(<<'.,.,', 'parser.y', 54)
  def _reduce_29(val, _values, result)
    fun2
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 54)
  def _reduce_30(val, _values, result)
    fun3 0
    result
  end
.,.,

# reduce 31 omitted

# reduce 32 omitted

# reduce 33 omitted

module_eval(<<'.,.,', 'parser.y', 57)
  def _reduce_34(val, _values, result)
    fun1(llama_cte(@curr_token[1])) 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 58)
  def _reduce_35(val, _values, result)
     openArreglo 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 58)
  def _reduce_36(val, _values, result)
     closeArreglo 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 59)
  def _reduce_37(val, _values, result)
    fun4
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 59)
  def _reduce_38(val, _values, result)
    fun5
    result
  end
.,.,

# reduce 39 omitted

module_eval(<<'.,.,', 'parser.y', 61)
  def _reduce_40(val, _values, result)
     pre_affect "+" 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 62)
  def _reduce_41(val, _values, result)
     pre_affect "-" 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 63)
  def _reduce_42(val, _values, result)
     fun1(llame_var(@prev_token[1])) 
    result
  end
.,.,

# reduce 43 omitted

# reduce 44 omitted

module_eval(<<'.,.,', 'parser.y', 65)
  def _reduce_45(val, _values, result)
     fun_prepare @prev_token[1] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 65)
  def _reduce_46(val, _values, result)
     fun_call 
    result
  end
.,.,

# reduce 47 omitted

# reduce 48 omitted

module_eval(<<'.,.,', 'parser.y', 68)
  def _reduce_49(val, _values, result)
     post_affect "+" 
    result
  end
.,.,

# reduce 50 omitted

module_eval(<<'.,.,', 'parser.y', 69)
  def _reduce_51(val, _values, result)
     post_affect "-" 
    result
  end
.,.,

# reduce 52 omitted

module_eval(<<'.,.,', 'parser.y', 70)
  def _reduce_53(val, _values, result)
     load_arr 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 70)
  def _reduce_54(val, _values, result)
     access_array_index 
    result
  end
.,.,

# reduce 55 omitted

# reduce 56 omitted

module_eval(<<'.,.,', 'parser.y', 72)
  def _reduce_57(val, _values, result)
    fun2
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 72)
  def _reduce_58(val, _values, result)
    fun3 3
    result
  end
.,.,

# reduce 59 omitted

# reduce 60 omitted

module_eval(<<'.,.,', 'parser.y', 75)
  def _reduce_61(val, _values, result)
     guarda_cte @curr_token[1], String(@curr_token[1]) , 4 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 78)
  def _reduce_62(val, _values, result)
     guarda_cte @curr_token[1], true , 1 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 79)
  def _reduce_63(val, _values, result)
     guarda_cte @curr_token[1], false , 1 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 80)
  def _reduce_64(val, _values, result)
     guarda_cte @curr_token[1], nil , 0 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 81)
  def _reduce_65(val, _values, result)
     argument 
    result
  end
.,.,

# reduce 66 omitted

# reduce 67 omitted

module_eval(<<'.,.,', 'parser.y', 83)
  def _reduce_68(val, _values, result)
     argument 
    result
  end
.,.,

# reduce 69 omitted

# reduce 70 omitted

# reduce 71 omitted

# reduce 72 omitted

# reduce 73 omitted

# reduce 74 omitted

# reduce 75 omitted

# reduce 76 omitted

# reduce 77 omitted

# reduce 78 omitted

# reduce 79 omitted

# reduce 80 omitted

# reduce 81 omitted

# reduce 82 omitted

# reduce 83 omitted

# reduce 84 omitted

module_eval(<<'.,.,', 'parser.y', 101)
  def _reduce_85(val, _values, result)
     guarda_cte @curr_token[1], Integer(@curr_token[1]) , 2 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 102)
  def _reduce_86(val, _values, result)
     guarda_cte @curr_token[1], Float(@curr_token[1]) , 3 
    result
  end
.,.,

# reduce 87 omitted

# reduce 88 omitted

# reduce 89 omitted

# reduce 90 omitted

# reduce 91 omitted

module_eval(<<'.,.,', 'parser.y', 108)
  def _reduce_92(val, _values, result)
     copy_value 
    result
  end
.,.,

# reduce 93 omitted

module_eval(<<'.,.,', 'parser.y', 112)
  def _reduce_94(val, _values, result)
    if_quad 1
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 112)
  def _reduce_95(val, _values, result)
    if_quad 2
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 113)
  def _reduce_96(val, _values, result)
    if_quad 3
    result
  end
.,.,

# reduce 97 omitted

# reduce 98 omitted

# reduce 99 omitted

# reduce 100 omitted

module_eval(<<'.,.,', 'parser.y', 117)
  def _reduce_101(val, _values, result)
    while_quad 1
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 117)
  def _reduce_102(val, _values, result)
    while_quad 2
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 117)
  def _reduce_103(val, _values, result)
    while_quad 3
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 118)
  def _reduce_104(val, _values, result)
    do_while_quad 1
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 118)
  def _reduce_105(val, _values, result)
    do_while_quad 2
    result
  end
.,.,

# reduce 106 omitted

module_eval(<<'.,.,', 'parser.y', 119)
  def _reduce_107(val, _values, result)
    p @curr_token
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 119)
  def _reduce_108(val, _values, result)
     verbose @curr_token[1] 
    result
  end
.,.,

# reduce 109 omitted

module_eval(<<'.,.,', 'parser.y', 121)
  def _reduce_110(val, _values, result)
     aumenta_scope @curr_token[1] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 121)
  def _reduce_111(val, _values, result)
     end_fun 
    result
  end
.,.,

# reduce 112 omitted

module_eval(<<'.,.,', 'parser.y', 123)
  def _reduce_113(val, _values, result)
     aumenta_scope @curr_token[1] 
    result
  end
.,.,

# reduce 114 omitted

# reduce 115 omitted

# reduce 116 omitted

module_eval(<<'.,.,', 'parser.y', 126)
  def _reduce_117(val, _values, result)
     disminuye_scope 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 127)
  def _reduce_118(val, _values, result)
     llame_var @curr_token[1] 
    result
  end
.,.,

# reduce 119 omitted

# reduce 120 omitted

# reduce 121 omitted

# reduce 122 omitted

# reduce 123 omitted

module_eval(<<'.,.,', 'parser.y', 133)
  def _reduce_124(val, _values, result)
     param(llame_var(@curr_token[1])) 
    result
  end
.,.,

# reduce 125 omitted

# reduce 126 omitted

module_eval(<<'.,.,', 'parser.y', 135)
  def _reduce_127(val, _values, result)
     param(llame_var(@curr_token[1])) 
    result
  end
.,.,

# reduce 128 omitted

# reduce 129 omitted

module_eval(<<'.,.,', 'parser.y', 137)
  def _reduce_130(val, _values, result)
     fun1(llama_cte(@curr_token[1])) 
    result
  end
.,.,

# reduce 131 omitted

def _reduce_none(val, _values, result)
  val[0]
end

  end   # class Parser
  end   # module Phast
