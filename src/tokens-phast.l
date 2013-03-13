%{
#include "../../src/heading.h"
#include "../../bison/src/bison.h"
/*

//.*[^\n] { return COMMENT; }
#.*[^\n] { return COMMENT; }
*/

%}
%option noyywrap
%s comment
%s verbose
%%


\<\? { return PH_OT; }
\?\> { return PH_CT; }

"/*"         BEGIN(comment);
<comment>[^*\n]*        /* eat anything that's not a '*' */
<comment>"*"+[^*/\n]*   /* eat up '*'s not followed by '/'s */
<comment>\n             ++yylineno;
<comment>"*"+"/"        BEGIN(INITIAL);

verbose[ ]*\{  { BEGIN(verbose);  }
<verbose>\n       { ++yylineno; }
<verbose>\}       { BEGIN(INITIAL); return VERBOSE_BLOCK; }
<verbose>[^\}^\n]*      

"//".*\n { yylineno++; /* Comete los comentarios */ }

[0-9]+ { yylval.int_val = atoi(yytext); return INT; }
[0-9]+\.[0-9]+ { yylval.float_val = atof(yytext); return FLOAT; }
int { return WORD_INT; }
float { return WORD_FLOAT; }
if { return WORD_IF; }
else { return WORD_ELSE; }
while { return WORD_WHILE; }
for { return WORD_FOR; }
class { return WORD_CLASS; }
extends { return WORD_EXTENDS; }
implements { return WORD_IMPLEMENTS; }
do { return WORD_DO; }
switch { return WORD_SWITCH; }
case { return WORD_CASE; }
break { return WORD_BREAK; }
default { return WORD_DEFAULT; }
continue { return WORD_CONTINUE; }
fun { return WORD_FUN; }
return { return WORD_RETURN; }
static { return WORD_STATIC; }
abstract { return WORD_ABSTRACT; }
public { return WORD_PUBLIC; }
private { return WORD_PRIVATE; }
protected { return WORD_PROTECTED; }
true|TRUE { return WORD_TRUE; }
false|FALSE { return WORD_FALSE; }
new { return WORD_NEW; }
and { return WORD_AND; }
or { return WORD_OR; }
not { return WORD_NOT; }
xor { return WORD_XOR; }
try { return WORD_TRY; }
catch { return WORD_CATCH; }
throw { return WORD_THROW; }
[a-zA-Z_][_a-zA-Z0-9]* { return ID; }
['\"].*[\"'] { return STRING; }
=== { return OP_IDENTICAL; }
== { return OP_EQUAL; }
!= { return OP_NOT_EQUAL; }
= { return OP_ASIGN; }
\+ { return OP_PLUS; }
\- { return OP_MINUS; }
\* { return OP_MULTIPLY; }
"/" { return OP_DIVIDE; }
\+\+ { return OP_INCREMENT; }
\-\- { return OP_DECREMENT; }
"<=" { return OP_LESS_EQUAL; }
"<" { return OP_LESS; }
">=" { return OP_GREATER_EQUAL; }
">" { return OP_GREATER; }

[;:,\{\}\(\)\.\[\]]	{ return yytext[0];  /*TODO Operadores */ } 

[ \t]*  //Omitir tabs y espacios
[\n]  { yylineno++; }

. { return VERBOSE_BLOCK;  /* printf("Unknown or invalid token: %s\n",yytext); TODO */  }
%%

