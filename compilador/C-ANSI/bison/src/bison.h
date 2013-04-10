/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton interface for Bison's Yacc-like parsers in C

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




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
#line 55 "src/syntax-phast.y"
{
  int int_val;
  float float_val;
  char*	op_val;
}
/* Line 1529 of yacc.c.  */
#line 169 "bison/src/bison.h"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

