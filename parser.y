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
  char str_predicate[80];
%}

%union {
  int ival;
  float fval;
  char *sval;
}



%token tLPAREN tRPAREN tHYPHEN tVARIABLE
%token kREQUIREMENTS kTYPING kSTRIPS kTYPES kPREDICATES
%token <sval> kDEFINE kDOMAIN kPROBLEM tSTRING

%type <sval> domain_name

%start start

%%

start: tLPAREN kDEFINE tLPAREN kDOMAIN domain_name tRPAREN
  domain_definitions
  domain_types
  predicates_def
  tRPAREN {printf("Domain: %s\n", $5);}
  ;

domain_name: tSTRING {$$ = $1;}
  ;

domain_definitions: tLPAREN definition tRPAREN {printf("Parsed requirements: %s\n", str_requirements);}

definition:  kREQUIREMENTS definition
  |  kTYPING  definition {strcat(str_requirements, "types ");}
  |  kSTRIPS  definition {strcat(str_requirements, "strips ");}
  |
  ;

domain_types: tLPAREN types tRPAREN {printf("Parsed types: %s\n", str_types);}

types:  kTYPES types
  | tSTRING types {strcat(str_types, $1);}
  |
  ;

predicates_def: tLPAREN list_predicates tRPAREN

list_predicates: kPREDICATES list_atomic_formula_skeleton

list_atomic_formula_skeleton: atomic_formula_skeleton list_atomic_formula_skeleton
  |
  ;

atomic_formula_skeleton: tLPAREN predicate typed_list tRPAREN

typed_list: tHYPHEN type typed_list
 | variable typed_list
 |
 ;

variable: tVARIABLE variable
  |
  ;

predicate : tSTRING

type: tSTRING

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
