all: pddl

pddl: parser.tab.c lex.yy.c 
	gcc -Wall -g -o pddl lex.yy.c parser.tab.c

lex.yy.c: parser.l
	flex parser.l

parser.tab.c: parser.y
	bison -v -d parser.y

clean:
	rm -rf pddl lex.yy.c parser.tab.c parser.tab.h parser.output
