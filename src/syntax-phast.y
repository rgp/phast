%{
#include "../../src/heading.h"

#include "../../src/lib/strmap.h"
#include "../../src/lib/hashmap.h"
#include "../../src/lib/nuestra_pila.h"
int yyerror(char *s);
int yylex(void);

/* FROM LEX */
extern FILE *yyin;
extern char *yytext;
/* END FROM LEX */

Scope *scopes;
hashmap* global;

%}
%union{
  int int_val;
  float float_val;
  char*	op_val;
}

%start	phast 

%token <string*> VERBOSE_BLOCK 

%token <string*> ID 
%token <string*> FUNCID 
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
%token <string*> WORD_EXTENDS 
%token <string*> WORD_IMPLEMENTS
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

%left OP_MULTIPLY OP_DIVIDE
%left OP_PLUS OP_MINUS
%%

phast :  PH_OT estatutos PH_CT
estatutos: estatuto estatutos
         |
estatuto : expresion ';'
         | bloque_while
         | bloque_do 
         | bloque_verbose
         | bloque_if
         | bloque_for
         | { aumenta_scope(); } bloques_declarativos { disminuye_scope(); }
bloques_declarativos: bloque_fun
                    | bloque_class
expresion: comparando comparando_aux
comparando_aux: op_comp comparando
           |
comparando: termino termino_aux
termino_aux: op_term termino
           | 
termino: factor factor_aux
factor_aux: op_fact factor
          | 
factor: llamada
      | estatico
llamada: ID { llame_var(yytext);} id_call
estatico: numero
        | STRING
        | arreglo
        | OP_INCREMENT ID { llame_var(yytext);}
        | OP_DECREMENT ID { llame_var(yytext);}
        | WORD_TRUE
        | WORD_FALSE

id_call: '(' expresion ')'
        | '[' expresion ']'
        | OP_INCREMENT
        | OP_DECREMENT
        | OP_ASIGN expresion
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

numero : INT 
       | FLOAT
arreglo: '[' _arr_elems ']'
_arr_elems: _arr_elem _arr_elems_aux
          |
_arr_elems_aux: ',' _arr_elem _arr_elems_aux
          |
_arr_elem: _arr_val _arr_elem_aux
_arr_elem_aux: '=' '>' _arr_val
             |
_arr_val: expresion

bloque_while : WORD_WHILE '(' expresion ')' '{' estatutos '}'
bloque_do : WORD_DO '{' estatutos '}' WORD_WHILE '(' expresion ')' ';' 
bloque_verbose : VERBOSE_BLOCK
bloque_if : WORD_IF  '(' expresion ')' '{' estatutos '}' _else
_else: WORD_ELSE _aux_else
     |
_aux_else: bloque_if
       | '{' estatutos '}'
bloque_for : WORD_FOR '('comparando ';' expresion ';' expresion ')' '{' estatutos '}'
bloque_fun : WORD_FUN ID '(' _params ')' '{' estatutos '}'

bloque_class: WORD_CLASS ID _class_extras '{' _class_body '}'
_class_body: _class_body_aux  _class_body
           |
_class_body_aux: { aumenta_scope(); } bloque_fun { disminuye_scope(); }
           | ID { llame_var(yytext);} _class_def_var_aux ';'
_class_def_var_aux: OP_ASIGN
                  |
_class_extras: WORD_EXTENDS ID
             |

_params: ID { llame_var(yytext);} _def_param _params_aux
       |
_params_aux: ',' ID { llame_var(yytext);} _def_param _params_aux
           |
_def_param: '=' estatico
          |
%%

/*
int int + int
float float + float
int float + float
string string + string
string int + string
int string + string
*/


int aumenta_scope()
{
    hashmap* tabla_variables_actual = newHashmap(100);
    push(tabla_variables_actual,&scopes);
    printf("--->>Aumentando scope ahora es: %p\n",scopes);
}

int disminuye_scope()
{
    printf("PILA\n");
    print(scopes);
    pop(&scopes);
    printf("<<---Disminuyendo scope ahora es: %p\n",scopes);
}

int guarda_var(char* variable)
{
    printf("-Guardando %s\n",variable);
    triad data = {"nada", "nada2", "nada3"};
    return hashmapSet(peek(scopes), &data, variable);
}

int llame_var(char* variable)
{
    triad* result;
    char* tipo;
    tipo = "tipo";
    printf("-Quise usar: %s en el scope %p\n",variable,scopes);
    result = hashmapGet(peek(scopes), variable);
    if(result == NULL){
        guarda_var(variable);
    }
    else
        printf("-Usaremos %s previamente definida\n",variable);
}

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
    scopes = NULL;

    global = newHashmap(100);
    push(global, &scopes);
    
    
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
    
    printf("varibles globales:\n");
    //sm_enum(global, iter, NULL);
	
    if(a == 0 )
		printf("PROGRAMA SINTÁCTICAMENTE CORRECTO.\nLOC: %d\n",yylineno);

    deleteHashmap(global);
}

