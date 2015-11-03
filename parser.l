%{
  #include <iostream>
  #include <cctype>
  // Bring the standard library into the
  // global namespace
  using namespace std;
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
QUESTION_TAG \?
VARIABLE {QUESTION_TAG}+(-|{CHAR}|{DIGIT})*

%%
domain { KEYWORD(DOMAIN);}
define { KEYWORD(DEFINE);}
problem { KEYWORD(PROBLEM);}
:requirements { KEYWORD(REQUIREMENTS);}
:strips { KEYWORD(STRIPS);}
:typing { KEYWORD(TYPING);}
:types { KEYWORD(TYPES);}
:predicates { KEYWORD(PREDICATES);}
:constants { KEYWORD(CONSTANTS);}
:parameters { KEYWORD(PARAMETERS);}
:action { KEYWORD(ACTION);}
:precondition { KEYWORD(PRECONDITION);}
:effect { KEYWORD(EFFECT);}
:observe {KEYWORD(OBSERVE);}
and {KEYWORD(AND);}
not {KEYWORD(NOT);}
#.*$ {}
\(  { TOKEN(LPAREN); }
\)  { TOKEN(RPAREN); }
[\t ] {}
\n {}
\- {TOKEN(HYPHEN);}
{VARIABLE} {yylval.sval = strdup(yytext); TOKEN(VARIABLE);}
{STRING}   { yylval.sval = strdup(yytext); TOKEN(STRING); }

. { fprintf(stderr, "Unknown token '%s'\n", yytext); }
%%

void yyerror(char const *s) {
  // fprintf(stderr,
  //         "%s. Unexpected \"%s\" on line %d\n",
  //         s,
  //         yytext,
  //         yylineno);
  cout << s << endl;
}
