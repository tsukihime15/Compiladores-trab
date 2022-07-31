etapa2: parser.tab.c lex.yy.c
	gcc lex.yy.c -o etapa2

parser.tab.c: parser.y
	bison -d --report=all --report-file=debug.txt parser.y

lex.yy.c: scanner.l
	flex --header-file=lex.yy.h scanner.l

clean:
	rm etapa2 parser.tab.c parser.tab.h debug.txt lex.yy.c
