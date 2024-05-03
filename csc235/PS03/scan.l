%{
#include "zcalc.h"
#include <math.h>

int ch;
int flag = 0;

#define NAME 257
#define SEMISYM 268
#define COMMASYM 269
#define LPARSYM 270
#define RPARSYM 271
#define EQSYM 272
#define PLUSSYM 273
#define MULTSYM 274
#define ASGNSYM 275
#define MINUSSYM 276
#define NUMBER 277
#define TILDE 278

void yyerror( char *mesg );	/* yacc error checker */

%}

/* definitions for lex analyzer */
letter [A-Za-z]
digit  [0-9]+
ident {letter}({letter}|{digit})*
ws  [ \t\n]+
other  .


%%

{ws}  ;			/*---- Tokens and Actions---- */
"//".* ;
";" return SEMISYM;
"," return COMMASYM;
"(" return LPARSYM;
")" return RPARSYM;
"==" return EQSYM;
"+" return PLUSSYM;
"*" return MULTSYM;
"=" return ASGNSYM;
"-" return MINUSSYM;
"~" return TILDE;

{ident}     {
                 return NAME;
            }

{digit}     {
                 return NUMBER;
            }

"$"   { return 0; }

{other} ;				/* ignore other stuff */

%%

void yyerror( char *mesg );	/* yacc error checker */

/* yacc error function */
void yyerror( char *mesg ) {
  flag = 1;
  printf("%s \n" , mesg);
}

int main() {
  printf("Lex  \t\tToken\t\t\n"); /* header on columns */
  printf("----------------------------\n");
  do
  {
    ch = yylex();

    if (ch == SEMISYM)
      printf("%s\t\tSEMICOLON ", yytext);
    else if (ch == COMMASYM)
      printf("%s\t\tCOMMA ", yytext);
    else if (ch == LPARSYM)
      printf("%s\t\tL_PARENTHESIS ", yytext);
    else if (ch == RPARSYM)
      printf("%s\t\tR_PARENTHESIS ", yytext);
    else if (ch == EQSYM)
      printf("%s\t\tEQ_OP ", yytext);
    else if (ch == PLUSSYM)
      printf("%s\t\tPLUS_OP ", yytext);
    else if (ch == MULTSYM)
      printf("%s\t\tMULT_OP ", yytext);
    else if (ch == ASGNSYM)
      printf("%s\t\tASSIGNMENT_STMT ", yytext);
    else if (ch == MINUSSYM)
      printf("%s\t\tMINUS_OP ", yytext);
    else if (ch == NUMBER)
      printf("%s\t\tNUMBER ", yytext);
    else if (ch == NAME)
      printf("%s\t\tNAME\t\t", yytext);
	 else if (ch == TILDE)
		printf("%s\t\tTILDE\t\t", yytext);
    else
     printf("%c ",ch);
     printf("\n");			/* end check token read */
   }
   while(ch != 0);			/* read until end of file */

  return 0;
}

int yywrap() {
  return 1;
}
