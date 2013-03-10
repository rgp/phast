%{
#include "../../src/heading.h"
int yyerror(char *s);
int yylex(void);

/* FROM LEX */
extern FILE *yyin;
extern char *yytext;
/* END FROM LEX */

%}
%union{
  int int_val;
  float float_val;
  char*	op_val;
}

%start	phast 

%token <string*> VERBOSE_BLOCK 

%token <string*> ID 
%token <int> INT 
%token <float> FLOAT
%token <string*> WORD_INT
%token <string*> WORD_FLOAT
%token <string*> STRING 
%token <string*> WORD_FALSE 
%token <string*> WORD_TRUE
%token <string*> WORD_IF 
%token <string*> WORD_ELSE 
%token <string*> WORD_WHILE 
%token <string*> WORD_FOR 
%token <string*> WORD_CLASS 
%token <string*> WORD_DO 
%token <string*> WORD_SWITCH 
%token <string*> WORD_CASE 
%token <string*> WORD_BREAK 
%token <string*> WORD_DEFAULT 
%token <string*> WORD_CONTINUE 
%token <string*> WORD_FUN 
%token <string*> WORD_RETURN 
%token <string*> WORD_STATIC 
%token <string*> WORD_ABSTRACT 
%token <string*> WORD_PUBLIC 
%token <string*> WORD_PRIVATE 
%token <string*> WORD_PROTECTED 
%token <string*> WORD_NEW 
%token <string*> WORD_AND 
%token <string*> WORD_OR 
%token <string*> WORD_NOT 
%token <string*> WORD_XOR 
%token <string*> WORD_TRY 
%token <string*> WORD_CATCH 
%token <string*> WORD_THROW 
%token <string*> OP_IDENTICAL
%token <string*> OP_EQUAL
%token <string*> OP_NOT_EQUAL
%token <string*> OP_ASIGN
%token <string*> OP_MULTIPLY
%token <string*> OP_DIVIDE
%token <string*> OP_PLUS
%token <string*> OP_MINUS
%token <string*> OP_INCREMENT
%token <string*> OP_DECREMENT
%token <string*> OP_GREATER
%token <string*> OP_GREATER_EQUAL
%token <string*> OP_LESS
%token <string*> OP_LESS_EQUAL

%token <string*> PH_OT 
%token <string*> PH_CT

%error-verbose

/* TODO Operators 
%left '-' '+'
%left '*' '/'
*/
%%

phast :  PH_OT estatutos PH_CT
estatutos: estatuto estatutos
         |
estatuto : operacion ';'
         | asignacion ';'
         | _fun_call ';'
         | bloque_while
         | bloque_do 
         | bloque_verbose
         | bloque_if
         | bloque_for
         | bloque_fun
/* */
expresion: expresion_izq | expresion_der
expresion_izq: ID
expresion_der : WORD_TRUE
              | WORD_FALSE
              | STRING
              | operacion
              | numero
              | _fun_call
numero : INT 
       | FLOAT
operacion : expresion_izq _id_only_ops
          | expresion_der _all_ops expresion
_all_ops: OP_PLUS 
        | OP_MINUS 
        | OP_MULTIPLY  
        | OP_DIVIDE  
        | OP_EQUAL  
        | OP_NOT_EQUAL  
        | OP_GREATER  
        | OP_GREATER_EQUAL
        | OP_LESS  
        | OP_LESS_EQUAL
        | WORD_AND  
        | WORD_OR 
_id_only_ops: OP_INCREMENT
            | OP_DECREMENT
            | _all_ops expresion
/* */
asignacion: expresion_izq OP_ASIGN expresion
bloque_while : WORD_WHILE '(' expresion ')' '{' estatutos '}'
bloque_do : WORD_DO '{' estatutos '}' WORD_WHILE '(' expresion ')' ';' 
bloque_verbose : VERBOSE_BLOCK
bloque_if : WORD_IF  '(' expresion ')' '{' estatutos '}' _else
_else: WORD_ELSE _aux_else
     |
_aux_else: bloque_if
       | '{' estatutos '}'
bloque_for : WORD_FOR '('_for_var_def_aux ';' expresion ';' operacion ')' '{' estatutos '}'
_for_var_def_aux: asignacion
                |
bloque_fun : WORD_FUN ID '(' _params ')' '{' estatutos '}'
_fun_call: ID '('expresion ')' 
_params: ID _params_aux
       |
_params_aux: ',' ID _params_aux
           |
%%

int yyerror(char* s) 
{
    extern int yylineno;	// defined and maintained in lex.c
    extern char *yytext;	// defined and maintained in lex.c

    printf("ERROR: %s at symbol \"%s\" on line %d\n",s,yytext,yylineno);
    return 1;
}


/* MAIN */
int main(int argc, char *argv[])
{

    extern int yylineno;	// defined and maintained in lex.c
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
	if(a == 0 )
		printf("Sexy program! LOC: %d\n",yylineno);
}

