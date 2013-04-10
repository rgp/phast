/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton implementation for Bison's Yacc-like parsers in C

   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "2.3"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Using locations.  */
#define YYLSP_NEEDED 0



/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     VERBOSE_BLOCK = 258,
     ID = 259,
     FUNCID = 260,
     INT = 261,
     FLOAT = 262,
     WORD_INT = 263,
     WORD_FLOAT = 264,
     STRING = 265,
     WORD_NULL = 266,
     WORD_FALSE = 267,
     WORD_TRUE = 268,
     WORD_IF = 269,
     WORD_ELSE = 270,
     WORD_WHILE = 271,
     WORD_FOR = 272,
     WORD_CLASS = 273,
     WORD_EXTENDS = 274,
     WORD_IMPLEMENTS = 275,
     WORD_DO = 276,
     WORD_SWITCH = 277,
     WORD_CASE = 278,
     WORD_BREAK = 279,
     WORD_DEFAULT = 280,
     WORD_CONTINUE = 281,
     WORD_FUN = 282,
     WORD_RETURN = 283,
     WORD_STATIC = 284,
     WORD_ABSTRACT = 285,
     WORD_PUBLIC = 286,
     WORD_PRIVATE = 287,
     WORD_PROTECTED = 288,
     WORD_NEW = 289,
     WORD_AND = 290,
     WORD_OR = 291,
     WORD_NOT = 292,
     WORD_XOR = 293,
     WORD_TRY = 294,
     WORD_CATCH = 295,
     WORD_THROW = 296,
     OP_IDENTICAL = 297,
     OP_EQUAL = 298,
     OP_NOT_EQUAL = 299,
     OP_ASIGN = 300,
     OP_MULTIPLY = 301,
     OP_DIVIDE = 302,
     OP_PLUS = 303,
     OP_MINUS = 304,
     OP_INCREMENT = 305,
     OP_DECREMENT = 306,
     OP_GREATER = 307,
     OP_GREATER_EQUAL = 308,
     OP_LESS = 309,
     OP_LESS_EQUAL = 310,
     PH_OT = 311,
     PH_CT = 312
   };
#endif
/* Tokens.  */
#define VERBOSE_BLOCK 258
#define ID 259
#define FUNCID 260
#define INT 261
#define FLOAT 262
#define WORD_INT 263
#define WORD_FLOAT 264
#define STRING 265
#define WORD_NULL 266
#define WORD_FALSE 267
#define WORD_TRUE 268
#define WORD_IF 269
#define WORD_ELSE 270
#define WORD_WHILE 271
#define WORD_FOR 272
#define WORD_CLASS 273
#define WORD_EXTENDS 274
#define WORD_IMPLEMENTS 275
#define WORD_DO 276
#define WORD_SWITCH 277
#define WORD_CASE 278
#define WORD_BREAK 279
#define WORD_DEFAULT 280
#define WORD_CONTINUE 281
#define WORD_FUN 282
#define WORD_RETURN 283
#define WORD_STATIC 284
#define WORD_ABSTRACT 285
#define WORD_PUBLIC 286
#define WORD_PRIVATE 287
#define WORD_PROTECTED 288
#define WORD_NEW 289
#define WORD_AND 290
#define WORD_OR 291
#define WORD_NOT 292
#define WORD_XOR 293
#define WORD_TRY 294
#define WORD_CATCH 295
#define WORD_THROW 296
#define OP_IDENTICAL 297
#define OP_EQUAL 298
#define OP_NOT_EQUAL 299
#define OP_ASIGN 300
#define OP_MULTIPLY 301
#define OP_DIVIDE 302
#define OP_PLUS 303
#define OP_MINUS 304
#define OP_INCREMENT 305
#define OP_DECREMENT 306
#define OP_GREATER 307
#define OP_GREATER_EQUAL 308
#define OP_LESS 309
#define OP_LESS_EQUAL 310
#define PH_OT 311
#define PH_CT 312




/* Copy the first part of user declarations.  */
#line 28 "src/syntax-phast.y"

#include "../../src/heading.h"

#include "../../src/lib/strmap.h"
#include "../../src/lib/hashmap.h"
#include "../../src/lib/pilaScopes.h"
#include "../../src/lib/chain.h"

int yyerror(char *s);
int yylex(void);

/* FROM LEX */
extern FILE *yyin;
extern char *yytext;
/* END FROM LEX */

Scope *scopes;
hashmap* global;

char* var_actual;
char* valor_actual;
TIPO_DATO tipo_actual;

Node* pila_operandos;
Node* pila_operadores;



/* Enabling traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 1
#endif

/* Enabling the token table.  */
#ifndef YYTOKEN_TABLE
# define YYTOKEN_TABLE 0
#endif

#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
#line 55 "src/syntax-phast.y"
{
  int int_val;
  float float_val;
  char*	op_val;
}
/* Line 193 of yacc.c.  */
#line 244 "bison/src/bison.c"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif



/* Copy the second part of user declarations.  */


/* Line 216 of yacc.c.  */
#line 257 "bison/src/bison.c"

#ifdef short
# undef short
#endif

#ifdef YYTYPE_UINT8
typedef YYTYPE_UINT8 yytype_uint8;
#else
typedef unsigned char yytype_uint8;
#endif

#ifdef YYTYPE_INT8
typedef YYTYPE_INT8 yytype_int8;
#elif (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
typedef signed char yytype_int8;
#else
typedef short int yytype_int8;
#endif

#ifdef YYTYPE_UINT16
typedef YYTYPE_UINT16 yytype_uint16;
#else
typedef unsigned short int yytype_uint16;
#endif

#ifdef YYTYPE_INT16
typedef YYTYPE_INT16 yytype_int16;
#else
typedef short int yytype_int16;
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif ! defined YYSIZE_T && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned int
# endif
#endif

#define YYSIZE_MAXIMUM ((YYSIZE_T) -1)

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(msgid) dgettext ("bison-runtime", msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(msgid) msgid
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(e) ((void) (e))
#else
# define YYUSE(e) /* empty */
#endif

/* Identity function, used to suppress warnings about constant conditions.  */
#ifndef lint
# define YYID(n) (n)
#else
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static int
YYID (int i)
#else
static int
YYID (i)
    int i;
#endif
{
  return i;
}
#endif

#if ! defined yyoverflow || YYERROR_VERBOSE

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#     ifndef _STDLIB_H
#      define _STDLIB_H 1
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's `empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (YYID (0))
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined _STDLIB_H \
       && ! ((defined YYMALLOC || defined malloc) \
	     && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef _STDLIB_H
#    define _STDLIB_H 1
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* ! defined yyoverflow || YYERROR_VERBOSE */


#if (! defined yyoverflow \
     && (! defined __cplusplus \
	 || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yytype_int16 yyss;
  YYSTYPE yyvs;
  };

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (sizeof (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (sizeof (yytype_int16) + sizeof (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

/* Copy COUNT objects from FROM to TO.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(To, From, Count) \
      __builtin_memcpy (To, From, (Count) * sizeof (*(From)))
#  else
#   define YYCOPY(To, From, Count)		\
      do					\
	{					\
	  YYSIZE_T yyi;				\
	  for (yyi = 0; yyi < (Count); yyi++)	\
	    (To)[yyi] = (From)[yyi];		\
	}					\
      while (YYID (0))
#  endif
# endif

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack)					\
    do									\
      {									\
	YYSIZE_T yynewbytes;						\
	YYCOPY (&yyptr->Stack, Stack, yysize);				\
	Stack = &yyptr->Stack;						\
	yynewbytes = yystacksize * sizeof (*Stack) + YYSTACK_GAP_MAXIMUM; \
	yyptr += yynewbytes / sizeof (*yyptr);				\
      }									\
    while (YYID (0))

#endif

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  33
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   171

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  68
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  60
/* YYNRULES -- Number of rules.  */
#define YYNRULES  105
/* YYNRULES -- Number of states.  */
#define YYNSTATES  178

/* YYTRANSLATE(YYLEX) -- Bison symbol number corresponding to YYLEX.  */
#define YYUNDEFTOK  2
#define YYMAXUTOK   312

#define YYTRANSLATE(YYX)						\
  ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[YYLEX] -- Bison symbol number corresponding to YYLEX.  */
static const yytype_uint8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
      59,    60,     2,     2,    63,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,    58,
       2,    64,    65,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,    61,     2,    62,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,    66,     2,    67,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
      35,    36,    37,    38,    39,    40,    41,    42,    43,    44,
      45,    46,    47,    48,    49,    50,    51,    52,    53,    54,
      55,    56,    57
};

#if YYDEBUG
/* YYPRHS[YYN] -- Index of the first RHS symbol of rule number YYN in
   YYRHS.  */
static const yytype_uint16 yyprhs[] =
{
       0,     0,     3,     7,    10,    11,    12,    16,    18,    20,
      22,    24,    26,    27,    30,    32,    34,    35,    39,    40,
      41,    47,    48,    49,    53,    54,    55,    61,    62,    63,
      67,    68,    69,    75,    76,    78,    80,    81,    85,    87,
      89,    91,    93,    95,    97,    98,   103,   107,   111,   114,
     115,   118,   119,   123,   124,   126,   128,   130,   132,   134,
     136,   138,   140,   142,   144,   146,   148,   150,   152,   156,
     159,   160,   164,   165,   168,   172,   173,   175,   183,   193,
     195,   204,   207,   208,   210,   214,   226,   235,   242,   245,
     246,   247,   250,   251,   256,   258,   259,   262,   263,   264,
     269,   270,   271,   277,   278,   281
};

/* YYRHS -- A `-1'-separated list of the rules' RHS.  */
static const yytype_int8 yyrhs[] =
{
      69,     0,    -1,    56,    70,    57,    -1,    71,    70,    -1,
      -1,    -1,    75,    72,    58,    -1,   108,    -1,   109,    -1,
     110,    -1,   111,    -1,   114,    -1,    -1,    73,    74,    -1,
     115,    -1,   116,    -1,    -1,    80,    76,    77,    -1,    -1,
      -1,    98,    78,    80,    79,    77,    -1,    -1,    -1,    85,
      81,    82,    -1,    -1,    -1,    99,    83,    85,    84,    82,
      -1,    -1,    -1,    90,    86,    87,    -1,    -1,    -1,   100,
      88,    90,    89,    87,    -1,    -1,    91,    -1,    93,    -1,
      -1,     4,    92,    95,    -1,   101,    -1,    10,    -1,   102,
      -1,    13,    -1,    12,    -1,    11,    -1,    -1,    59,    94,
      75,    60,    -1,    59,    96,    60,    -1,    61,    75,    62,
      -1,    45,    75,    -1,    -1,    75,    97,    -1,    -1,    63,
      75,    97,    -1,    -1,    43,    -1,    44,    -1,    52,    -1,
      53,    -1,    54,    -1,    55,    -1,    35,    -1,    36,    -1,
      48,    -1,    49,    -1,    46,    -1,    47,    -1,     6,    -1,
       7,    -1,    61,   103,    62,    -1,   105,   104,    -1,    -1,
      63,   105,   104,    -1,    -1,   107,   106,    -1,    64,    65,
     107,    -1,    -1,    75,    -1,    16,    59,    75,    60,    66,
      70,    67,    -1,    21,    66,    70,    67,    16,    59,    75,
      60,    58,    -1,     3,    -1,    14,    59,    75,    60,    66,
      70,    67,   112,    -1,    15,   113,    -1,    -1,   111,    -1,
      66,    70,    67,    -1,    17,    59,    80,    58,    75,    58,
      75,    60,    66,    70,    67,    -1,    27,     4,    59,   123,
      60,    66,    70,    67,    -1,    18,     4,   122,    66,   117,
      67,    -1,   118,   117,    -1,    -1,    -1,   119,   115,    -1,
      -1,     4,   120,   121,    58,    -1,    45,    -1,    -1,    19,
       4,    -1,    -1,    -1,     4,   124,   127,   125,    -1,    -1,
      -1,    63,     4,   126,   127,   125,    -1,    -1,    64,    93,
      -1,    -1
};

/* YYRLINE[YYN] -- source line where rule number YYN was defined.  */
static const yytype_uint8 yyrline[] =
{
       0,   127,   127,   128,   129,   130,   130,   131,   132,   133,
     134,   135,   136,   136,   137,   138,   139,   139,   140,   140,
     140,   141,   142,   142,   143,   143,   143,   144,   145,   145,
     146,   146,   146,   147,   148,   149,   150,   150,   151,   152,
     153,   156,   157,   158,   159,   159,   161,   162,   165,   166,
     167,   168,   169,   170,   171,   172,   173,   174,   175,   176,
     177,   178,   180,   181,   183,   184,   186,   187,   188,   189,
     190,   191,   192,   193,   194,   195,   196,   198,   199,   200,
     201,   202,   203,   204,   205,   206,   207,   209,   210,   211,
     212,   212,   213,   213,   214,   215,   216,   217,   219,   219,
     220,   221,   221,   222,   223,   224
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || YYTOKEN_TABLE
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "VERBOSE_BLOCK", "ID", "FUNCID", "INT",
  "FLOAT", "WORD_INT", "WORD_FLOAT", "STRING", "WORD_NULL", "WORD_FALSE",
  "WORD_TRUE", "WORD_IF", "WORD_ELSE", "WORD_WHILE", "WORD_FOR",
  "WORD_CLASS", "WORD_EXTENDS", "WORD_IMPLEMENTS", "WORD_DO",
  "WORD_SWITCH", "WORD_CASE", "WORD_BREAK", "WORD_DEFAULT",
  "WORD_CONTINUE", "WORD_FUN", "WORD_RETURN", "WORD_STATIC",
  "WORD_ABSTRACT", "WORD_PUBLIC", "WORD_PRIVATE", "WORD_PROTECTED",
  "WORD_NEW", "WORD_AND", "WORD_OR", "WORD_NOT", "WORD_XOR", "WORD_TRY",
  "WORD_CATCH", "WORD_THROW", "OP_IDENTICAL", "OP_EQUAL", "OP_NOT_EQUAL",
  "OP_ASIGN", "OP_MULTIPLY", "OP_DIVIDE", "OP_PLUS", "OP_MINUS",
  "OP_INCREMENT", "OP_DECREMENT", "OP_GREATER", "OP_GREATER_EQUAL",
  "OP_LESS", "OP_LESS_EQUAL", "PH_OT", "PH_CT", "';'", "'('", "')'", "'['",
  "']'", "','", "'='", "'>'", "'{'", "'}'", "$accept", "phast",
  "estatutos", "estatuto", "@1", "@2", "bloques_declarativos", "expresion",
  "@3", "comparando_aux", "@4", "@5", "comparando", "@6", "termino_aux",
  "@7", "@8", "termino", "@9", "factor_aux", "@10", "@11", "factor",
  "llamada", "@12", "estatico", "@13", "id_call", "argumentos", "args_aux",
  "op_comp", "op_term", "op_fact", "numero", "arreglo", "_arr_elems",
  "_arr_elems_aux", "_arr_elem", "_arr_elem_aux", "_arr_val",
  "bloque_while", "bloque_do", "bloque_verbose", "bloque_if", "_else",
  "_aux_else", "bloque_for", "bloque_fun", "bloque_class", "_class_body",
  "_class_body_aux", "@14", "@15", "_class_def_var_aux", "_class_extras",
  "_params", "@16", "_params_aux", "@17", "_def_param", 0
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[YYLEX-NUM] -- Internal token number corresponding to
   token YYLEX-NUM.  */
static const yytype_uint16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
     285,   286,   287,   288,   289,   290,   291,   292,   293,   294,
     295,   296,   297,   298,   299,   300,   301,   302,   303,   304,
     305,   306,   307,   308,   309,   310,   311,   312,    59,    40,
      41,    91,    93,    44,    61,    62,   123,   125
};
# endif

/* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_uint8 yyr1[] =
{
       0,    68,    69,    70,    70,    72,    71,    71,    71,    71,
      71,    71,    73,    71,    74,    74,    76,    75,    78,    79,
      77,    77,    81,    80,    83,    84,    82,    82,    86,    85,
      88,    89,    87,    87,    90,    90,    92,    91,    93,    93,
      93,    93,    93,    93,    94,    93,    95,    95,    95,    95,
      96,    96,    97,    97,    98,    98,    98,    98,    98,    98,
      98,    98,    99,    99,   100,   100,   101,   101,   102,   103,
     103,   104,   104,   105,   106,   106,   107,   108,   109,   110,
     111,   112,   112,   113,   113,   114,   115,   116,   117,   117,
     119,   118,   120,   118,   121,   121,   122,   122,   124,   123,
     123,   126,   125,   125,   127,   127
};

/* YYR2[YYN] -- Number of symbols composing right hand side of rule YYN.  */
static const yytype_uint8 yyr2[] =
{
       0,     2,     3,     2,     0,     0,     3,     1,     1,     1,
       1,     1,     0,     2,     1,     1,     0,     3,     0,     0,
       5,     0,     0,     3,     0,     0,     5,     0,     0,     3,
       0,     0,     5,     0,     1,     1,     0,     3,     1,     1,
       1,     1,     1,     1,     0,     4,     3,     3,     2,     0,
       2,     0,     3,     0,     1,     1,     1,     1,     1,     1,
       1,     1,     1,     1,     1,     1,     1,     1,     3,     2,
       0,     3,     0,     2,     3,     0,     1,     7,     9,     1,
       8,     2,     0,     1,     3,    11,     8,     6,     2,     0,
       0,     2,     0,     4,     1,     0,     2,     0,     0,     4,
       0,     0,     5,     0,     2,     0
};

/* YYDEFACT[STATE-NAME] -- Default rule to reduce with in state
   STATE-NUM when YYTABLE doesn't specify something else to do.  Zero
   means the default is an error.  */
static const yytype_uint8 yydefact[] =
{
       0,    12,     0,    79,    36,    66,    67,    39,    43,    42,
      41,     0,     0,     0,     0,    44,    70,     0,     4,     0,
       5,    16,    22,    28,    34,    35,    38,    40,     7,     8,
       9,    10,    11,     1,    49,     0,     0,     0,    12,     0,
      76,     0,    72,    75,     2,     3,     0,     0,    13,    14,
      15,     0,    21,    27,    33,     0,    51,     0,    37,     0,
       0,     0,     0,     0,    68,     0,    69,     0,    73,    97,
       0,     6,    60,    61,    54,    55,    56,    57,    58,    59,
      17,    18,    62,    63,    23,    24,    64,    65,    29,    30,
      48,    53,     0,     0,     0,     0,     0,     0,    45,    72,
       0,     0,     0,   100,     0,     0,     0,     0,    50,    46,
      47,    12,    12,     0,     0,    71,    74,    96,    89,    98,
       0,    19,    25,    31,    53,     0,     0,     0,     0,    92,
       0,    89,     0,   105,     0,    21,    27,    33,    52,    82,
      77,     0,     0,    95,    87,    88,    91,     0,   103,    12,
      20,    26,    32,     0,    80,     0,     0,    94,     0,   104,
       0,    99,     0,    12,    83,    81,    12,    78,    93,   101,
      86,     0,     0,   105,    84,    85,   103,   102
};

/* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int16 yydefgoto[] =
{
      -1,     2,    17,    18,    51,    19,    48,    20,    52,    80,
     104,   135,    21,    53,    84,   105,   136,    22,    54,    88,
     106,   137,    23,    24,    34,    25,    39,    58,    92,   108,
      81,    85,    89,    26,    27,    41,    66,    42,    68,    43,
      28,    29,    30,    31,   154,   165,    32,    49,    50,   130,
     131,   132,   143,   158,   102,   120,   133,   161,   173,   148
};

/* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
   STATE-NUM.  */
#define YYPACT_NINF -54
static const yytype_int16 yypact[] =
{
     -53,   107,     6,   -54,   -54,   -54,   -54,   -54,   -54,   -54,
     -54,   -49,   -46,   -30,   -26,   -54,    24,   -15,    44,   -13,
     -54,   -54,   -54,   -54,   -54,   -54,   -54,   -54,   -54,   -54,
     -54,   -54,   -54,   -54,    41,    24,    24,    24,     5,    24,
     -54,   -21,   -17,    -1,   -54,   -54,    45,    48,   -54,   -54,
     -54,     9,    54,   -16,    -8,    24,    24,    24,   -54,    10,
      13,    11,    15,    16,   -54,    24,   -54,    12,   -54,    72,
      28,   -54,   -54,   -54,   -54,   -54,   -54,   -54,   -54,   -54,
     -54,   -54,   -54,   -54,   -54,   -54,   -54,   -54,   -54,   -54,
     -54,    29,    36,    37,    35,    38,    24,    96,   -54,   -17,
      24,   118,    59,   122,    24,    24,    24,    24,   -54,   -54,
     -54,     5,     5,    74,    71,   -54,   -54,   -54,    -2,   -54,
      73,   -54,   -54,   -54,    29,    67,    69,    24,    24,   -54,
      70,    -2,   108,    75,    76,    54,   -16,    -8,   -54,   123,
     -54,    80,    81,    98,   -54,   -54,   -54,    68,    83,     5,
     -54,   -54,   -54,    -7,   -54,    78,    89,   -54,    91,   -54,
     146,   -54,    84,     5,   -54,   -54,     5,   -54,   -54,   -54,
     -54,    85,    86,    75,   -54,   -54,    83,   -54
};

/* YYPGOTO[NTERM-NUM].  */
static const yytype_int8 yypgoto[] =
{
     -54,   -54,   -18,   -54,   -54,   -54,   -54,   -12,   -54,    19,
     -54,   -54,   -36,   -54,    20,   -54,   -54,    50,   -54,    21,
     -54,   -54,    51,   -54,   -54,    14,   -54,   -54,   -54,    39,
     -54,   -54,   -54,   -54,   -54,   -54,    60,    95,   -54,    62,
     -54,   -54,   -54,    17,   -54,   -54,   -54,    33,   -54,    40,
     -54,   -54,   -54,   -54,   -54,   -54,   -54,    -9,   -54,    -4
};

/* YYTABLE[YYPACT[STATE-NUM]].  What to do in state STATE-NUM.  If
   positive, shift that token.  If negative, reduce the rule which
   number is the opposite.  If zero, do what YYDEFACT says.
   If YYTABLE_NINF, syntax error.  */
#define YYTABLE_NINF -91
static const yytype_int16 yytable[] =
{
      45,    61,   129,     1,    40,    46,    33,    11,     3,     4,
      35,     5,     6,    36,    47,     7,     8,     9,    10,    11,
      62,    12,    13,    59,    60,   -90,    14,    63,     4,    37,
       5,     6,    82,    83,     7,     8,     9,    10,    86,    87,
      38,    64,    44,    90,    91,    93,    65,     3,     4,    69,
       5,     6,    70,    40,     7,     8,     9,    10,    11,   163,
      12,    13,   -12,    67,    15,    14,    16,    71,   121,    96,
      94,   -12,    -4,    95,     5,     6,    98,   100,     7,     8,
       9,    10,    97,    15,   113,    16,    55,   103,    40,    72,
      73,   101,   107,   125,   126,   124,   109,    74,    75,   110,
      56,   111,    57,    15,   112,    16,    76,    77,    78,    79,
       3,     4,   114,     5,     6,   141,   142,     7,     8,     9,
      10,    11,   117,    12,    13,   118,   119,    15,    14,    16,
     128,   162,   127,   134,   139,    47,   140,   144,   153,   147,
     155,   156,   149,   157,   166,   171,   160,   167,   172,   168,
     169,   170,   174,   175,   150,   122,   151,   123,   152,   115,
      99,   159,   116,   138,    -4,   146,    15,   177,    16,   176,
     164,   145
};

static const yytype_uint8 yycheck[] =
{
      18,    37,     4,    56,    16,    18,     0,    14,     3,     4,
      59,     6,     7,    59,    27,    10,    11,    12,    13,    14,
      38,    16,    17,    35,    36,    27,    21,    39,     4,    59,
       6,     7,    48,    49,    10,    11,    12,    13,    46,    47,
      66,    62,    57,    55,    56,    57,    63,     3,     4,     4,
       6,     7,     4,    65,    10,    11,    12,    13,    14,    66,
      16,    17,    18,    64,    59,    21,    61,    58,   104,    58,
      60,    27,    67,    60,     6,     7,    60,    65,    10,    11,
      12,    13,    67,    59,    96,    61,    45,    59,   100,    35,
      36,    19,    63,   111,   112,   107,    60,    43,    44,    62,
      59,    66,    61,    59,    66,    61,    52,    53,    54,    55,
       3,     4,    16,     6,     7,   127,   128,    10,    11,    12,
      13,    14,     4,    16,    17,    66,     4,    59,    21,    61,
      59,   149,    58,    60,    67,    27,    67,    67,    15,    64,
      60,    60,    66,    45,    66,   163,    63,    58,   166,    58,
       4,    67,    67,    67,   135,   105,   136,   106,   137,    99,
      65,   147,   100,   124,    57,   132,    59,   176,    61,   173,
     153,   131
};

/* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
   symbol of state STATE-NUM.  */
static const yytype_uint8 yystos[] =
{
       0,    56,    69,     3,     4,     6,     7,    10,    11,    12,
      13,    14,    16,    17,    21,    59,    61,    70,    71,    73,
      75,    80,    85,    90,    91,    93,   101,   102,   108,   109,
     110,   111,   114,     0,    92,    59,    59,    59,    66,    94,
      75,   103,   105,   107,    57,    70,    18,    27,    74,   115,
     116,    72,    76,    81,    86,    45,    59,    61,    95,    75,
      75,    80,    70,    75,    62,    63,   104,    64,   106,     4,
       4,    58,    35,    36,    43,    44,    52,    53,    54,    55,
      77,    98,    48,    49,    82,    99,    46,    47,    87,   100,
      75,    75,    96,    75,    60,    60,    58,    67,    60,   105,
      65,    19,   122,    59,    78,    83,    88,    63,    97,    60,
      62,    66,    66,    75,    16,   104,   107,     4,    66,     4,
     123,    80,    85,    90,    75,    70,    70,    58,    59,     4,
     117,   118,   119,   124,    60,    79,    84,    89,    97,    67,
      67,    75,    75,   120,    67,   117,   115,    64,   127,    66,
      77,    82,    87,    15,   112,    60,    60,    45,   121,    93,
      63,   125,    70,    66,   111,   113,    66,    58,    58,     4,
      67,    70,    70,   126,    67,    67,   127,   125
};

#define yyerrok		(yyerrstatus = 0)
#define yyclearin	(yychar = YYEMPTY)
#define YYEMPTY		(-2)
#define YYEOF		0

#define YYACCEPT	goto yyacceptlab
#define YYABORT		goto yyabortlab
#define YYERROR		goto yyerrorlab


/* Like YYERROR except do call yyerror.  This remains here temporarily
   to ease the transition to the new meaning of YYERROR, for GCC.
   Once GCC version 2 has supplanted version 1, this can go.  */

#define YYFAIL		goto yyerrlab

#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)					\
do								\
  if (yychar == YYEMPTY && yylen == 1)				\
    {								\
      yychar = (Token);						\
      yylval = (Value);						\
      yytoken = YYTRANSLATE (yychar);				\
      YYPOPSTACK (1);						\
      goto yybackup;						\
    }								\
  else								\
    {								\
      yyerror (YY_("syntax error: cannot back up")); \
      YYERROR;							\
    }								\
while (YYID (0))


#define YYTERROR	1
#define YYERRCODE	256


/* YYLLOC_DEFAULT -- Set CURRENT to span from RHS[1] to RHS[N].
   If N is 0, then set CURRENT to the empty location which ends
   the previous symbol: RHS[0] (always defined).  */

#define YYRHSLOC(Rhs, K) ((Rhs)[K])
#ifndef YYLLOC_DEFAULT
# define YYLLOC_DEFAULT(Current, Rhs, N)				\
    do									\
      if (YYID (N))                                                    \
	{								\
	  (Current).first_line   = YYRHSLOC (Rhs, 1).first_line;	\
	  (Current).first_column = YYRHSLOC (Rhs, 1).first_column;	\
	  (Current).last_line    = YYRHSLOC (Rhs, N).last_line;		\
	  (Current).last_column  = YYRHSLOC (Rhs, N).last_column;	\
	}								\
      else								\
	{								\
	  (Current).first_line   = (Current).last_line   =		\
	    YYRHSLOC (Rhs, 0).last_line;				\
	  (Current).first_column = (Current).last_column =		\
	    YYRHSLOC (Rhs, 0).last_column;				\
	}								\
    while (YYID (0))
#endif


/* YY_LOCATION_PRINT -- Print the location on the stream.
   This macro was not mandated originally: define only if we know
   we won't break user code: when these are the locations we know.  */

#ifndef YY_LOCATION_PRINT
# if defined YYLTYPE_IS_TRIVIAL && YYLTYPE_IS_TRIVIAL
#  define YY_LOCATION_PRINT(File, Loc)			\
     fprintf (File, "%d.%d-%d.%d",			\
	      (Loc).first_line, (Loc).first_column,	\
	      (Loc).last_line,  (Loc).last_column)
# else
#  define YY_LOCATION_PRINT(File, Loc) ((void) 0)
# endif
#endif


/* YYLEX -- calling `yylex' with the right arguments.  */

#ifdef YYLEX_PARAM
# define YYLEX yylex (YYLEX_PARAM)
#else
# define YYLEX yylex ()
#endif

/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)			\
do {						\
  if (yydebug)					\
    YYFPRINTF Args;				\
} while (YYID (0))

# define YY_SYMBOL_PRINT(Title, Type, Value, Location)			  \
do {									  \
  if (yydebug)								  \
    {									  \
      YYFPRINTF (stderr, "%s ", Title);					  \
      yy_symbol_print (stderr,						  \
		  Type, Value); \
      YYFPRINTF (stderr, "\n");						  \
    }									  \
} while (YYID (0))


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

/*ARGSUSED*/
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_symbol_value_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
#else
static void
yy_symbol_value_print (yyoutput, yytype, yyvaluep)
    FILE *yyoutput;
    int yytype;
    YYSTYPE const * const yyvaluep;
#endif
{
  if (!yyvaluep)
    return;
# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyoutput, yytoknum[yytype], *yyvaluep);
# else
  YYUSE (yyoutput);
# endif
  switch (yytype)
    {
      default:
	break;
    }
}


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_symbol_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
#else
static void
yy_symbol_print (yyoutput, yytype, yyvaluep)
    FILE *yyoutput;
    int yytype;
    YYSTYPE const * const yyvaluep;
#endif
{
  if (yytype < YYNTOKENS)
    YYFPRINTF (yyoutput, "token %s (", yytname[yytype]);
  else
    YYFPRINTF (yyoutput, "nterm %s (", yytname[yytype]);

  yy_symbol_value_print (yyoutput, yytype, yyvaluep);
  YYFPRINTF (yyoutput, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_stack_print (yytype_int16 *bottom, yytype_int16 *top)
#else
static void
yy_stack_print (bottom, top)
    yytype_int16 *bottom;
    yytype_int16 *top;
#endif
{
  YYFPRINTF (stderr, "Stack now");
  for (; bottom <= top; ++bottom)
    YYFPRINTF (stderr, " %d", *bottom);
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)				\
do {								\
  if (yydebug)							\
    yy_stack_print ((Bottom), (Top));				\
} while (YYID (0))


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_reduce_print (YYSTYPE *yyvsp, int yyrule)
#else
static void
yy_reduce_print (yyvsp, yyrule)
    YYSTYPE *yyvsp;
    int yyrule;
#endif
{
  int yynrhs = yyr2[yyrule];
  int yyi;
  unsigned long int yylno = yyrline[yyrule];
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %lu):\n",
	     yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      fprintf (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr, yyrhs[yyprhs[yyrule] + yyi],
		       &(yyvsp[(yyi + 1) - (yynrhs)])
		       		       );
      fprintf (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)		\
do {					\
  if (yydebug)				\
    yy_reduce_print (yyvsp, Rule); \
} while (YYID (0))

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args)
# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef	YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif



#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined __GLIBC__ && defined _STRING_H
#   define yystrlen strlen
#  else
/* Return the length of YYSTR.  */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static YYSIZE_T
yystrlen (const char *yystr)
#else
static YYSIZE_T
yystrlen (yystr)
    const char *yystr;
#endif
{
  YYSIZE_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static char *
yystpcpy (char *yydest, const char *yysrc)
#else
static char *
yystpcpy (yydest, yysrc)
    char *yydest;
    const char *yysrc;
#endif
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

# ifndef yytnamerr
/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
   quotes and backslashes, so that it's suitable for yyerror.  The
   heuristic is that double-quoting is unnecessary unless the string
   contains an apostrophe, a comma, or backslash (other than
   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
   null, do not copy; instead, return the length of what the result
   would have been.  */
static YYSIZE_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYSIZE_T yyn = 0;
      char const *yyp = yystr;

      for (;;)
	switch (*++yyp)
	  {
	  case '\'':
	  case ',':
	    goto do_not_strip_quotes;

	  case '\\':
	    if (*++yyp != '\\')
	      goto do_not_strip_quotes;
	    /* Fall through.  */
	  default:
	    if (yyres)
	      yyres[yyn] = *yyp;
	    yyn++;
	    break;

	  case '"':
	    if (yyres)
	      yyres[yyn] = '\0';
	    return yyn;
	  }
    do_not_strip_quotes: ;
    }

  if (! yyres)
    return yystrlen (yystr);

  return yystpcpy (yyres, yystr) - yyres;
}
# endif

/* Copy into YYRESULT an error message about the unexpected token
   YYCHAR while in state YYSTATE.  Return the number of bytes copied,
   including the terminating null byte.  If YYRESULT is null, do not
   copy anything; just return the number of bytes that would be
   copied.  As a special case, return 0 if an ordinary "syntax error"
   message will do.  Return YYSIZE_MAXIMUM if overflow occurs during
   size calculation.  */
static YYSIZE_T
yysyntax_error (char *yyresult, int yystate, int yychar)
{
  int yyn = yypact[yystate];

  if (! (YYPACT_NINF < yyn && yyn <= YYLAST))
    return 0;
  else
    {
      int yytype = YYTRANSLATE (yychar);
      YYSIZE_T yysize0 = yytnamerr (0, yytname[yytype]);
      YYSIZE_T yysize = yysize0;
      YYSIZE_T yysize1;
      int yysize_overflow = 0;
      enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
      char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
      int yyx;

# if 0
      /* This is so xgettext sees the translatable formats that are
	 constructed on the fly.  */
      YY_("syntax error, unexpected %s");
      YY_("syntax error, unexpected %s, expecting %s");
      YY_("syntax error, unexpected %s, expecting %s or %s");
      YY_("syntax error, unexpected %s, expecting %s or %s or %s");
      YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s");
# endif
      char *yyfmt;
      char const *yyf;
      static char const yyunexpected[] = "syntax error, unexpected %s";
      static char const yyexpecting[] = ", expecting %s";
      static char const yyor[] = " or %s";
      char yyformat[sizeof yyunexpected
		    + sizeof yyexpecting - 1
		    + ((YYERROR_VERBOSE_ARGS_MAXIMUM - 2)
		       * (sizeof yyor - 1))];
      char const *yyprefix = yyexpecting;

      /* Start YYX at -YYN if negative to avoid negative indexes in
	 YYCHECK.  */
      int yyxbegin = yyn < 0 ? -yyn : 0;

      /* Stay within bounds of both yycheck and yytname.  */
      int yychecklim = YYLAST - yyn + 1;
      int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
      int yycount = 1;

      yyarg[0] = yytname[yytype];
      yyfmt = yystpcpy (yyformat, yyunexpected);

      for (yyx = yyxbegin; yyx < yyxend; ++yyx)
	if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR)
	  {
	    if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
	      {
		yycount = 1;
		yysize = yysize0;
		yyformat[sizeof yyunexpected - 1] = '\0';
		break;
	      }
	    yyarg[yycount++] = yytname[yyx];
	    yysize1 = yysize + yytnamerr (0, yytname[yyx]);
	    yysize_overflow |= (yysize1 < yysize);
	    yysize = yysize1;
	    yyfmt = yystpcpy (yyfmt, yyprefix);
	    yyprefix = yyor;
	  }

      yyf = YY_(yyformat);
      yysize1 = yysize + yystrlen (yyf);
      yysize_overflow |= (yysize1 < yysize);
      yysize = yysize1;

      if (yysize_overflow)
	return YYSIZE_MAXIMUM;

      if (yyresult)
	{
	  /* Avoid sprintf, as that infringes on the user's name space.
	     Don't have undefined behavior even if the translation
	     produced a string with the wrong number of "%s"s.  */
	  char *yyp = yyresult;
	  int yyi = 0;
	  while ((*yyp = *yyf) != '\0')
	    {
	      if (*yyp == '%' && yyf[1] == 's' && yyi < yycount)
		{
		  yyp += yytnamerr (yyp, yyarg[yyi++]);
		  yyf += 2;
		}
	      else
		{
		  yyp++;
		  yyf++;
		}
	    }
	}
      return yysize;
    }
}
#endif /* YYERROR_VERBOSE */


/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

/*ARGSUSED*/
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep)
#else
static void
yydestruct (yymsg, yytype, yyvaluep)
    const char *yymsg;
    int yytype;
    YYSTYPE *yyvaluep;
#endif
{
  YYUSE (yyvaluep);

  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

  switch (yytype)
    {

      default:
	break;
    }
}


/* Prevent warnings from -Wmissing-prototypes.  */

#ifdef YYPARSE_PARAM
#if defined __STDC__ || defined __cplusplus
int yyparse (void *YYPARSE_PARAM);
#else
int yyparse ();
#endif
#else /* ! YYPARSE_PARAM */
#if defined __STDC__ || defined __cplusplus
int yyparse (void);
#else
int yyparse ();
#endif
#endif /* ! YYPARSE_PARAM */



/* The look-ahead symbol.  */
int yychar;

/* The semantic value of the look-ahead symbol.  */
YYSTYPE yylval;

/* Number of syntax errors so far.  */
int yynerrs;



/*----------.
| yyparse.  |
`----------*/

#ifdef YYPARSE_PARAM
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
int
yyparse (void *YYPARSE_PARAM)
#else
int
yyparse (YYPARSE_PARAM)
    void *YYPARSE_PARAM;
#endif
#else /* ! YYPARSE_PARAM */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
int
yyparse (void)
#else
int
yyparse ()

#endif
#endif
{
  
  int yystate;
  int yyn;
  int yyresult;
  /* Number of tokens to shift before error messages enabled.  */
  int yyerrstatus;
  /* Look-ahead token as an internal (translated) token number.  */
  int yytoken = 0;
#if YYERROR_VERBOSE
  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYSIZE_T yymsg_alloc = sizeof yymsgbuf;
#endif

  /* Three stacks and their tools:
     `yyss': related to states,
     `yyvs': related to semantic values,
     `yyls': related to locations.

     Refer to the stacks thru separate pointers, to allow yyoverflow
     to reallocate them elsewhere.  */

  /* The state stack.  */
  yytype_int16 yyssa[YYINITDEPTH];
  yytype_int16 *yyss = yyssa;
  yytype_int16 *yyssp;

  /* The semantic value stack.  */
  YYSTYPE yyvsa[YYINITDEPTH];
  YYSTYPE *yyvs = yyvsa;
  YYSTYPE *yyvsp;



#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  YYSIZE_T yystacksize = YYINITDEPTH;

  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;


  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY;		/* Cause a token to be read.  */

  /* Initialize stack pointers.
     Waste one element of value and location stack
     so that they stay on the same level as the state stack.
     The wasted elements are never initialized.  */

  yyssp = yyss;
  yyvsp = yyvs;

  goto yysetstate;

/*------------------------------------------------------------.
| yynewstate -- Push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
 yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;

 yysetstate:
  *yyssp = yystate;

  if (yyss + yystacksize - 1 <= yyssp)
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYSIZE_T yysize = yyssp - yyss + 1;

#ifdef yyoverflow
      {
	/* Give user a chance to reallocate the stack.  Use copies of
	   these so that the &'s don't force the real ones into
	   memory.  */
	YYSTYPE *yyvs1 = yyvs;
	yytype_int16 *yyss1 = yyss;


	/* Each stack pointer address is followed by the size of the
	   data in use in that stack, in bytes.  This used to be a
	   conditional around just the two extra args, but that might
	   be undefined if yyoverflow is a macro.  */
	yyoverflow (YY_("memory exhausted"),
		    &yyss1, yysize * sizeof (*yyssp),
		    &yyvs1, yysize * sizeof (*yyvsp),

		    &yystacksize);

	yyss = yyss1;
	yyvs = yyvs1;
      }
#else /* no yyoverflow */
# ifndef YYSTACK_RELOCATE
      goto yyexhaustedlab;
# else
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
	goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
	yystacksize = YYMAXDEPTH;

      {
	yytype_int16 *yyss1 = yyss;
	union yyalloc *yyptr =
	  (union yyalloc *) YYSTACK_ALLOC (YYSTACK_BYTES (yystacksize));
	if (! yyptr)
	  goto yyexhaustedlab;
	YYSTACK_RELOCATE (yyss);
	YYSTACK_RELOCATE (yyvs);

#  undef YYSTACK_RELOCATE
	if (yyss1 != yyssa)
	  YYSTACK_FREE (yyss1);
      }
# endif
#endif /* no yyoverflow */

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;


      YYDPRINTF ((stderr, "Stack size increased to %lu\n",
		  (unsigned long int) yystacksize));

      if (yyss + yystacksize - 1 <= yyssp)
	YYABORT;
    }

  YYDPRINTF ((stderr, "Entering state %d\n", yystate));

  goto yybackup;

/*-----------.
| yybackup.  |
`-----------*/
yybackup:

  /* Do appropriate processing given the current state.  Read a
     look-ahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to look-ahead token.  */
  yyn = yypact[yystate];
  if (yyn == YYPACT_NINF)
    goto yydefault;

  /* Not known => get a look-ahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid look-ahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = YYLEX;
    }

  if (yychar <= YYEOF)
    {
      yychar = yytoken = YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yyn == 0 || yyn == YYTABLE_NINF)
	goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  if (yyn == YYFINAL)
    YYACCEPT;

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the look-ahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);

  /* Discard the shifted token unless it is eof.  */
  if (yychar != YYEOF)
    yychar = YYEMPTY;

  yystate = yyn;
  *++yyvsp = yylval;

  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- Do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     `$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
        case 5:
#line 130 "src/syntax-phast.y"
    {/* SEGUN YO DEBERIAMOS REVISAR: */;}
    break;

  case 12:
#line 136 "src/syntax-phast.y"
    { aumenta_scope(); ;}
    break;

  case 13:
#line 136 "src/syntax-phast.y"
    { disminuye_scope(); ;}
    break;

  case 16:
#line 139 "src/syntax-phast.y"
    {fun3(yytext,2);;}
    break;

  case 18:
#line 140 "src/syntax-phast.y"
    {fun2(yytext); /*printf("OPERACION BOLEANA\n");*/;}
    break;

  case 19:
#line 140 "src/syntax-phast.y"
    {fun3(yytext,2); ;}
    break;

  case 22:
#line 142 "src/syntax-phast.y"
    {fun3(yytext,1);;}
    break;

  case 24:
#line 143 "src/syntax-phast.y"
    {fun2(yytext); ;}
    break;

  case 25:
#line 143 "src/syntax-phast.y"
    {fun3(yytext,1); ;}
    break;

  case 28:
#line 145 "src/syntax-phast.y"
    {fun3(yytext,0);;}
    break;

  case 30:
#line 146 "src/syntax-phast.y"
    {fun2(yytext); ;}
    break;

  case 31:
#line 146 "src/syntax-phast.y"
    {fun3(yytext,0); ;}
    break;

  case 35:
#line 149 "src/syntax-phast.y"
    {fun1(yytext); valor_actual = strdup(yytext); /*printf("valor: %s \n",yytext);*/;}
    break;

  case 36:
#line 150 "src/syntax-phast.y"
    { fun1(yytext);llame_var(yytext);;}
    break;

  case 44:
#line 159 "src/syntax-phast.y"
    {fun4(yytext);;}
    break;

  case 45:
#line 159 "src/syntax-phast.y"
    {fun5(yytext);;}
    break;

  case 48:
#line 165 "src/syntax-phast.y"
    { /*printf("Asignamos tipo %d y valor: %s a:\n",tipo_actual,valor_actual,var_actual);*//*guarda_var();*/;}
    break;

  case 66:
#line 186 "src/syntax-phast.y"
    { tipo_actual = ENTERO; /*printf("tipo actual es %d\n",tipo_actual);*/ ;}
    break;

  case 67:
#line 187 "src/syntax-phast.y"
    { tipo_actual = FLOTANTE; /*printf("tipo actual es %d\n",tipo_actual);*/ ;}
    break;

  case 90:
#line 212 "src/syntax-phast.y"
    { aumenta_scope(); ;}
    break;

  case 91:
#line 212 "src/syntax-phast.y"
    { disminuye_scope(); ;}
    break;

  case 92:
#line 213 "src/syntax-phast.y"
    { llame_var(yytext);;}
    break;

  case 94:
#line 214 "src/syntax-phast.y"
    { printf("Aqui esta mal\n");;}
    break;

  case 98:
#line 219 "src/syntax-phast.y"
    { llame_var(yytext);;}
    break;

  case 101:
#line 221 "src/syntax-phast.y"
    { llame_var(yytext);;}
    break;


/* Line 1267 of yacc.c.  */
#line 1757 "bison/src/bison.c"
      default: break;
    }
  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;


  /* Now `shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */

  yyn = yyr1[yyn];

  yystate = yypgoto[yyn - YYNTOKENS] + *yyssp;
  if (0 <= yystate && yystate <= YYLAST && yycheck[yystate] == *yyssp)
    yystate = yytable[yystate];
  else
    yystate = yydefgoto[yyn - YYNTOKENS];

  goto yynewstate;


/*------------------------------------.
| yyerrlab -- here on detecting error |
`------------------------------------*/
yyerrlab:
  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if ! YYERROR_VERBOSE
      yyerror (YY_("syntax error"));
#else
      {
	YYSIZE_T yysize = yysyntax_error (0, yystate, yychar);
	if (yymsg_alloc < yysize && yymsg_alloc < YYSTACK_ALLOC_MAXIMUM)
	  {
	    YYSIZE_T yyalloc = 2 * yysize;
	    if (! (yysize <= yyalloc && yyalloc <= YYSTACK_ALLOC_MAXIMUM))
	      yyalloc = YYSTACK_ALLOC_MAXIMUM;
	    if (yymsg != yymsgbuf)
	      YYSTACK_FREE (yymsg);
	    yymsg = (char *) YYSTACK_ALLOC (yyalloc);
	    if (yymsg)
	      yymsg_alloc = yyalloc;
	    else
	      {
		yymsg = yymsgbuf;
		yymsg_alloc = sizeof yymsgbuf;
	      }
	  }

	if (0 < yysize && yysize <= yymsg_alloc)
	  {
	    (void) yysyntax_error (yymsg, yystate, yychar);
	    yyerror (yymsg);
	  }
	else
	  {
	    yyerror (YY_("syntax error"));
	    if (yysize != 0)
	      goto yyexhaustedlab;
	  }
      }
#endif
    }



  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse look-ahead token after an
	 error, discard it.  */

      if (yychar <= YYEOF)
	{
	  /* Return failure if at end of input.  */
	  if (yychar == YYEOF)
	    YYABORT;
	}
      else
	{
	  yydestruct ("Error: discarding",
		      yytoken, &yylval);
	  yychar = YYEMPTY;
	}
    }

  /* Else will try to reuse look-ahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:

  /* Pacify compilers like GCC when the user code never invokes
     YYERROR and the label yyerrorlab therefore never appears in user
     code.  */
  if (/*CONSTCOND*/ 0)
     goto yyerrorlab;

  /* Do not reclaim the symbols of the rule which action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;	/* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (yyn != YYPACT_NINF)
	{
	  yyn += YYTERROR;
	  if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
	    {
	      yyn = yytable[yyn];
	      if (0 < yyn)
		break;
	    }
	}

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
	YYABORT;


      yydestruct ("Error: popping",
		  yystos[yystate], yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  if (yyn == YYFINAL)
    YYACCEPT;

  *++yyvsp = yylval;


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;

/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;

#ifndef yyoverflow
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  /* Fall through.  */
#endif

yyreturn:
  if (yychar != YYEOF && yychar != YYEMPTY)
     yydestruct ("Cleanup: discarding lookahead",
		 yytoken, &yylval);
  /* Do not reclaim the symbols of the rule which action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
		  yystos[*yyssp], yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
#if YYERROR_VERBOSE
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
#endif
  /* Make sure YYID is used.  */
  return YYID (yyresult);
}


#line 225 "src/syntax-phast.y"


TIPO_DATO cubo_sem_logico(TIPO_DATO nuevo){
    if(tipo_actual < nuevo){
        tipo_actual = nuevo;
    }
    return tipo_actual;
}

TIPO_DATO cubo_sem_aritmetico(TIPO_DATO nuevo){
    if(tipo_actual < nuevo){
        tipo_actual = nuevo;
    }
    return tipo_actual;
}

int fun1(char* y) {
    printf("Meter %s y su tipo a PilaO\n", y);
    char* operando = strdup(y);
    ch_push(operando,&pila_operandos);
return 1;
}

int fun2(char* y) {
    char* operador;
    printf("Meter %s a Poper\n", y);
    operador = strdup(y);
    ch_push(operador,&pila_operadores);
return 1;
}

int fun3(char* y,int nivel){
    Node* h1; 
    char* op = (char*)ch_peek(pila_operadores);
    char* op1;
    printf("Checar el top de Poper tiene operador pendiente = '%s' <<\n", op);
    switch(nivel){
        case 0: //basico
            if(*op == '*' || *op == '/')
            {
                printf("Hago lo de adentro (MULTIPLICACION / DIVISION)\n");
                printf("En cabeza O: %s\n",(char*)ch_peek(pila_operandos));
                h1 = pila_operandos;
                op1 = (char *)ch_peek(pila_operandos->next);
                printf("En cabeza 1: %s\n",op1);
                
            }
            break;
        case 1: //basico
            if(*op == '+' || *op == '-')
            {
                printf("Hago lo de adentro (SUMA / RESTA)\n");
            }
            break;
        case 2: //basico
            if(*op == '=' || *op == '>' || *op == '<' || *op == '!' || *op == 'a' || *op == 'A' || *op == 'o' || *op == 'O')
            {
                printf("Hago lo de adentro (COMPARACION)\n");
            }
            break;
    }
            
return 1;
}

int fun4(char* y){
    printf("Poner fondo >> yytext = '%s' <<\n", y);
return 1;
}

int fun5(char* y){
    printf("Quitar fondo >> yytext='%s' <<\n", y);
return 1;
}

char* tipo_dato_to_string(TIPO_DATO entrada){
    switch(entrada){
        case BOLEANO: return "bool";
        case ENTERO: return "int";
        case FLOTANTE: return "float";
        case CADENA: return "string";
        case NULO:
        default:
                 return NULL;
    }
    return NULL;
}


int aumenta_scope()
{
    hashmap* tabla_variables_actual = newHashmap(100);
    push(tabla_variables_actual,&scopes);
    /*printf("--->>Aumentando scope ahora es: %p\n",scopes);*/
}

int disminuye_scope()
{
    /*printf("PILA\n");*/
    /*print(scopes);*/
    pop(&scopes);
    /*printf("<<---Disminuyendo scope ahora es: %p\n",scopes);*/
}

int guarda_var(char* variable,TIPO_DATO tipo_dato, char* valor)
{
    /*printf("-Guardando %s\n",variable);*/
    quad* data = (quad*)malloc(sizeof(quad));
    char* tipo = tipo_dato_to_string(tipo_dato);
    data->a = tipo == NULL ? NULL : strdup(tipo);
    data->b = valor == NULL ? NULL : strdup(valor);
    data->c = NULL;
    data->d = NULL;
    return hashmapSet(peek(scopes), data, variable);
}

int llame_var(char* variable)
{
    var_actual = strdup(variable);
    quad* result;
    /*printf("-Quise usar: %s en el scope %p\n",variable,scopes);*/
    result = hashmapGet(peek(scopes), variable);
    if(result == NULL){
        guarda_var(variable,NULO,NULL);
    }
    /*else*/
        /*printf("-Usaremos %s previamente definida\n",variable);*/
}

int yyerror(char* s) 
{
    extern int yylineno;	// defined and maintained in lex.c
    extern char *yytext;	// defined and maintained in lex.c

    printf("ERROR: %s at symbol \"%s\" on line %d\n",s,yytext,yylineno);
    return 1;
}

static void iter(const char *key, void *tmp)
{
    quad* obj = (quad*)tmp;
    printf("key: %s values: {%s,%s,%s,%s}\n", key, obj->a,obj->b,obj->c,obj->d);
}

static void elements_clean(const char *key,void *tmp)
{
    free(tmp);
}



/* MAIN */
int main(int argc, char *argv[])
{
    scopes = NULL;

    global = newHashmap(100);
    push(global, &scopes);
    
    char* eostack = strdup("$");   

    ch_push(eostack,&pila_operandos);
    ch_push(eostack,&pila_operadores);

    
    extern int yylineno;	// defined and maintained in lex.c
    yylineno = 0;
	if (argc > 1)
	{
		FILE *fp = fopen(argv[1], "r");
		if (fp == NULL)
		{
			printf("Error reading from %s\n", argv[1]);
			return -1;
		}
		yyin = fp;

	} else {
		printf(">> ");
	}
	int a = yyparse();
    
    /*printf("varibles globales:\n");*/
    /*hashmapProcess(global,iter);*/

	
    if(a == 0 )
		printf("PROGRAMA SINTÁCTICAMENTE CORRECTO.\nLOC: %d\n",yylineno);

    deleteHashmap(global);
    hashmapProcess(global,elements_clean);
    ch_clean(pila_operadores);
    ch_clean(pila_operandos);
}


