#
# DO NOT MODIFY!!!!
# This file is automatically generated by Racc 1.4.9
# from Racc grammer file "".
#

require 'racc/parser.rb'


module Phast
  class Parser < Racc::Parser

module_eval(<<'...end parser.y/module_eval...', 'parser.y', 128)
  class UndeclaredVariable < StandardError
  end
  class VariableAlreadyDeclared < StandardError
  end

  def parse(tokens)
    @tokens = tokens
    @scope = 0
    @vars = {}
    @types = []

    do_parse
  end

  def vars
    @vars
  end

  def next_token
    @tokens.shift
  end

  def setup_scope
    @vars[@scope] = {}
  end
  
  def update_scope
    @scope +=1
  end

  def add_to_vars id, is_stack=false
    type = is_stack ? @types.pop : @types.last

    if exists? id
      raise VariableAlreadyDeclared
    else
      @vars[@scope][id] = type
    end
  end

  def exists? id
      !@vars[@scope][id].nil?
  end

  def check_for_existance id
    unless exists?(id)
      raise UndeclaredVariable 
    end
  end
...end parser.y/module_eval...
##### State transition tables begin ###

racc_action_table = [
    60,     3,    30,    56,    63,    50,    60,    30,   -73,    30,
    63,    60,    76,    30,    49,    63,    64,    65,    30,    48,
    61,    64,    65,    64,    65,    46,    61,    64,    65,    30,
    60,    61,    64,    65,    63,    60,    52,    30,    20,    63,
    97,    98,    30,    64,    65,    30,    44,    30,    83,    30,
    61,    64,    65,    97,    98,    61,    64,    65,    85,    64,
    65,    64,    65,    64,    65,    30,    43,    30,    91,    92,
    93,    36,    30,    36,    38,    39,    38,    39,    36,    30,
    42,    38,    39,   102,   103,    36,   102,   103,    38,    39,
    23,    24,    25,    26,    23,    24,    25,    26,    23,    24,
    25,    26,    23,    24,    25,    26,    20,    18,   104,   106,
   107,   108,   109,   110,   111,    15,   113,   115,    14,    11,
    12,    11,    76,     8,    20,    20,    56,    85,     7,     6,
     4,   129,   106,   131,   133,   115,    20 ]

racc_action_check = [
    63,     0,   107,    43,    63,    40,    46,    63,    46,   100,
    46,    50,    47,    46,    39,    50,   107,   107,    50,    38,
    63,    63,    63,   100,   100,    30,    46,    46,    46,    52,
   115,    50,    50,    50,   115,    85,    41,   115,    53,    85,
   117,   117,    85,    52,    52,    89,    28,   104,    57,    95,
   115,   115,   115,    69,    69,    85,    85,    85,    58,    89,
    89,   104,   104,    95,    95,    49,    27,    48,    68,    68,
    68,    49,    20,    48,    49,    49,    48,    48,    20,    29,
    21,    20,    20,   118,   118,    29,    71,    71,    29,    29,
    18,    18,    18,    18,    56,    56,    56,    56,    36,    36,
    36,    36,    42,    42,    42,    42,    17,    16,    74,    75,
    76,    77,    78,    80,    82,    12,    86,    87,    11,    10,
     6,     5,   106,     4,   108,   109,   111,   112,     3,     2,
     1,   119,   120,   121,   123,   126,   133 ]

racc_action_pointer = [
    -1,   130,   125,   125,   123,   112,   115,   nil,   nil,   nil,
   110,   108,   109,   nil,   nil,   nil,   102,    99,    78,   nil,
    62,    74,   nil,   nil,   nil,   nil,   nil,    56,    38,    69,
    20,   nil,   nil,   nil,   nil,   nil,    86,   nil,    14,     9,
   -17,    19,    90,    -8,   nil,   nil,     3,     2,    57,    55,
     8,   nil,    19,    31,   nil,   nil,    82,    42,    47,   nil,
   nil,   nil,   nil,    -3,   nil,   nil,   nil,   nil,    38,    27,
   nil,    58,   nil,   nil,   103,    98,    93,   105,   106,   nil,
    95,   nil,   104,   nil,   nil,    32,   108,   106,   nil,    35,
   nil,   nil,   nil,   nil,   nil,    39,   nil,   nil,   nil,   nil,
    -1,   nil,   nil,   nil,    37,   nil,   112,    -8,   117,   118,
   nil,   115,   116,   nil,   nil,    27,   nil,    14,    55,   125,
   121,   115,   nil,   113,   nil,   nil,   124,   nil,   nil,   nil,
   nil,   nil,   nil,   129,   nil,   nil ]

racc_action_default = [
    -3,   -85,   -85,   -85,   -85,   -10,   -85,    -2,   136,    -1,
   -10,   -85,   -85,    -9,   -11,    -4,   -85,   -85,   -32,    -5,
    -8,   -85,   -26,   -27,   -28,   -29,   -30,   -85,   -85,    -8,
   -25,   -20,   -21,   -22,   -23,   -24,   -85,   -40,   -85,   -85,
   -85,   -56,   -14,   -34,    -6,    -7,   -17,   -85,   -85,   -85,
   -73,   -54,   -73,   -85,   -13,   -31,   -85,   -85,   -19,   -46,
   -47,   -48,   -49,   -73,   -57,   -58,   -59,   -60,   -63,   -66,
   -67,   -70,   -71,   -72,   -85,   -37,   -39,   -85,   -85,   -45,
   -85,   -12,   -85,   -15,   -16,   -73,   -85,   -53,   -61,   -73,
   -81,   -82,   -83,   -84,   -64,   -73,   -75,   -76,   -77,   -68,
   -73,   -78,   -79,   -80,   -73,   -35,   -85,   -73,   -85,   -85,
   -55,   -34,   -19,   -50,   -51,   -73,   -62,   -66,   -70,   -85,
   -37,   -85,   -41,   -44,   -33,   -18,   -53,   -65,   -69,   -74,
   -36,   -38,   -42,   -85,   -52,   -43 ]

racc_goto_table = [
    19,    58,    75,    55,    80,    79,    84,    94,   105,   114,
    99,    27,    28,    33,     9,    40,    77,    78,    87,    13,
     1,    45,    33,    57,    40,    54,    16,    53,   132,    47,
    21,    86,    17,    51,   116,    88,    81,    89,   117,     5,
   112,    33,    33,    40,    40,   118,     2,    90,   134,    82,
   nil,   nil,   nil,   130,   nil,   127,   119,   128,   nil,   121,
   125,   120,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   126,   124,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   122,   123,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   135 ]

racc_goto_check = [
     5,    16,    25,    24,    27,    16,    17,    40,    26,    33,
    44,    23,     7,    14,     4,    30,     8,     8,    16,     4,
     1,     7,    14,    15,    30,    13,    12,    11,    29,    23,
    10,    32,     6,    34,    36,    37,     5,    38,    39,     3,
    16,    14,    14,    30,    30,    43,     2,    50,    33,    23,
   nil,   nil,   nil,    26,   nil,    40,    27,    44,   nil,    27,
    17,    25,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
    16,    24,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,     5,     5,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,     5 ]

racc_goto_pointer = [
   nil,    20,    46,    37,     9,   -17,    17,    -8,   -32,   nil,
    12,   -15,    12,   -17,    -7,   -23,   -45,   -52,   nil,   nil,
   nil,   nil,   nil,    -7,   -40,   -45,   -67,   -48,   nil,   -95,
    -5,   nil,   -32,   -78,    -8,   nil,   -55,   -33,   -31,   -57,
   -62,   nil,   nil,   -55,   -61,   nil,   nil,   nil,   nil,   nil,
   -21 ]

racc_goto_default = [
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,    29,    10,
   nil,   nil,   nil,    22,    66,   nil,   nil,   nil,    31,    32,
    34,    35,    41,   nil,   nil,   nil,   nil,    59,    37,   nil,
    67,    62,   nil,   nil,   nil,    73,    68,   nil,   nil,    69,
   nil,    95,    70,    71,   nil,   100,    72,    74,    96,   101,
   nil ]

racc_reduce_table = [
  0, 0, :racc_error,
  3, 34, :_reduce_none,
  2, 35, :_reduce_none,
  0, 35, :_reduce_none,
  0, 39, :_reduce_4,
  5, 36, :_reduce_5,
  3, 38, :_reduce_none,
  2, 40, :_reduce_none,
  0, 40, :_reduce_none,
  2, 37, :_reduce_none,
  0, 37, :_reduce_none,
  0, 45, :_reduce_11,
  8, 42, :_reduce_12,
  1, 44, :_reduce_none,
  0, 44, :_reduce_none,
  4, 47, :_reduce_none,
  2, 48, :_reduce_none,
  0, 48, :_reduce_none,
  3, 50, :_reduce_none,
  0, 50, :_reduce_none,
  1, 41, :_reduce_none,
  1, 41, :_reduce_none,
  1, 41, :_reduce_none,
  1, 41, :_reduce_none,
  1, 41, :_reduce_none,
  1, 55, :_reduce_25,
  1, 56, :_reduce_26,
  1, 46, :_reduce_none,
  1, 46, :_reduce_none,
  1, 46, :_reduce_none,
  1, 46, :_reduce_none,
  3, 43, :_reduce_31,
  0, 43, :_reduce_none,
  4, 57, :_reduce_33,
  0, 57, :_reduce_none,
  4, 51, :_reduce_35,
  3, 59, :_reduce_36,
  0, 59, :_reduce_none,
  4, 58, :_reduce_none,
  1, 58, :_reduce_none,
  1, 54, :_reduce_none,
  5, 61, :_reduce_none,
  6, 53, :_reduce_none,
  2, 62, :_reduce_none,
  0, 62, :_reduce_none,
  3, 52, :_reduce_none,
  1, 49, :_reduce_none,
  1, 49, :_reduce_none,
  1, 49, :_reduce_none,
  1, 49, :_reduce_none,
  3, 64, :_reduce_none,
  2, 65, :_reduce_none,
  3, 66, :_reduce_none,
  0, 66, :_reduce_none,
  2, 63, :_reduce_none,
  3, 67, :_reduce_none,
  0, 67, :_reduce_none,
  1, 68, :_reduce_none,
  1, 68, :_reduce_none,
  1, 68, :_reduce_none,
  1, 68, :_reduce_none,
  2, 60, :_reduce_none,
  2, 70, :_reduce_62,
  0, 70, :_reduce_none,
  2, 69, :_reduce_none,
  3, 73, :_reduce_none,
  0, 73, :_reduce_none,
  1, 72, :_reduce_67,
  2, 75, :_reduce_none,
  3, 77, :_reduce_none,
  0, 77, :_reduce_none,
  1, 76, :_reduce_71,
  1, 79, :_reduce_72,
  0, 80, :_reduce_73,
  4, 79, :_reduce_74,
  1, 74, :_reduce_75,
  1, 81, :_reduce_none,
  1, 81, :_reduce_none,
  1, 78, :_reduce_78,
  1, 82, :_reduce_none,
  1, 82, :_reduce_none,
  1, 71, :_reduce_81,
  1, 83, :_reduce_none,
  1, 83, :_reduce_none,
  1, 83, :_reduce_none ]

racc_reduce_n = 85

racc_shift_n = 136

racc_token_table = {
  false => 0,
  :error => 1,
  :KEY_IMPORT => 2,
  :STRING => 3,
  :KEY_MAIN => 4,
  "(" => 5,
  ")" => 6,
  "{" => 7,
  "}" => 8,
  :KEY_FUNC => 9,
  :ID => 10,
  "," => 11,
  :KEY_STRING => 12,
  :KEY_INT => 13,
  :KEY_FLOAT => 14,
  :KEY_BOOLEAN => 15,
  :KEY_VAR => 16,
  "[" => 17,
  "]" => 18,
  :KEY_WHILE => 19,
  :KEY_IF => 20,
  :KEY_ELSE => 21,
  "=" => 22,
  :BOOLEAN => 23,
  :INT => 24,
  :FLOAT => 25,
  "+" => 26,
  "-" => 27,
  "*" => 28,
  "/" => 29,
  "!=" => 30,
  ">" => 31,
  "<" => 32 }

racc_nt_base = 33

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
  "KEY_IMPORT",
  "STRING",
  "KEY_MAIN",
  "\"(\"",
  "\")\"",
  "\"{\"",
  "\"}\"",
  "KEY_FUNC",
  "ID",
  "\",\"",
  "KEY_STRING",
  "KEY_INT",
  "KEY_FLOAT",
  "KEY_BOOLEAN",
  "KEY_VAR",
  "\"[\"",
  "\"]\"",
  "KEY_WHILE",
  "KEY_IF",
  "KEY_ELSE",
  "\"=\"",
  "BOOLEAN",
  "INT",
  "FLOAT",
  "\"+\"",
  "\"-\"",
  "\"*\"",
  "\"/\"",
  "\"!=\"",
  "\">\"",
  "\"<\"",
  "$start",
  "programa",
  "import",
  "main",
  "funciones",
  "bloque",
  "@1",
  "bloque_p",
  "estatuto",
  "funcion",
  "params",
  "return",
  "@2",
  "tipo_p",
  "llamada_funcion",
  "llamada_funcion_p",
  "asignacion_p",
  "llamada_funcion_pp",
  "vars",
  "asignacion",
  "condicion",
  "ciclo",
  "id",
  "tipo",
  "params_p",
  "vars_aux",
  "vars_p",
  "expresion",
  "while",
  "else",
  "id_o_arreglo",
  "nuevo_arreglo",
  "nuevo_arreglo_p",
  "nuevo_arreglo_aux",
  "arreglo_p",
  "var_cte",
  "es",
  "expresion_p",
  "operacion_relacional",
  "termino",
  "es_p",
  "suma_resta",
  "termino_p",
  "factor",
  "termino_pp",
  "mult_div",
  "factor_p",
  "@3",
  "suma_resta_p",
  "mult_div_p",
  "operacion_relacional_p" ]

Racc_debug_parser = false

##### State transition tables end #####

# reduce 0 omitted

# reduce 1 omitted

# reduce 2 omitted

# reduce 3 omitted

module_eval(<<'.,.,', 'parser.y', 9)
  def _reduce_4(val, _values, result)
    setup_scope
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 9)
  def _reduce_5(val, _values, result)
    update_scope
    result
  end
.,.,

# reduce 6 omitted

# reduce 7 omitted

# reduce 8 omitted

# reduce 9 omitted

# reduce 10 omitted

module_eval(<<'.,.,', 'parser.y', 18)
  def _reduce_11(val, _values, result)
    setup_scope
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 18)
  def _reduce_12(val, _values, result)
    update_scope
    result
  end
.,.,

# reduce 13 omitted

# reduce 14 omitted

# reduce 15 omitted

# reduce 16 omitted

# reduce 17 omitted

# reduce 18 omitted

# reduce 19 omitted

# reduce 20 omitted

# reduce 21 omitted

# reduce 22 omitted

# reduce 23 omitted

# reduce 24 omitted

module_eval(<<'.,.,', 'parser.y', 36)
  def _reduce_25(val, _values, result)
    check_for_existance(val[0])
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 38)
  def _reduce_26(val, _values, result)
    @types.push val[0];
    result
  end
.,.,

# reduce 27 omitted

# reduce 28 omitted

# reduce 29 omitted

# reduce 30 omitted

module_eval(<<'.,.,', 'parser.y', 45)
  def _reduce_31(val, _values, result)
    add_to_vars val[1], true
    result
  end
.,.,

# reduce 32 omitted

module_eval(<<'.,.,', 'parser.y', 48)
  def _reduce_33(val, _values, result)
    add_to_vars val[2], true
    result
  end
.,.,

# reduce 34 omitted

module_eval(<<'.,.,', 'parser.y', 51)
  def _reduce_35(val, _values, result)
    add_to_vars val[2]
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 52)
  def _reduce_36(val, _values, result)
    add_to_vars val[1]
    result
  end
.,.,

# reduce 37 omitted

# reduce 38 omitted

# reduce 39 omitted

# reduce 40 omitted

# reduce 41 omitted

# reduce 42 omitted

# reduce 43 omitted

# reduce 44 omitted

# reduce 45 omitted

# reduce 46 omitted

# reduce 47 omitted

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

module_eval(<<'.,.,', 'parser.y', 93)
  def _reduce_62(val, _values, result)
    
    result
  end
.,.,

# reduce 63 omitted

# reduce 64 omitted

# reduce 65 omitted

# reduce 66 omitted

module_eval(<<'.,.,', 'parser.y', 101)
  def _reduce_67(val, _values, result)
    
    result
  end
.,.,

# reduce 68 omitted

# reduce 69 omitted

# reduce 70 omitted

module_eval(<<'.,.,', 'parser.y', 106)
  def _reduce_71(val, _values, result)
    
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 107)
  def _reduce_72(val, _values, result)
    
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 108)
  def _reduce_73(val, _values, result)
    
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 108)
  def _reduce_74(val, _values, result)
    
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 110)
  def _reduce_75(val, _values, result)
     
    result
  end
.,.,

# reduce 76 omitted

# reduce 77 omitted

module_eval(<<'.,.,', 'parser.y', 114)
  def _reduce_78(val, _values, result)
    
    result
  end
.,.,

# reduce 79 omitted

# reduce 80 omitted

module_eval(<<'.,.,', 'parser.y', 118)
  def _reduce_81(val, _values, result)
    
    result
  end
.,.,

# reduce 82 omitted

# reduce 83 omitted

# reduce 84 omitted

def _reduce_none(val, _values, result)
  val[0]
end

  end   # class Parser
  end   # module Phast