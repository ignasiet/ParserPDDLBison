all: pddl

pddl: parser.tab.c lex.yy.c Variable.o Predicate.o
	g++ -Wall -g -o pddl lex.yy.c parser.tab.c Variable.o Predicate.o 

lex.yy.c: parser.l
	flex parser.l

Predicate.o: ./Classes/Predicate.h
	g++ -Wall ./Classes/Predicate.cpp -c

Variable.o: ./Classes/Variable.h
	g++ -Wall ./Classes/Variable.cpp -c

parser.tab.c: parser.y
	bison -v -d  parser.y

clean:
	rm -rf -v pddl lex.yy.c parser.tab.c parser.tab.h parser.output *.o
