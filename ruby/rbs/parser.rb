#
# DO NOT MODIFY!!!!
# This file is automatically generated by Racc 1.4.9
# from Racc grammer file "".
#

require 'racc/parser.rb'


module Phast
  class Parser < Racc::Parser

module_eval(<<'...end parser.y/module_eval...', 'parser.y', 108)

  def parse(tokens)
    @tokens = tokens
    @scopes = [[]]

    do_parse
  end

  def next_token
    @curr_token = @tokens.shift
  end

  def llame_var
    if @scopes.last.include? @curr_token[1]
        puts "usando ya existente #{@curr_token[1]}"
    else
        guarda_var
        puts "guardando #{@curr_token[1]}"
    end
  end

  def guarda_var
    @scopes.last.push(@curr_token[1])
  end

  def aumenta_scope
    @scopes.push []
  end

  def disminuye_scope
    @scopes.pop
  end
...end parser.y/module_eval...
##### State transition tables begin ###

racc_action_table = [
    -3,   116,    18,    20,    22,    23,    24,    25,   129,    28,
    74,    75,   129,   106,    18,    20,    22,    23,    24,    25,
   169,    28,    41,    42,    32,    26,    27,    70,    71,    29,
    70,    71,    30,    31,    32,   108,    33,    26,    27,    74,
    75,    29,   109,   -88,    30,    31,    32,   -88,    33,   -10,
   -10,    18,    20,    22,    23,    24,    25,    77,    28,    78,
   110,    79,   104,    18,    20,    22,    23,    24,    25,   103,
    28,   102,   114,   116,    26,    27,   117,    83,    29,   100,
    -3,    30,    31,    32,   120,    33,    26,    27,   121,   122,
    29,    92,    -3,    30,    31,    32,   124,    33,    18,    20,
    22,    23,    24,    25,    90,    28,    85,    83,   135,    81,
    18,    20,    22,    23,    24,    25,   137,    28,   138,   140,
   141,    26,    27,    57,    41,    29,    56,    -3,    30,    31,
    32,    55,    33,    26,    27,    54,   105,    29,   149,    -3,
    30,    31,    32,    53,    33,    18,    20,    22,    23,    24,
    25,   151,    28,    52,    37,   155,    35,    18,    20,    22,
    23,    24,    25,   158,    28,   159,   161,   162,    26,    27,
   163,   164,    29,   165,    -3,    30,    31,    32,   166,    33,
    26,    27,    34,   170,    29,     2,    -3,    30,    31,    32,
     3,    33,    18,    20,    22,    23,    24,    25,   140,    28,
    18,    20,    22,    23,    24,    25,   175,    28,   176,   155,
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
   nil,    28,    18,    20,    22,    23,    24,    25,   nil,    28,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,    26,    27,   nil,
   nil,   nil,   nil,   nil,   nil,    26,    27,    18,    20,    22,
    23,    24,    25,   nil,    28,    18,    20,    22,    23,    24,
    25,   nil,    28,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
    26,    27,   nil,   nil,   nil,   nil,   nil,   nil,    26,    27,
    18,    20,    22,    23,    24,    25,   nil,    28,    18,    20,
    22,    23,    24,    25,   nil,    28,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,    26,    27,   nil,   nil,   nil,   nil,   nil,
   nil,    26,    27,    18,    20,    22,    23,    24,    25,   nil,
    28,    18,    20,    22,    23,    24,    25,   nil,    28,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,    26,    27,   nil,   nil,
   nil,   nil,   nil,   nil,    26,    27,    18,    20,    22,    23,
    24,    25,   nil,    28,    20,    22,    23,    24,    25,   nil,
    28,    60,    61,    62,    63,    64,    65,    66,    67,    26,
    27,   nil,   nil,   nil,   nil,   nil,    26,    27,    60,    61,
    62,    63,    64,    65,    66,    67 ]

racc_action_check = [
     2,   133,     2,     2,     2,     2,     2,     2,   127,     2,
   132,   132,   109,    89,     5,     5,     5,     5,     5,     5,
   161,     5,    12,    12,   161,     2,     2,   131,   131,     2,
    44,    44,     2,     2,     2,    90,     2,     5,     5,    45,
    45,     5,    91,   127,     5,     5,     5,   109,     5,     5,
     5,   138,   138,   138,   138,   138,   138,    46,   138,    46,
    92,    46,    87,   170,   170,   170,   170,   170,   170,    86,
   170,    85,    96,    97,   138,   138,    98,   101,   138,    80,
   138,   138,   138,   138,   103,   138,   170,   170,   104,   105,
   170,    57,   170,   170,   170,   170,   107,   170,   120,   120,
   120,   120,   120,   120,    56,   120,    50,    49,   121,    48,
   122,   122,   122,   122,   122,   122,   123,   122,   124,   125,
   126,   120,   120,    42,   128,   120,    41,   120,   120,   120,
   120,    33,   120,   122,   122,    32,    88,   122,   134,   122,
   122,   122,   122,    30,   122,    53,    53,    53,    53,    53,
    53,   136,    53,    29,     6,   139,     4,   169,   169,   169,
   169,   169,   169,   144,   169,   150,   151,   152,    53,    53,
   153,   155,    53,   157,    53,    53,    53,    53,   159,    53,
   169,   169,     3,   162,   169,     0,   169,   169,   169,   169,
     1,   169,    78,    78,    78,    78,    78,    78,   171,    78,
   102,   102,   102,   102,   102,   102,   172,   102,   173,   174,
   nil,   nil,   nil,   nil,   nil,    78,    78,   nil,   nil,   nil,
   nil,   nil,   nil,   102,   102,    79,    79,    79,    79,    79,
    79,   nil,    79,   135,   135,   135,   135,   135,   135,   nil,
   135,   nil,   nil,   nil,   nil,   nil,   nil,   nil,    79,    79,
   nil,   nil,   nil,   nil,   nil,   nil,   135,   135,   137,   137,
   137,   137,   137,   137,   nil,   137,    77,    77,    77,    77,
    77,    77,   nil,    77,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   137,   137,   nil,   nil,   nil,   nil,   nil,   nil,    77,
    77,   106,   106,   106,   106,   106,   106,   nil,   106,    28,
    28,    28,    28,    28,    28,   nil,    28,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   106,   106,   nil,   nil,   nil,   nil,
   nil,   nil,    28,    28,    55,    55,    55,    55,    55,    55,
   nil,    55,    47,    47,    47,    47,    47,    47,   nil,    47,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,    55,    55,   nil,
   nil,   nil,   nil,   nil,   nil,    47,    47,    83,    83,    83,
    83,    83,    83,   nil,    83,    95,    95,    95,    95,    95,
    95,   nil,    95,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
    83,    83,   nil,   nil,   nil,   nil,   nil,   nil,    95,    95,
   116,   116,   116,   116,   116,   116,   nil,   116,    52,    52,
    52,    52,    52,    52,   nil,    52,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   116,   116,   nil,   nil,   nil,   nil,   nil,
   nil,    52,    52,    94,    94,    94,    94,    94,    94,   nil,
    94,    54,    54,    54,    54,    54,    54,   nil,    54,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,    94,    94,   nil,   nil,
   nil,   nil,   nil,   nil,    54,    54,    93,    93,    93,    93,
    93,    93,   nil,    93,   140,   140,   140,   140,   140,   nil,
   140,   130,   130,   130,   130,   130,   130,   130,   130,    93,
    93,   nil,   nil,   nil,   nil,   nil,   140,   140,    43,    43,
    43,    43,    43,    43,    43,    43 ]

racc_action_pointer = [
   183,   190,    -3,   182,   153,     9,   150,   nil,   nil,   nil,
   nil,   nil,   -18,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   294,   143,
   110,   nil,   125,   121,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   121,   118,   472,     6,    13,    47,   327,    96,    92,
    76,   nil,   393,   140,   426,   319,    94,    49,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   261,   187,   220,
    68,   nil,   nil,   352,   nil,    40,    58,    28,   125,     9,
    30,     9,    55,   451,   418,   360,    61,    58,    63,   nil,
   nil,    62,   195,    51,    56,    56,   286,    85,   nil,     7,
   nil,   nil,   nil,   nil,   nil,   nil,   385,   nil,   nil,   nil,
    93,    98,   105,   112,    85,    89,    86,     3,    84,   nil,
   455,     3,   -16,   -14,   104,   228,   117,   253,    46,   140,
   458,   nil,   nil,   nil,   149,   nil,   nil,   nil,   nil,   nil,
   154,   128,   156,   136,   nil,   166,   nil,   169,   nil,   174,
   nil,   -13,   150,   nil,   nil,   nil,   nil,   nil,   nil,   152,
    58,   168,   172,   174,   194,   nil,   nil,   nil ]

racc_action_default = [
  -104,  -104,   -10,  -104,  -104,    -3,  -104,    -5,    -6,    -7,
    -8,    -9,  -104,   -14,   -20,   -26,   -32,   -33,   -34,   -36,
   -37,   -38,   -39,   -40,   -41,   -42,   -64,   -65,   -68,  -104,
  -104,   -77,  -104,  -104,   178,    -1,    -2,    -4,   -11,   -12,
   -13,  -104,  -104,   -19,   -25,   -31,   -47,  -104,  -104,   -70,
   -73,   -74,  -104,   -10,  -104,  -104,  -104,   -95,   -15,   -16,
   -52,   -53,   -54,   -55,   -56,   -57,   -58,   -59,   -21,   -22,
   -60,   -61,   -27,   -28,   -62,   -63,   -35,   -49,  -104,  -104,
  -104,   -66,   -67,  -104,   -71,  -104,  -104,  -104,  -104,  -104,
   -98,  -104,  -104,  -104,  -104,  -104,  -104,   -51,  -104,   -46,
   -43,   -70,  -104,  -104,  -104,  -104,  -104,  -104,   -96,   -87,
   -94,   -17,   -23,   -29,   -44,   -48,  -104,   -45,   -69,   -72,
   -10,  -104,   -10,  -104,  -104,  -103,  -104,   -87,  -104,   -90,
   -19,   -25,   -31,   -51,  -104,  -104,  -104,  -104,   -10,  -101,
  -104,   -85,   -86,   -89,   -93,   -18,   -24,   -30,   -50,   -75,
  -104,   -80,  -104,  -104,   -97,  -104,  -102,  -104,   -92,  -104,
   -78,  -104,  -104,   -84,   -99,   -91,   -76,   -79,   -81,   -10,
   -10,  -103,  -104,  -104,  -101,   -82,   -83,  -100 ]

racc_goto_table = [
     4,    39,    58,    36,    51,    49,    72,    68,    89,    82,
   139,   115,   156,   154,   126,    44,    94,   131,   113,   130,
    45,    95,   132,    80,   112,    76,    46,    47,    86,    96,
    88,    93,   142,    48,    43,    40,   119,    84,   160,   167,
   107,    91,    38,   157,   144,   168,   111,   148,   177,     1,
   125,    87,   171,    97,    98,    99,   174,   nil,   nil,    51,
   101,   118,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,    51,   nil,
   nil,   nil,   123,   nil,   nil,   nil,   nil,   nil,   nil,   145,
   nil,   nil,   133,   147,   146,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   150,   nil,   152,   nil,   nil,   nil,   143,   134,   nil,
   136,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   153,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   172,   173 ]

racc_goto_check = [
     2,    12,    15,     2,     4,    42,    27,    21,    14,    43,
    55,    40,    33,    56,    50,    22,    24,    25,    26,    19,
    28,    30,    31,     4,    20,    34,    35,    38,     4,    39,
     4,    18,    50,    41,    16,    13,    44,    45,    46,    47,
    48,    49,    10,    52,    54,     8,    14,    40,    56,     1,
    57,     2,    58,     4,     4,     4,    55,   nil,   nil,     4,
    42,    43,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,     4,   nil,
   nil,   nil,     4,   nil,   nil,   nil,   nil,   nil,   nil,    15,
   nil,   nil,     4,    27,    21,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,     4,   nil,     4,   nil,   nil,   nil,    12,     2,   nil,
     2,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,     2,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,     2,     2 ]

racc_goto_pointer = [
   nil,    49,    -2,   nil,   -24,   nil,   nil,   nil,  -116,   nil,
    30,   nil,   -11,    23,   -47,   -41,    21,   nil,   -28,   -92,
   -70,   -37,     1,   nil,   -53,   -95,   -77,   -39,     5,   nil,
   -52,   -91,   nil,  -128,   -21,     8,   nil,   nil,     2,   -48,
   -86,     5,   -23,   -40,   -66,   -13,  -113,  -122,   -50,   -16,
   -95,   nil,  -101,   nil,   -85,  -115,  -126,   -58,  -112 ]

racc_goto_default = [
   nil,   nil,   nil,     5,     6,     7,     8,     9,    10,    11,
   nil,    12,   nil,   nil,    13,   nil,   nil,    59,   nil,   nil,
    14,   nil,   nil,    69,   nil,   nil,    15,   nil,   nil,    73,
   nil,   nil,    16,    17,   nil,   nil,    19,    21,   nil,   nil,
   nil,   nil,   nil,   nil,    50,   nil,   nil,   nil,   nil,   nil,
   nil,   127,   nil,   128,   nil,   nil,   nil,   nil,   nil ]

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
  3, 75, :_reduce_none,
  1, 76, :_reduce_none,
  1, 76, :_reduce_none,
  1, 76, :_reduce_none,
  1, 76, :_reduce_none,
  1, 76, :_reduce_none,
  1, 76, :_reduce_none,
  0, 81, :_reduce_42,
  4, 76, :_reduce_43,
  3, 77, :_reduce_none,
  3, 77, :_reduce_none,
  2, 77, :_reduce_46,
  0, 77, :_reduce_none,
  2, 82, :_reduce_none,
  0, 82, :_reduce_none,
  3, 83, :_reduce_none,
  0, 83, :_reduce_none,
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
  1, 79, :_reduce_64,
  1, 79, :_reduce_65,
  3, 80, :_reduce_none,
  2, 84, :_reduce_none,
  0, 84, :_reduce_none,
  3, 86, :_reduce_none,
  0, 86, :_reduce_none,
  2, 85, :_reduce_none,
  3, 88, :_reduce_none,
  0, 88, :_reduce_none,
  1, 87, :_reduce_none,
  7, 48, :_reduce_none,
  9, 49, :_reduce_none,
  1, 50, :_reduce_none,
  8, 51, :_reduce_none,
  2, 89, :_reduce_none,
  0, 89, :_reduce_none,
  1, 90, :_reduce_none,
  3, 90, :_reduce_none,
  11, 52, :_reduce_none,
  8, 55, :_reduce_none,
  6, 56, :_reduce_none,
  2, 93, :_reduce_none,
  0, 93, :_reduce_none,
  0, 96, :_reduce_88,
  2, 94, :_reduce_89,
  0, 97, :_reduce_90,
  4, 94, :_reduce_none,
  1, 95, :_reduce_none,
  0, 95, :_reduce_none,
  2, 92, :_reduce_none,
  0, 92, :_reduce_none,
  0, 100, :_reduce_96,
  4, 91, :_reduce_none,
  0, 91, :_reduce_none,
  0, 101, :_reduce_99,
  5, 99, :_reduce_none,
  0, 99, :_reduce_none,
  2, 98, :_reduce_none,
  0, 98, :_reduce_none ]

racc_reduce_n = 104

racc_shift_n = 178

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
  "numero",
  "arreglo",
  "@12",
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
  "@13",
  "@14",
  "def_param",
  "params_aux",
  "@15",
  "@16" ]

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

module_eval(<<'.,.,', 'parser.y', 16)
  def _reduce_14(val, _values, result)
    
    result
  end
.,.,

# reduce 15 omitted

module_eval(<<'.,.,', 'parser.y', 17)
  def _reduce_16(val, _values, result)
    
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 17)
  def _reduce_17(val, _values, result)
    
    result
  end
.,.,

# reduce 18 omitted

# reduce 19 omitted

module_eval(<<'.,.,', 'parser.y', 19)
  def _reduce_20(val, _values, result)
    
    result
  end
.,.,

# reduce 21 omitted

module_eval(<<'.,.,', 'parser.y', 20)
  def _reduce_22(val, _values, result)
    
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 20)
  def _reduce_23(val, _values, result)
    
    result
  end
.,.,

# reduce 24 omitted

# reduce 25 omitted

module_eval(<<'.,.,', 'parser.y', 22)
  def _reduce_26(val, _values, result)
    
    result
  end
.,.,

# reduce 27 omitted

module_eval(<<'.,.,', 'parser.y', 23)
  def _reduce_28(val, _values, result)
    
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 23)
  def _reduce_29(val, _values, result)
    
    result
  end
.,.,

# reduce 30 omitted

# reduce 31 omitted

# reduce 32 omitted

module_eval(<<'.,.,', 'parser.y', 26)
  def _reduce_33(val, _values, result)
    
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 27)
  def _reduce_34(val, _values, result)
     llame_var 
    result
  end
.,.,

# reduce 35 omitted

# reduce 36 omitted

# reduce 37 omitted

# reduce 38 omitted

# reduce 39 omitted

# reduce 40 omitted

# reduce 41 omitted

module_eval(<<'.,.,', 'parser.y', 36)
  def _reduce_42(val, _values, result)
    
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 36)
  def _reduce_43(val, _values, result)
    
    result
  end
.,.,

# reduce 44 omitted

# reduce 45 omitted

module_eval(<<'.,.,', 'parser.y', 42)
  def _reduce_46(val, _values, result)
    
    result
  end
.,.,

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

# reduce 62 omitted

# reduce 63 omitted

module_eval(<<'.,.,', 'parser.y', 63)
  def _reduce_64(val, _values, result)
    
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 64)
  def _reduce_65(val, _values, result)
    
    result
  end
.,.,

# reduce 66 omitted

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

module_eval(<<'.,.,', 'parser.y', 89)
  def _reduce_88(val, _values, result)
     aumenta_scope 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 89)
  def _reduce_89(val, _values, result)
     disminuye_scope 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 90)
  def _reduce_90(val, _values, result)
     llame_var 
    result
  end
.,.,

# reduce 91 omitted

# reduce 92 omitted

# reduce 93 omitted

# reduce 94 omitted

# reduce 95 omitted

module_eval(<<'.,.,', 'parser.y', 96)
  def _reduce_96(val, _values, result)
     llame_var 
    result
  end
.,.,

# reduce 97 omitted

# reduce 98 omitted

module_eval(<<'.,.,', 'parser.y', 98)
  def _reduce_99(val, _values, result)
     llame_var 
    result
  end
.,.,

# reduce 100 omitted

# reduce 101 omitted

# reduce 102 omitted

# reduce 103 omitted

def _reduce_none(val, _values, result)
  val[0]
end

  end   # class Parser
  end   # module Phast
