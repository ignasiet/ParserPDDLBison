%{
  #include <string.h>
  #include <iostream>
  #include <stdio.h>
  #include <list>

  // Bring the standard library into the
  // global namespace
  using namespace std;

  #define YYERROR_VERBOSE 1
  extern FILE* yyin;
  extern int yyparse(void);
  extern FILE *yyin;
  extern void yyerror(char const*);
  extern int yylex(void);

  char str_requirements[80];
  char str_types[80];
  char str_predicate[80];
%}

%code requires {
  #include "./Classes/Effect.h"
}

%union {
  int ival;
  float fval;
  char *sval;
  Predicate *predicate;
  Variable *var;
  ListPredicates *prec;
}

%token tLPAREN tRPAREN tHYPHEN
%token kREQUIREMENTS kTYPING kSTRIPS kTYPES kPREDICATES kCONSTANTS
%token kACTION kPARAMETERS kPRECONDITION kEFFECT kAND kNOT kOBSERVE kWHEN
%token <sval> kDEFINE kDOMAIN kPROBLEM tSTRING tVARIABLE

%type <sval> domain_name terminal_type_string terminal_string
%type <predicate> actions_typed_list action_formula_skeleton
%type <var> variable
%type <prec> list_fluents condition effect

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


/*Variables ?i*/
typed_list: variable typed_list
 | tHYPHEN terminal_type_string typed_list
 |
 ;

actions_typed_list: variable actions_typed_list{
  $2->add_parameter($1);
  $$ = $2;
}
 |{
   Predicate* v = new Predicate();
   $$ = v;
 }
 ;

variable: tVARIABLE {
  string st = $1;
  Variable* v = new Variable(st);
  $$ = v;
}

/*Parameters variable*/
parameter_typed_list: variable tHYPHEN terminal_type_string parameter_typed_list {
  $1->set_type($3);
}
  |
  ;

/*Constants*/
constants_def: tLPAREN list_constants tRPAREN

list_constants: kCONSTANTS constants_list

constants_list: tSTRING constants_list
  | tHYPHEN terminal_string constants_list
  |
  ;

/*Actions*/
action_def: tLPAREN kACTION terminal_string parameters_action action_def_body tRPAREN

parameters_action: kPARAMETERS tLPAREN parameter_typed_list tRPAREN

action_def_body: action_preconditions action_result

/*Action preconditions*/
action_preconditions: kPRECONDITION tLPAREN list_fluents tRPAREN {
  cout << $3->print_predicates() << endl;
}
  | kPRECONDITION list_fluents{
    cout << $2->print_predicates() << endl;
  }


/*Action Effects*/
action_result: kEFFECT tLPAREN list_fluents tRPAREN
  | kEFFECT tLPAREN conditional_effect tRPAREN
  | kOBSERVE list_fluents

  /*Conditional effects*/
conditional_effect: kAND tLPAREN kWHEN condition effect tRPAREN {
  Effect* e = new Effect();
  e->add_condition($4);
  e->add_effect($5);
}
  | tLPAREN kWHEN condition effect tRPAREN {
    Effect* e = new Effect();
    e->add_condition($3);
    e->add_effect($4);
  }

condition: list_fluents {$$ = $1;}

effect: list_fluents {$$ = $1;}

list_fluents: kAND action_formula_skeleton list_fluents{
  $3->add_predicate($2);
  $$ = $3;
  }
  | action_formula_skeleton list_fluents {
    $2->add_predicate($1);
    $$ = $2;
  }
  | {
    ListPredicates* v = new ListPredicates();
    $$ = v;
  }
  ;

action_formula_skeleton: tLPAREN terminal_string actions_typed_list tRPAREN {
  string st = $2;
  $3->set_name($2);
  $$ = $3;
}
  | tLPAREN kNOT tLPAREN terminal_string actions_typed_list tRPAREN tRPAREN {
  $5->set_name($4);
  $5->negate();
  $$ = $5;
};

/*Terminal leafs*/
terminal_string: tSTRING {
  $$ = $1;
}

terminal_type_string: tSTRING {
  $$ = $1;
}

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
