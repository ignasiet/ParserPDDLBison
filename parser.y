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
%token kREQUIREMENTS kTYPING kSTRIPS kTYPES kPREDICATES kCONSTANTS
%token kACTION kPARAMETERS kPRECONDITION kEFFECT kAND kNOT kOBSERVE
%token <sval> kDEFINE kDOMAIN kPROBLEM tSTRING

%type <sval> domain_name

%start start

%%

start: tLPAREN kDEFINE tLPAREN kDOMAIN domain_name tRPAREN
  domain_definitions
  domain_types
  domain_body
  tRPAREN {printf("Domain: %s\n", $5);}
  ;

domain_body: predicates_def domain_body
  | constants_def domain_body
  | action_def domain_body
  |
  ;

domain_name: tSTRING {$$ = $1;}
  ;

domain_definitions: tLPAREN definition tRPAREN {printf("Parsed requirements: %s\n", str_requirements);}

definition:  kREQUIREMENTS definition
  |  kTYPING  definition {strcat(str_requirements, "types ");}
  |  kSTRIPS  definition {strcat(str_requirements, "strips ");}
  |
  ;

/*Types*/
domain_types: tLPAREN types tRPAREN {printf("Parsed types: %s\n", str_types);}

types:  kTYPES types
  | tSTRING types {strcat(str_types, $1);}
  |
  ;

predicates_def: tLPAREN list_predicates tRPAREN

list_predicates: kPREDICATES list_atomic_formula_skeleton

/*Formulas*/
list_atomic_formula_skeleton: atomic_formula_skeleton list_atomic_formula_skeleton
  |
  ;

atomic_formula_skeleton: tLPAREN terminal_string typed_list tRPAREN
  | tLPAREN kNOT tLPAREN terminal_string typed_list tRPAREN tRPAREN
  ;

typed_list: variable typed_list
 | tHYPHEN terminal_string typed_list
 |
 ;

variable: tVARIABLE

/*Constants*/
constants_def: tLPAREN list_constants tRPAREN

list_constants: kCONSTANTS constants_list

constants_list: tSTRING constants_list
  | tHYPHEN terminal_string constants_list
  |
  ;

/*Actions*/
action_def: tLPAREN kACTION terminal_string parameters_action action_def_body tRPAREN

parameters_action: kPARAMETERS tLPAREN typed_list tRPAREN

action_def_body: action_preconditions action_result

action_preconditions: kPRECONDITION tLPAREN action_predicates tRPAREN
  | kPRECONDITION action_predicates

action_result: kEFFECT tLPAREN action_predicates tRPAREN
  | kOBSERVE action_predicates

action_predicates: kAND atomic_formula_skeleton action_predicates
  | atomic_formula_skeleton action_predicates
  |
  ;

/*Terminal leafs*/
terminal_string: tSTRING

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
