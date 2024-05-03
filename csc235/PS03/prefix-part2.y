%{ 
#include "zcalc.h"

#include <string.h>
#include <math.h>
#include <stdlib.h>
#include <stdio.h>


	
/************************************************************************
*                                                                       
* Author: Zachary E Ruiz  (ruiz@capsl.udel.edu) (Original)
*         Aaron Landwehr (aron@udel.edu) (Modification)
*         Computer Architecture and Parallel Systems Laboratory               
*         (http://www.capsl.udel.edu) - University of Delaware
*                                                                       
* Purpose:  Actions for a simple prefix calculator...
*
************************************************************************/


int flag = 0;

void yyerror( char *mesg );	/* yacc error checker */
 
%}

%union {
  int dval;
  struct symtab *symp;
}

%token POWER_OP "**"
%token RSHIFT_OP ">>" 
%token LSHIFT_OP "<<" 
%token <symp> NAME
%token <dval> NUMBER

%left '|'
%left '^'
%left '&'
%precedence RSHIFT_OP LSHIFT_OP
%precedence '~'
%left '-' '+' 
%left '*' '/'
%right POWER_OP


%type <dval> expression
%%

statement_list: statement '\n'
                | statement_list statement '\n'

statement: NAME '=' expression { $1->value = $3; }
           | expression { printf("= %d\n", $1); }

expression: POWER_OP expression expression { $$ = pow($2, $3);}
            | '*' expression expression { $$ = $2 * $3; }
            | '/' expression expression { $$ = $2 / $3; }
            | '+' expression expression { $$ = $2 + $3; }
            | '-' expression expression { $$ = $2 - $3; }
            | '~' expression { $$ = ~$2; }
            | LSHIFT_OP expression expression {$$ = $2 << $3; }
            | RSHIFT_OP expression expression {$$ = $2 >> $3; }
            | '&' expression expression { $$ = $2 && $3;}
            | '^' expression expression { $$ = ($2 || $3) - ($2 && $3);}
            | '|' expression expression { $$ = $2 || $3;}
            | '(' expression ')' { $$ = $2; }
            | NUMBER
            | NAME { $$ = $1->value; }
%%

struct symtab * symlook( char *s ) {
   char *p;
   struct symtab *sp;

   for(sp = symtab; sp < &symtab[NSYMS]; sp++) {
     /* is it already here? */
     if (sp->name && !strcmp(sp->name, s))
       return sp;

     /* is it free */
     if (!sp->name) {
       sp->name = strdup(s);
       return sp;
     }
     /* otherwise continue to the next */
   }
   yyerror("Too many symbols...\n");
   exit(1);
}

void addfunc( char *name, double (*func)() ) {
  struct symtab *sp = symlook(name);
  sp->funcptr = func;
}


/* yacc error function */
void yyerror( char *mesg )	{
  flag = 1;
  printf("%s \n" , mesg);  
}


int main() {

  yyparse();

  return 0;
}


