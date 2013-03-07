%{
#include "../../src/heading.h"
#include "../../bison/src/bison.h"
/*

//.*[^\n] { return COMMENT; }
#.*[^\n] { return COMMENT; }
*/
%}
%option noyywrap
%%

[ \t]*  //Omitir tabs y espacios
[\n]  { yylineno++; }

\<\? { return PH_OT; }
\?\> { return PH_CT; }

"//".*\n { yylineno++; /* Comete los comentarios */ }

[0-9]+ { yylval.int_val = atoi(yytext); return INT; }
[0-9]+\.[0-9]+ { yylval.float_val = atof(yytext); return FLOAT; }
if { return WORD_IF; }
else { return WORD_ELSE; }
while { return WORD_WHILE; }
for { return WORD_FOR; }
class { return WORD_CLASS; }
do { return WORD_DO; }
switch { return WORD_SWITCH; }
case { return WORD_CASE; }
break { return WORD_BREAK; }
default { return WORD_DEFAULT; }
continue { return WORD_CONTINUE; }
fun { return WORD_FUN; }
return { return WORD_RETURN; }
verbose { return WORD_VERBOSE; }
static { return WORD_STATIC; }
abstract { return WORD_ABSTRACT; }
public { return WORD_PUBLIC; }
private { return WORD_PRIVATE; }
protected { return WORD_PROTECTED; }
new { return WORD_NEW; }
and { return WORD_AND; }
or { return WORD_OR; }
not { return WORD_NOT; }
xor { return WORD_XOR; }
try { return WORD_TRY; }
catch { return WORD_CATCH; }
throw { return WORD_THROW; }
[a-zA-Z_][_|a-zA-Z|0-9]* { return ID; }
['\"].*[\"'] { return STRING; }
[=\+\-\*/><;:,\{\}\(\)\.\[\]]	{ return yytext[0];  /*TODO Operadores */ } 
. { return VERBOSE_BLOCK;  /* printf("Unknown or invalid token: %s\n",yytext); TODO */  }
%%

