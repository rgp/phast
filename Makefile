CC	= gcc
CFLAGS	= #
LINKS = #src/lib/list.c src/lib/strmap.c
build: clean bison.c lex.c
	$(CC) $(CFLAGS) $(LINKS) bison/src/bison.c flex/src/lex.c -o phast-compiler

run: build   #make run f=INPUT_FILE
	./phast-compiler $(f)

### BISON
bison.c : 
	bison src/sintax.y -d -v -o bison/src/bison.c

### LEX
lex.c : 
	flex -o flex/src/lex.c src/tokens.l

### CLEAN TASKS
clean: clean_lex_src clean_bis_src
	rm -f phast-compiler
clean_lex_src:
	rm -f flex/src/*
clean_bis_src:
	rm -f bison/src/*
