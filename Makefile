all: pddl

pddl: parser.tab.c lex.yy.c Atom.o
	g++ -Wall -g -o pddl lex.yy.c parser.tab.c Atom.o

lex.yy.c: parser.l
	flex parser.l

Atom.o: ./Classes/Atom.h
	g++ -Wall ./Classes/Atom.cpp -c

parser.tab.c: parser.y
	bison -v -d  parser.y

clean:
	rm -rf -v pddl lex.yy.c parser.tab.c parser.tab.h parser.output *.o
