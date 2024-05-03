%{

#include "zcalc.tab.h"
#include "zcalc.h"
#include <math.h>

/************************************************************************
*                                                                       
* Author: Zachary E Ruiz  (ruiz@capsl.udel.edu)
*         Computer Architecture and Parallel Systems Laboratory               
*         (http://www.capsl.udel.edu) - University of Delaware
*                                                                       
* Purpose: Lexical analyzer for a simple calculator.
*
************************************************************************/

%}

%option noyywrap

%%
([0-9]+|([0-9]*\.[0-9]+)([eE][-+]?[0-9]+)?) {
                                               yylval.dval = atof(yytext);
                                               return NUMBER;
                                            }

[ \t]  ;

[A-Za-z][A-Za-z0-9]*   {
                          struct symtab *sp = symlook(yytext);
                          yylval.symp = sp;
                          return NAME;
                       }

"**"     { return POWER_OP; }
">>"     { return RSHIFT_OP; }
"<<"     { return LSHIFT_OP; }

"$"      { return 0; }

\n    |
.     return yytext[0];
%%
