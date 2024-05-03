
# You have to comment the proper lines below according to the
# scanner and parser generators available in your system

#LEX = lex
#YACC = yacc -d
LEX = flex 
YACC = bison -d

# We assume that your C-compiler is called cc

CC     = gcc
CFLAGS =
CLIB   = -lm

SRC    = zcalc.tab.c lex.yy.c
OBJ    = $(SRC:.c=.o)

SHELL=/bin/sh

all: prefix infix postfix



prefix: prefix.y zcalc.l
	$(YACC) $@.y --file-prefix=zcalc
	$(CC) -c $(CFLAGS) -o zcalc.tab.o zcalc.tab.c
	$(LEX) zcalc.l
	$(CC) -c $(CFLAGS) -o lex.yy.o lex.yy.c
	$(CC) $(CFLAGS) -o $@ zcalc.tab.o lex.yy.o $(CLIB)
	
infix: infix.y zcalc.l
	$(YACC) $@.y --file-prefix=zcalc
	$(CC) -c $(CFLAGS) -o zcalc.tab.o zcalc.tab.c
	$(LEX) zcalc.l
	$(CC) -c $(CFLAGS) -o lex.yy.o lex.yy.c
	$(CC) $(CFLAGS) -o $@ zcalc.tab.o lex.yy.o $(CLIB)
	
postfix: postfix.y zcalc.l
	$(YACC) $@.y --file-prefix=zcalc
	$(CC) -c $(CFLAGS) -o zcalc.tab.o zcalc.tab.c
	$(LEX) zcalc.l
	$(CC) -c $(CFLAGS) -o lex.yy.o lex.yy.c
	$(CC) $(CFLAGS) -o $@ zcalc.tab.o lex.yy.o $(CLIB)


clean:
	rm -f $(OBJ) prefix infix postfix zcalc.tab.h zcalc.tab.c lex.yy.c *.o
