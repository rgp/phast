#
# DO NOT MODIFY!!!!
# This file is automatically generated by Racc 1.4.9
# from Racc grammer file "".
#

require 'racc/parser.rb'


module Phast
  class Parser < Racc::Parser

module_eval(<<'...end parser.y/module_eval...', 'parser.y', 109)

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
                    puts "#{op}\t#{oper}\t#{oper1}\tt#{@tmp_var_id}"
                end
            when nivel == 1
                if(op == '+' || op == '-')
                    @poper.pop
                    oper = @operandos.pop
                    oper1 = @operandos.pop
                    @tmp_var_id += 1
                    @operandos.push "t#{@tmp_var_id}"
                    puts "#{op}\t#{oper}\t#{oper1}\tt#{@tmp_var_id}"
                end
            when nivel == 2
                if(op == "and" || op == "or")
                    @poper.pop
                    oper = @operandos.pop
                    oper1 = @operandos.pop
                    @tmp_var_id += 1
                    @operandos.push "t#{@tmp_var_id}"
                    puts "#{op}\t#{oper}\t#{oper1}\tt#{@tmp_var_id}"
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
...end parser.y/module_eval...
##### State transition tables begin ###

racc_action_table = [
    18,    20,    22,    23,    24,    25,   170,    28,   126,    94,
    32,    95,    -3,    96,    18,    20,    22,    23,    24,    25,
   126,    28,     2,    26,    27,    74,    75,    29,    70,    71,
    30,    31,    32,   107,    33,   -10,   -10,    26,    27,    41,
    42,    29,   105,   -89,    30,    31,    32,   103,    33,    18,
    20,    22,    23,    24,    25,   -89,    28,    70,    71,    74,
    75,    18,    20,    22,    23,    24,    25,   102,    28,   101,
   100,    99,    26,    27,    80,   106,    29,   117,    -3,    30,
    31,    32,   118,    33,    26,    27,   119,    97,    29,   121,
    -3,    30,    31,    32,    89,    33,    18,    20,    22,    23,
    24,    25,   130,    28,   132,   133,    87,   135,    18,    20,
    22,    23,    24,    25,    82,    28,   137,   138,   140,    26,
    27,   141,    80,    29,    41,    -3,    30,    31,    32,    78,
    33,    26,    27,    57,    56,    29,    55,    -3,    30,    31,
    32,   149,    33,    18,    20,    22,    23,    24,    25,    54,
    28,   151,    53,    52,   155,    18,    20,    22,    23,    24,
    25,    37,    28,   158,   132,   160,    26,    27,   162,   163,
    29,   164,    -3,    30,    31,    32,   165,    33,    26,    27,
   166,   167,    29,    35,    -3,    30,    31,    32,   171,    33,
    18,    20,    22,    23,    24,    25,    34,    28,    18,    20,
    22,    23,    24,    25,     3,    28,   140,   176,   177,   155,
   nil,   nil,   nil,    26,    27,   nil,   nil,   nil,   nil,   nil,
   nil,    26,    27,    18,    20,    22,    23,    24,    25,   nil,
    28,    18,    20,    22,    23,    24,    25,   nil,    28,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,    26,    27,   nil,   nil,
   nil,   nil,   nil,   nil,    26,    27,    18,    20,    22,    23,
    24,    25,   nil,    28,    18,    20,    22,    23,    24,    25,
   nil,    28,   nil,   nil,   nil,   nil,   nil,   nil,   nil,    26,
    27,   nil,   nil,   nil,   nil,   nil,   nil,    26,    27,    18,
    20,    22,    23,    24,    25,   nil,    28,    18,    20,    22,
    23,    24,    25,   nil,    28,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,    26,    27,   nil,   nil,   nil,   nil,   nil,   nil,
    26,    27,    18,    20,    22,    23,    24,    25,   nil,    28,
    18,    20,    22,    23,    24,    25,   nil,    28,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,    26,    27,   nil,   nil,   nil,
   nil,   nil,   nil,    26,    27,    18,    20,    22,    23,    24,
    25,   nil,    28,    18,    20,    22,    23,    24,    25,   nil,
    28,   nil,   nil,   nil,   nil,   nil,   nil,   nil,    26,    27,
   nil,   nil,   nil,   nil,   nil,   nil,    26,    27,    18,    20,
    22,    23,    24,    25,   nil,    28,    18,    20,    22,    23,
    24,    25,   nil,    28,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,    26,    27,   nil,   nil,   nil,   nil,   nil,   nil,    26,
    27,    18,    20,    22,    23,    24,    25,   nil,    28,    18,
    20,    22,    23,    24,    25,   nil,    28,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,    26,    27,   nil,   nil,   nil,   nil,
   nil,   nil,    26,    27,    18,    20,    22,    23,    24,    25,
   nil,    28,    20,    22,    23,    24,    25,   nil,    28,    60,
    61,    62,    63,    64,    65,    66,    67,    26,    27,   nil,
   nil,   nil,   nil,   nil,    26,    27,    60,    61,    62,    63,
    64,    65,    66,    67 ]

racc_action_check = [
     5,     5,     5,     5,     5,     5,   162,     5,   106,    76,
   162,    76,     2,    76,     2,     2,     2,     2,     2,     2,
   124,     2,     0,     5,     5,    45,    45,     5,    44,    44,
     5,     5,     5,    89,     5,     5,     5,     2,     2,    12,
    12,     2,    87,   106,     2,     2,     2,    86,     2,   171,
   171,   171,   171,   171,   171,   124,   171,   128,   128,   129,
   129,   117,   117,   117,   117,   117,   117,    85,   117,    84,
    83,    82,   171,   171,    98,    88,   171,   100,   171,   171,
   171,   171,   101,   171,   117,   117,   102,    77,   117,   104,
   117,   117,   117,   117,    57,   117,    53,    53,    53,    53,
    53,    53,   111,    53,   112,   113,    56,   118,   119,   119,
   119,   119,   119,   119,    50,   119,   120,   121,   122,    53,
    53,   123,    49,    53,   125,    53,    53,    53,    53,    48,
    53,   119,   119,    42,    41,   119,    33,   119,   119,   119,
   119,   134,   119,   170,   170,   170,   170,   170,   170,    32,
   170,   136,    30,    29,   139,   138,   138,   138,   138,   138,
   138,     6,   138,   144,   148,   150,   170,   170,   151,   152,
   170,   153,   170,   170,   170,   170,   155,   170,   138,   138,
   157,   160,   138,     4,   138,   138,   138,   138,   163,   138,
    47,    47,    47,    47,    47,    47,     3,    47,   135,   135,
   135,   135,   135,   135,     1,   135,   172,   173,   174,   175,
   nil,   nil,   nil,    47,    47,   nil,   nil,   nil,   nil,   nil,
   nil,   135,   135,   132,   132,   132,   132,   132,   132,   nil,
   132,    90,    90,    90,    90,    90,    90,   nil,    90,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   132,   132,   nil,   nil,
   nil,   nil,   nil,   nil,    90,    90,    91,    91,    91,    91,
    91,    91,   nil,    91,    92,    92,    92,    92,    92,    92,
   nil,    92,   nil,   nil,   nil,   nil,   nil,   nil,   nil,    91,
    91,   nil,   nil,   nil,   nil,   nil,   nil,    92,    92,    94,
    94,    94,    94,    94,    94,   nil,    94,    95,    95,    95,
    95,    95,    95,   nil,    95,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,    94,    94,   nil,   nil,   nil,   nil,   nil,   nil,
    95,    95,   137,   137,   137,   137,   137,   137,   nil,   137,
    96,    96,    96,    96,    96,    96,   nil,    96,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   137,   137,   nil,   nil,   nil,
   nil,   nil,   nil,    96,    96,    28,    28,    28,    28,    28,
    28,   nil,    28,    80,    80,    80,    80,    80,    80,   nil,
    80,   nil,   nil,   nil,   nil,   nil,   nil,   nil,    28,    28,
   nil,   nil,   nil,   nil,   nil,   nil,    80,    80,    52,    52,
    52,    52,    52,    52,   nil,    52,   103,   103,   103,   103,
   103,   103,   nil,   103,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,    52,    52,   nil,   nil,   nil,   nil,   nil,   nil,   103,
   103,    99,    99,    99,    99,    99,    99,   nil,    99,    55,
    55,    55,    55,    55,    55,   nil,    55,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,    99,    99,   nil,   nil,   nil,   nil,
   nil,   nil,    55,    55,    54,    54,    54,    54,    54,    54,
   nil,    54,   140,   140,   140,   140,   140,   nil,   140,    43,
    43,    43,    43,    43,    43,    43,    43,    54,    54,   nil,
   nil,   nil,   nil,   nil,   140,   140,   127,   127,   127,   127,
   127,   127,   127,   127 ]

racc_action_pointer = [
    20,   204,     9,   196,   180,    -5,   157,   nil,   nil,   nil,
   nil,   nil,    -1,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   350,   143,
   119,   nil,   139,   126,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   129,   128,   453,     4,    -1,   nil,   185,   116,   107,
    84,   nil,   383,    91,   449,   424,    96,    52,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,    -1,    76,   nil,   nil,
   358,   nil,    40,    59,    35,    56,    43,    37,    42,    28,
   226,   251,   259,   nil,   284,   292,   325,   nil,    59,   416,
    44,    50,    53,   391,    78,   nil,     3,   nil,   nil,   nil,
   nil,    91,    89,    92,   nil,   nil,   nil,    56,    97,   103,
   112,    84,    88,    87,    15,    84,   nil,   470,    33,    33,
   nil,   nil,   218,   nil,   107,   193,   117,   317,   150,   139,
   456,   nil,   nil,   nil,   149,   nil,   nil,   nil,   149,   nil,
   154,   130,   158,   137,   nil,   171,   nil,   176,   nil,   nil,
   177,   nil,   -27,   155,   nil,   nil,   nil,   nil,   nil,   nil,
   138,    44,   176,   173,   174,   194,   nil,   nil,   nil ]

racc_action_default = [
  -105,  -105,   -10,  -105,  -105,    -3,  -105,    -5,    -6,    -7,
    -8,    -9,  -105,   -14,   -20,   -26,   -32,   -33,   -34,   -37,
   -38,   -39,   -40,   -41,   -42,   -43,   -65,   -66,   -69,  -105,
  -105,   -78,  -105,  -105,   179,    -1,    -2,    -4,   -11,   -12,
   -13,  -105,  -105,   -19,   -25,   -31,   -35,  -105,  -105,   -71,
   -74,   -75,  -105,   -10,  -105,  -105,  -105,   -96,   -15,   -16,
   -53,   -54,   -55,   -56,   -57,   -58,   -59,   -60,   -21,   -22,
   -61,   -62,   -27,   -28,   -63,   -64,   -48,  -105,   -67,   -68,
  -105,   -72,  -105,  -105,  -105,  -105,  -105,   -99,  -105,  -105,
  -105,  -105,  -105,   -36,   -50,  -105,  -105,   -44,   -71,  -105,
  -105,  -105,  -105,  -105,  -105,   -97,   -88,   -95,   -17,   -23,
   -29,  -105,   -52,  -105,   -47,   -70,   -73,   -10,  -105,   -10,
  -105,  -105,  -104,  -105,   -88,  -105,   -91,   -19,   -25,   -31,
   -45,   -49,  -105,   -46,  -105,  -105,  -105,  -105,   -10,  -102,
  -105,   -86,   -87,   -90,   -94,   -18,   -24,   -30,   -52,   -76,
  -105,   -81,  -105,  -105,   -98,  -105,  -103,  -105,   -93,   -51,
  -105,   -79,  -105,  -105,   -85,  -100,   -92,   -77,   -80,   -82,
   -10,   -10,  -104,  -105,  -105,  -102,   -83,   -84,  -101 ]

racc_goto_table = [
     4,    39,    51,    36,    58,    72,    68,    49,   139,   154,
   131,    79,    86,   123,   156,    44,    91,   128,   110,   127,
    45,    77,    92,   129,   109,    93,    83,    46,    85,    76,
    47,   142,   111,    90,    48,    43,    40,   116,    81,   161,
   168,   104,    88,    38,   157,   178,   159,   108,   144,   169,
     1,    84,   122,   172,    51,   nil,   nil,   nil,   175,    98,
   115,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   112,   113,
   114,   nil,   nil,    51,   nil,   nil,   nil,   120,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   145,   147,
   146,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   148,   nil,   nil,   150,
   nil,   152,   nil,   nil,   143,   134,   nil,   136,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   153,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   173,   174 ]

racc_goto_check = [
     2,    12,     4,     2,    15,    27,    21,    43,    56,    57,
    41,    44,    14,    51,    33,    22,    24,    25,    26,    19,
    28,     4,    30,    31,    20,    34,     4,    35,     4,    36,
    39,    51,    40,    18,    42,    16,    13,    45,    46,    47,
    48,    49,    50,    10,    53,    57,    41,    14,    55,     8,
     1,     2,    58,    59,     4,   nil,   nil,   nil,    56,    43,
    44,   nil,   nil,   nil,   nil,   nil,   nil,   nil,     4,     4,
     4,   nil,   nil,     4,   nil,   nil,   nil,     4,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,    15,    27,
    21,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,     4,   nil,   nil,     4,
   nil,     4,   nil,   nil,    12,     2,   nil,     2,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,     2,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,     2,     2 ]

racc_goto_pointer = [
   nil,    50,    -2,   nil,   -26,   nil,   nil,   nil,  -113,   nil,
    31,   nil,   -11,    24,   -43,   -39,    22,   nil,   -26,   -89,
   -67,   -38,     1,   nil,   -53,   -92,   -74,   -40,     5,   nil,
   -51,   -87,   nil,  -126,   -51,     9,   -17,   nil,   nil,     5,
   -62,  -102,     6,   -21,   -38,   -62,   -12,  -112,  -122,   -46,
   -15,   -93,   nil,  -100,   nil,   -78,  -114,  -130,   -53,  -112 ]

racc_goto_default = [
   nil,   nil,   nil,     5,     6,     7,     8,     9,    10,    11,
   nil,    12,   nil,   nil,    13,   nil,   nil,    59,   nil,   nil,
    14,   nil,   nil,    69,   nil,   nil,    15,   nil,   nil,    73,
   nil,   nil,    16,    17,   nil,   nil,   nil,    19,    21,   nil,
   nil,   nil,   nil,   nil,   nil,    50,   nil,   nil,   nil,   nil,
   nil,   nil,   124,   nil,   125,   nil,   nil,   nil,   nil,   nil ]

racc_reduce_table = [
  0, 0, :racc_error,
  3, 44, :_reduce_none,
  2, 45, :_reduce_none,
  0, 45, :_reduce_none,
  2, 46, :_reduce_none,
  1, 46, :_reduce_none,
  1, 46, :_reduce_none,
  1, 46, :_reduce_none,
  1, 46, :_reduce_none,
  1, 46, :_reduce_none,
  0, 54, :_reduce_10,
  2, 46, :_reduce_11,
  1, 53, :_reduce_none,
  1, 53, :_reduce_none,
  0, 59, :_reduce_14,
  3, 47, :_reduce_none,
  0, 61, :_reduce_16,
  0, 62, :_reduce_17,
  5, 58, :_reduce_none,
  0, 58, :_reduce_none,
  0, 65, :_reduce_20,
  3, 57, :_reduce_none,
  0, 67, :_reduce_22,
  0, 68, :_reduce_23,
  5, 64, :_reduce_none,
  0, 64, :_reduce_none,
  0, 71, :_reduce_26,
  3, 63, :_reduce_none,
  0, 73, :_reduce_28,
  0, 74, :_reduce_29,
  5, 70, :_reduce_none,
  0, 70, :_reduce_none,
  1, 69, :_reduce_none,
  1, 69, :_reduce_33,
  0, 78, :_reduce_34,
  0, 79, :_reduce_35,
  4, 75, :_reduce_none,
  1, 76, :_reduce_none,
  1, 76, :_reduce_none,
  1, 76, :_reduce_none,
  1, 76, :_reduce_none,
  1, 76, :_reduce_none,
  1, 76, :_reduce_none,
  0, 82, :_reduce_43,
  4, 76, :_reduce_44,
  3, 77, :_reduce_none,
  3, 77, :_reduce_none,
  2, 77, :_reduce_47,
  0, 77, :_reduce_none,
  2, 83, :_reduce_none,
  0, 83, :_reduce_none,
  3, 84, :_reduce_none,
  0, 84, :_reduce_none,
  1, 60, :_reduce_none,
  1, 60, :_reduce_none,
  1, 60, :_reduce_none,
  1, 60, :_reduce_none,
  1, 60, :_reduce_none,
  1, 60, :_reduce_none,
  1, 60, :_reduce_none,
  1, 60, :_reduce_none,
  1, 66, :_reduce_none,
  1, 66, :_reduce_none,
  1, 72, :_reduce_none,
  1, 72, :_reduce_none,
  1, 80, :_reduce_65,
  1, 80, :_reduce_66,
  3, 81, :_reduce_none,
  2, 85, :_reduce_none,
  0, 85, :_reduce_none,
  3, 87, :_reduce_none,
  0, 87, :_reduce_none,
  2, 86, :_reduce_none,
  3, 89, :_reduce_none,
  0, 89, :_reduce_none,
  1, 88, :_reduce_none,
  7, 48, :_reduce_none,
  9, 49, :_reduce_none,
  1, 50, :_reduce_none,
  8, 51, :_reduce_none,
  2, 90, :_reduce_none,
  0, 90, :_reduce_none,
  1, 91, :_reduce_none,
  3, 91, :_reduce_none,
  11, 52, :_reduce_none,
  8, 55, :_reduce_none,
  6, 56, :_reduce_none,
  2, 94, :_reduce_none,
  0, 94, :_reduce_none,
  0, 97, :_reduce_89,
  2, 95, :_reduce_90,
  0, 98, :_reduce_91,
  4, 95, :_reduce_none,
  1, 96, :_reduce_none,
  0, 96, :_reduce_none,
  2, 93, :_reduce_none,
  0, 93, :_reduce_none,
  0, 101, :_reduce_97,
  4, 92, :_reduce_none,
  0, 92, :_reduce_none,
  0, 102, :_reduce_100,
  5, 100, :_reduce_none,
  0, 100, :_reduce_none,
  2, 99, :_reduce_none,
  0, 99, :_reduce_none ]

racc_reduce_n = 105

racc_shift_n = 179

racc_token_table = {
  false => 0,
  :error => 1,
  :PH_OT => 2,
  :PH_CT => 3,
  ";" => 4,
  :ID => 5,
  :STRING => 6,
  :WORD_TRUE => 7,
  :WORD_FALSE => 8,
  :WORD_NULL => 9,
  "(" => 10,
  ")" => 11,
  "[" => 12,
  "]" => 13,
  :OP_ASIGN => 14,
  "," => 15,
  :OP_EQUAL => 16,
  :OP_NOT_EQUAL => 17,
  :OP_GREATER => 18,
  :OP_GREATER_EQUAL => 19,
  :OP_LESS => 20,
  :OP_LESS_EQUAL => 21,
  :WORD_AND => 22,
  :WORD_OR => 23,
  :OP_PLUS => 24,
  :OP_MINUS => 25,
  :OP_MULTIPLY => 26,
  :OP_DIVIDE => 27,
  :INT => 28,
  :FLOAT => 29,
  "=" => 30,
  ">" => 31,
  :WORD_WHILE => 32,
  "{" => 33,
  "}" => 34,
  :WORD_DO => 35,
  :VERBOSE_BLOCK => 36,
  :WORD_IF => 37,
  :WORD_ELSE => 38,
  :WORD_FOR => 39,
  :WORD_FUN => 40,
  :WORD_CLASS => 41,
  :WORD_EXTENDS => 42 }

racc_nt_base = 43

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
  "ID",
  "STRING",
  "WORD_TRUE",
  "WORD_FALSE",
  "WORD_NULL",
  "\"(\"",
  "\")\"",
  "\"[\"",
  "\"]\"",
  "OP_ASIGN",
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
  "\"=\"",
  "\">\"",
  "WORD_WHILE",
  "\"{\"",
  "\"}\"",
  "WORD_DO",
  "VERBOSE_BLOCK",
  "WORD_IF",
  "WORD_ELSE",
  "WORD_FOR",
  "WORD_FUN",
  "WORD_CLASS",
  "WORD_EXTENDS",
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
  "id_call",
  "@11",
  "@12",
  "numero",
  "arreglo",
  "@13",
  "argumentos",
  "args_aux",
  "arr_elems",
  "arr_elem",
  "arr_elems_aux",
  "arr_val",
  "arr_elem_aux",
  "else",
  "aux_else",
  "params",
  "class_extras",
  "class_body",
  "class_body_aux",
  "class_def_var_aux",
  "@14",
  "@15",
  "def_param",
  "params_aux",
  "@16",
  "@17" ]

Racc_debug_parser = false

##### State transition tables end #####

# reduce 0 omitted

# reduce 1 omitted

# reduce 2 omitted

# reduce 3 omitted

# reduce 4 omitted

# reduce 5 omitted

# reduce 6 omitted

# reduce 7 omitted

# reduce 8 omitted

# reduce 9 omitted

module_eval(<<'.,.,', 'parser.y', 13)
  def _reduce_10(val, _values, result)
     aumenta_scope 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 13)
  def _reduce_11(val, _values, result)
     disminuye_scope 
    result
  end
.,.,

# reduce 12 omitted

# reduce 13 omitted

module_eval(<<'.,.,', 'parser.y', 17)
  def _reduce_14(val, _values, result)
    fun3 2
    result
  end
.,.,

# reduce 15 omitted

module_eval(<<'.,.,', 'parser.y', 18)
  def _reduce_16(val, _values, result)
    fun2
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 18)
  def _reduce_17(val, _values, result)
    fun3 2
    result
  end
.,.,

# reduce 18 omitted

# reduce 19 omitted

module_eval(<<'.,.,', 'parser.y', 20)
  def _reduce_20(val, _values, result)
    fun3 1
    result
  end
.,.,

# reduce 21 omitted

module_eval(<<'.,.,', 'parser.y', 21)
  def _reduce_22(val, _values, result)
    fun2
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 21)
  def _reduce_23(val, _values, result)
    fun3 1
    result
  end
.,.,

# reduce 24 omitted

# reduce 25 omitted

module_eval(<<'.,.,', 'parser.y', 23)
  def _reduce_26(val, _values, result)
    fun3 0
    result
  end
.,.,

# reduce 27 omitted

module_eval(<<'.,.,', 'parser.y', 24)
  def _reduce_28(val, _values, result)
    fun2
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 24)
  def _reduce_29(val, _values, result)
    fun3 0
    result
  end
.,.,

# reduce 30 omitted

# reduce 31 omitted

# reduce 32 omitted

module_eval(<<'.,.,', 'parser.y', 27)
  def _reduce_33(val, _values, result)
    fun1
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 28)
  def _reduce_34(val, _values, result)
     llame_var
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 28)
  def _reduce_35(val, _values, result)
     fun1 
    result
  end
.,.,

# reduce 36 omitted

# reduce 37 omitted

# reduce 38 omitted

# reduce 39 omitted

# reduce 40 omitted

# reduce 41 omitted

# reduce 42 omitted

module_eval(<<'.,.,', 'parser.y', 37)
  def _reduce_43(val, _values, result)
    fun4
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 37)
  def _reduce_44(val, _values, result)
    fun5
    result
  end
.,.,

# reduce 45 omitted

# reduce 46 omitted

module_eval(<<'.,.,', 'parser.y', 43)
  def _reduce_47(val, _values, result)
    
    result
  end
.,.,

# reduce 48 omitted

# reduce 49 omitted

# reduce 50 omitted

# reduce 51 omitted

# reduce 52 omitted

# reduce 53 omitted

# reduce 54 omitted

# reduce 55 omitted

# reduce 56 omitted

# reduce 57 omitted

# reduce 58 omitted

# reduce 59 omitted

# reduce 60 omitted

# reduce 61 omitted

# reduce 62 omitted

# reduce 63 omitted

# reduce 64 omitted

module_eval(<<'.,.,', 'parser.y', 64)
  def _reduce_65(val, _values, result)
    
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 65)
  def _reduce_66(val, _values, result)
    
    result
  end
.,.,

# reduce 67 omitted

# reduce 68 omitted

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

# reduce 85 omitted

# reduce 86 omitted

# reduce 87 omitted

# reduce 88 omitted

module_eval(<<'.,.,', 'parser.y', 90)
  def _reduce_89(val, _values, result)
     aumenta_scope 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 90)
  def _reduce_90(val, _values, result)
     disminuye_scope 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 91)
  def _reduce_91(val, _values, result)
     llame_var 
    result
  end
.,.,

# reduce 92 omitted

# reduce 93 omitted

# reduce 94 omitted

# reduce 95 omitted

# reduce 96 omitted

module_eval(<<'.,.,', 'parser.y', 97)
  def _reduce_97(val, _values, result)
     llame_var 
    result
  end
.,.,

# reduce 98 omitted

# reduce 99 omitted

module_eval(<<'.,.,', 'parser.y', 99)
  def _reduce_100(val, _values, result)
     llame_var 
    result
  end
.,.,

# reduce 101 omitted

# reduce 102 omitted

# reduce 103 omitted

# reduce 104 omitted

def _reduce_none(val, _values, result)
  val[0]
end

  end   # class Parser
  end   # module Phast
