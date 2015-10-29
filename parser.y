%{
  #include <stdio.h>
  #include <string.h>
  #define YYERROR_VERBOSE 1
  extern FILE* yyin;
  extern int yyparse(void);
  extern void yyerror(char const*);
  extern int yylex(void);

  char str_requirements[80];
  char str_types[80];
%}

%union {
  int ival;
  float fval;
  char *sval;
}



%token tLPAREN tRPAREN
%token kREQUIREMENTS kTYPING kSTRIPS kTYPES kPREDICATES
%token <sval> kDEFINE kDOMAIN kPROBLEM tSTRING

%type <sval> domain_name

%start start

%%

start: tLPAREN kDEFINE tLPAREN kDOMAIN domain_name tRPAREN domain_definitions domain_types domain_predicates tRPAREN {printf("Domain: %s\n", $5);}
  ;

domain_name: tSTRING {$$ = $1;}
  ;

domain_definitions: tLPAREN definition tRPAREN {printf("Requirements: %s\n", str_requirements);}

definition:  kREQUIREMENTS definition
  |  kTYPING  definition {strcat(str_requirements, "Types ");}
  |  kSTRIPS  definition {strcat(str_requirements, "Strips ");}
  |
  ;

domain_types: tLPAREN types tRPAREN {printf("Types: %s\n", str_types);}

types:  kTYPES types
  | tSTRING types {strcat(str_types, $1);}
  |
  ;

domain_predicates: tLPAREN kPREDICATES predicates tRPAREN

predicates: predicate
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
