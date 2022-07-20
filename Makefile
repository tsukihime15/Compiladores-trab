etapa2: y.tab.c lex.yy.c
	gcc lex.yy.c -o etapa2

y.tab.c: parser.y
	yacc parser.y -d

parser.tab.h: parser.y
	bison -d parser.y

lex.yy.c: scanner.l
	lex scanner.l

clean:
	rm etapa2 y.tab.c y.tab.h lex.yy.c
