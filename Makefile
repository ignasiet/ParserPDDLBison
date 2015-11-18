all: pddl

pddl: parser.tab.c lex.yy.c Variable.o Predicate.o ListPredicates.o Effect.o
	g++ -Wall -g -o pddl lex.yy.c parser.tab.c Variable.o Predicate.o ListPredicates.o Effect.o

lex.yy.c: parser.l
	flex parser.l

Effect.o: ./Classes/Effect.h
	g++ -Wall ./Classes/Effect.cpp -c	

Predicate.o: ./Classes/Predicate.h
	g++ -Wall ./Classes/Predicate.cpp -c

Variable.o: ./Classes/Variable.h
	g++ -Wall ./Classes/Variable.cpp -c

ListPredicates.o: ./Classes/ListPredicates.h
	g++ -Wall ./Classes/ListPredicates.cpp -c

parser.tab.c: parser.y
	bison -v -d -Wconflicts-sr parser.y

clean:
	rm -rf -v pddl lex.yy.c parser.tab.c parser.tab.h parser.output *.o
