%{
  #include <stdio.h>
  #include <string.h>
  #include "parser.tab.h"
  #define TOKEN(id) return t##id
  #define KEYWORD(id) return k##id
  extern void yyerror(const char *s);
%}

%option noyywrap
%option yylineno

CHAR [a-zA-Z_]
DIGIT [0-9]
NUMBER [0-9](_[0-9]|[0-9])*
STRING {CHAR}+(-|{CHAR}|{DIGIT})*

%%
domain { KEYWORD(DOMAIN);}
define { KEYWORD(DEFINE);}
problem { KEYWORD(PROBLEM);}
:requirements { KEYWORD(REQUIREMENTS);}
:strips { KEYWORD(STRIPS);}
:typing { KEYWORD(TYPING);}
:types { KEYWORD(TYPES);}
:predicates { KEYWORD(PREDICATES);}
#.*$ {}
\(  { TOKEN(LPAREN); }
\)  { TOKEN(RPAREN); }
[\t ] {}
\n {}
\- {TOKEN(HYPHEN);}
{STRING}   { yylval.sval = strdup(yytext); TOKEN(STRING); }

. { fprintf(stderr, "Unknown token '%s'\n", yytext); }
%%

void yyerror(char const *s) {
  fprintf(stderr,
          "%s. Unexpected \"%s\" on line %d\n",
          s,
          yytext,
          yylineno);
}
