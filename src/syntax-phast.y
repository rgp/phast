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

%token <string*> ID 
%token <int> INT 
%token <float> FLOAT 
%token <string*> STRING 
%token <string*> COMENTARIO 
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
%token <string*> WORD_VERBOSE 
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
%token <string*> WORD_CLASS 

%token <string*> PH_OT 
%token <string*> PH_CT

/* TODO Operators 
%left '-' '+'
%left '*' '/'
*/
%%

phast : PHOT estatuto PH_CT
estatuto : definicion_varible | definicion_arreglo | bloque | estatuto
estatuto : 
definicion_variable : ID "=" expresion ";"
definicion_arreglo : ID "=" "[" expresion (("," expresion)*)? "]" ";"
expresion : TRUE | FALSE | ID | STRING | operacion | arreglo | cte
operacion : expresion "+" expresion | expresion "-" expresion | expresion "*" expresion | expresion "/" expresion | expresion AND expresion | expresion OR expresion | expresion  "++" | expresion "--"
bloque : bloque_while | bloque_do | bloque_verbose | bloque_if | bloque_for | bloque_fun
bloque_while : "while" "(" expresion ")" "{" estatuto "}"
bloque_do : "do" "{" estatuto "}" "while" "(" expresion ")" ";" 
bloque_verbose : "verbose" "{" (.)* "}"
bloque_if : "if"  "(" expresion ")" "{" estatuto "}"
bloque_for : "for" "("definicion_variables? ";" expresion ";" operacion ")" "{" estatuto "}"
bloque_fun : "fun" ID "(" ID (("," ID)*)? ")" "{" estatuto "}"
arreglo: ID "[" expresion "]" ";"
cte : INT | FLOAT

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
		printf("Sexy program!\n");
}

