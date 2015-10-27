%{
  #include <stdio.h>
  #define YYERROR_VERBOSE 1
  extern FILE* yyin;
  extern int yyparse(void);
  extern void yyerror(char const*);
  extern int yylex(void);
%}

%union {
  int ival;
  float fval;
  char *sval;
}

%token tLPAREN tRPAREN
%token <sval> kDEFINE kDOMAIN kPROBLEM tSTRING

%type <sval> domain_name

%start start

%%

start: tLPAREN kDEFINE tLPAREN kDOMAIN domain_name tRPAREN tRPAREN {printf("Domain: %s\n", $5);}
  ;

domain_name: tSTRING {$$ = $1;}
  ;
%%

int main(int argc, char *argv[]) {
  if (argc > 1) {
    yyin = fopen(argv[1], "r");
  }
  printf("Started the parsing\n");
  yyparse();

  fclose(yyin);
  return 1;
}
