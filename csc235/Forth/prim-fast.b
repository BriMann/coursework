#line 1 "prim"
\ Gforth primitives

\ Copyright (C) 1995,1996,1997,1998,2000,2003,2004,2005,2006,2007,2008 Free Software Foundation, Inc.

\ This file is part of Gforth.

\ Gforth is free software; you can redistribute it and/or
\ modify it under the terms of the GNU General Public License
\ as published by the Free Software Foundation, either version 3
\ of the License, or (at your option) any later version.

\ This program is distributed in the hope that it will be useful,
\ but WITHOUT ANY WARRANTY; without even the implied warranty of
\ MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
\ GNU General Public License for more details.

\ You should have received a copy of the GNU General Public License
\ along with this program. If not, see http://www.gnu.org/licenses/.


\ WARNING: This file is processed by m4. Make sure your identifiers
\ don't collide with m4's (e.g. by undefining them).
\ 
\ 
\ 
\ This file contains primitive specifications in the following format:
\ 
\ forth name	( stack effect )	category	[pronunciation]
\ [""glossary entry""]
\ C code
\ [:
\ Forth code]
\ 
\ Note: Fields in brackets are optional.  Word specifications have to
\ be separated by at least one empty line
\
\ Both pronounciation and stack items (in the stack effect) must
\ conform to the C identifier syntax or the C compiler will complain.
\ If you don't have a pronounciation field, the Forth name is used,
\ and has to conform to the C identifier syntax.
\ 
\ These specifications are automatically translated into C-code for the
\ interpreter and into some other files. I hope that your C compiler has
\ decent optimization, otherwise the automatically generated code will
\ be somewhat slow. The Forth version of the code is included for manual
\ compilers, so they will need to compile only the important words.
\ 
\ Note that stack pointer adjustment is performed according to stack
\ effect by automatically generated code and NEXT is automatically
\ appended to the C code. Also, you can use the names in the stack
\ effect in the C code. Stack access is automatic. One exception: if
\ your code does not fall through, the results are not stored into the
\ stack. Use different names on both sides of the '--', if you change a
\ value (some stores to the stack are optimized away).
\
\ For superinstructions the syntax is:
\
\ forth-name [/ c-name] = forth-name forth-name ...
\
\ 
\ The stack variables have the following types:
\ 
\ name matches	type
\ f.*		Bool
\ c.*		Char
\ [nw].*	Cell
\ u.*		UCell
\ d.*		DCell
\ ud.*		UDCell
\ r.*		Float
\ a_.*		Cell *
\ c_.*		Char *
\ f_.*		Float *
\ df_.*		DFloat *
\ sf_.*		SFloat *
\ xt.*		XT
\ f83name.*	F83Name *

\E stack data-stack   sp Cell
\E stack fp-stack     fp Float
\E stack return-stack rp Cell
\E
\E get-current prefixes set-current
\E 
\E s" Bool"		single data-stack type-prefix f
\E s" Char"		single data-stack type-prefix c
\E s" Cell"		single data-stack type-prefix n
\E s" Cell"		single data-stack type-prefix w
\E s" UCell"		single data-stack type-prefix u
\E s" DCell"		double data-stack type-prefix d
\E s" UDCell"		double data-stack type-prefix ud
\E s" Float"		single fp-stack   type-prefix r
\E s" Cell *"		single data-stack type-prefix a_
\E s" Char *"		single data-stack type-prefix c_
\E s" Float *"		single data-stack type-prefix f_
\E s" DFloat *"		single data-stack type-prefix df_
\E s" SFloat *"		single data-stack type-prefix sf_
\E s" Xt"		single data-stack type-prefix xt
\E s" struct F83Name *"	single data-stack type-prefix f83name
\E s" struct Longname *" single data-stack type-prefix longname
\E 
\E data-stack   stack-prefix S:
\E fp-stack     stack-prefix F:
\E return-stack stack-prefix R:
\E inst-stream  stack-prefix #
\E 
\E set-current
\E store-optimization on
\E ' noop tail-nextp2 ! \ now INST_TAIL just stores, but does not jump
\E
\E include-skipped-insts on \ static superinsts include cells for components
\E                            \ useful for dynamic programming and
\E                            \ superinsts across entry points

\ 
\ 
\ 
\ In addition the following names can be used:
\ ip	the instruction pointer
\ sp	the data stack pointer
\ rp	the parameter stack pointer
\ lp	the locals stack pointer
\ NEXT	executes NEXT
\ cfa	
\ NEXT1	executes NEXT1
\ FLAG(x)	makes a Forth flag from a C flag
\ 
\ 
\ 
\ Percentages in comments are from Koopmans book: average/maximum use
\ (taken from four, not very representative benchmarks)
\ 
\ 
\ 
\ To do:
\ 
\ throw execute, cfa and NEXT1 out?
\ macroize *ip, ip++, *ip++ (pipelining)?

\ Stack caching setup

#line 1 "cache-fast1.vmg"
\ stack cache setup: default state S1

\ Copyright (C) 2003,2004,2005,2006,2007,2008 Free Software Foundation, Inc.

\ This file is part of Gforth.

\ Gforth is free software; you can redistribute it and/or
\ modify it under the terms of the GNU General Public License
\ as published by the Free Software Foundation, either version 3
\ of the License, or (at your option) any later version.

\ This program is distributed in the hope that it will be useful,
\ but WITHOUT ANY WARRANTY; without even the implied warranty of
\ MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
\ GNU General Public License for more details.

\ You should have received a copy of the GNU General Public License
\ along with this program. If not, see http://www.gnu.org/licenses/.

\E register IPTOS Cell
\E register spTOS Cell
\E register spb Cell
\E register spc Cell
\E register spd Cell
\E register spe Cell
\E register spf Cell
\E register spg Cell
\E register sph Cell

\E register fpTOS Float

\E create IPregs IPTOS ,
\E create regs sph , spg , spf , spe , spd , spc , spb , spTOS ,
\ \E create regs spTOS ,
\E create fpregs fpTOS ,

\E IPregs 1 0 stack-state IPss1
\E regs 8 th 0  -1 stack-state ss0
\E regs 7 th 1  0 stack-state ss1
\E regs 6 th 2  1 stack-state ss2
\E regs 5 th 3  2 stack-state ss3
\E regs 4 th 4  3 stack-state ss4
\E regs 3 th 5  4 stack-state ss5
\E regs 2 th 6  5 stack-state ss6
\E regs 1 th 7  6 stack-state ss7
\E regs 0 th 8  7 stack-state ss8
\ \E regs 1 th 0 -1 stack-state ss0
\ \E regs           1  0 stack-state ss1
\E fpregs 0 th 1 0 stack-state fpss1

\ the first of these is the default state (for now)
\E state S1
\E state S0
\E state S2
\E state S3
\E state S4
\E state S5
\E state S6
\E state S7
\E state S8

#line 1 "cache-regs1.vmg"
\ stack cache diablers: maximun state S1

\ Copyright (C) 2008 Free Software Foundation, Inc.

\ This file is part of Gforth.

\ Gforth is free software; you can redistribute it and/or
\ modify it under the terms of the GNU General Public License
\ as published by the Free Software Foundation, either version 3
\ of the License, or (at your option) any later version.

\ This program is distributed in the hope that it will be useful,
\ but WITHOUT ANY WARRANTY; without even the implied warranty of
\ MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
\ GNU General Public License for more details.

\ You should have received a copy of the GNU General Public License
\ along with this program. If not, see http://www.gnu.org/licenses/.

\E S2 state-disable
\E S3 state-disable
\E S4 state-disable
\E S5 state-disable
\E S6 state-disable
\E S7 state-disable
\E S8 state-disable
#line 62 "cache-fast1.vmg"


\E ss0 data-stack S0 set-ss
\E ss1 data-stack S1 set-ss
\E ss2 data-stack S2 set-ss
\E ss3 data-stack S3 set-ss
\E ss4 data-stack S4 set-ss
\E ss5 data-stack S5 set-ss
\E ss6 data-stack S6 set-ss
\E ss7 data-stack S7 set-ss
\E ss8 data-stack S8 set-ss

\E IPss1 inst-stream S0 set-ss
\E IPss1 inst-stream S1 set-ss
\E IPss1 inst-stream S2 set-ss
\E IPss1 inst-stream S3 set-ss
\E IPss1 inst-stream S4 set-ss
\E IPss1 inst-stream S5 set-ss
\E IPss1 inst-stream S6 set-ss
\E IPss1 inst-stream S7 set-ss
\E IPss1 inst-stream S8 set-ss

\E fpss1 fp-stack S0 set-ss
\E fpss1 fp-stack S1 set-ss
\E fpss1 fp-stack S2 set-ss
\E fpss1 fp-stack S3 set-ss
\E fpss1 fp-stack S4 set-ss
\E fpss1 fp-stack S5 set-ss
\E fpss1 fp-stack S6 set-ss
\E fpss1 fp-stack S7 set-ss
\E fpss1 fp-stack S8 set-ss

\E data-stack to cache-stack
\E here 9 cache-states 2! s0 , s1 , s2 , s3 , s4 , s5 , s6 , s7 , s8 ,
\ \E here 2 cache-states 2! s0 , s1 ,

\ !! the following should be automatic
\E S1 to state-default
\E state-default to state-in
\E state-default to state-out
#line 142 "prim"


\ these m4 macros would collide with identifiers




\F 0 [if]

\ run-time routines for non-primitives.  They are defined as
\ primitives, because that simplifies things.

(docol)	( -- R:a_retaddr )	gforth-internal	paren_docol
""run-time routine for colon definitions""
#ifdef NO_IP
a_retaddr = next_code;
INST_TAIL;
goto **(Label *)PFA(CFA);
#else /* !defined(NO_IP) */
a_retaddr = (Cell *)IP;
SET_IP((Xt *)PFA(CFA));
#endif /* !defined(NO_IP) */

(docon) ( -- w )	gforth-internal	paren_docon
""run-time routine for constants""
w = *(Cell *)PFA(CFA);
#ifdef NO_IP
INST_TAIL;
goto *next_code;
#endif /* defined(NO_IP) */

(dovar) ( -- a_body )	gforth-internal	paren_dovar
""run-time routine for variables and CREATEd words""
a_body = PFA(CFA);
#ifdef NO_IP
INST_TAIL;
goto *next_code;
#endif /* defined(NO_IP) */

(douser) ( -- a_user )	gforth-internal	paren_douser
""run-time routine for constants""
a_user = (Cell *)(up+*(Cell *)PFA(CFA));
#ifdef NO_IP
INST_TAIL;
goto *next_code;
#endif /* defined(NO_IP) */

(dodefer) ( -- )	gforth-internal	paren_dodefer
""run-time routine for deferred words""
#ifndef NO_IP
ip=IP; /* undo any ip updating that may have been performed by NEXT_P0 */
#endif /* !defined(NO_IP) */
SUPER_END; /* !! probably unnecessary and may lead to measurement errors */
VM_JUMP(EXEC1(*(Xt *)PFA(CFA)));

(dofield) ( n1 -- n2 )	gforth-internal	paren_field
""run-time routine for fields""
n2 = n1 + *(Cell *)PFA(CFA);
#ifdef NO_IP
INST_TAIL;
goto *next_code;
#endif /* defined(NO_IP) */

(dovalue) ( -- w )	gforth-internal	paren_doval
""run-time routine for constants""
w = *(Cell *)PFA(CFA);
#ifdef NO_IP
INST_TAIL;
goto *next_code;
#endif /* defined(NO_IP) */

(dodoes) ( -- a_body R:a_retaddr )	gforth-internal	paren_dodoes
""run-time routine for @code{does>}-defined words""
#ifdef NO_IP
a_retaddr = next_code;
a_body = PFA(CFA);
INST_TAIL;
#ifdef DEBUG
fprintf(stderr, "dodoes to %x, push %x\n", a_retaddr, a_body);
#endif
goto **(Label *)DOES_CODE1(CFA);
#else /* !defined(NO_IP) */
a_retaddr = (Cell *)IP;
a_body = PFA(CFA);
#ifdef DEBUG
fprintf(stderr, "dodoes to %x, push %x\n", a_retaddr, a_body);
#endif
SET_IP(DOES_CODE1(CFA));
#endif /* !defined(NO_IP) */

(does-handler) ( -- )	gforth-internal	paren_does_handler
""just a slot to have an encoding for the DOESJUMP, 
which is no longer used anyway (!! eliminate this)""

\F [endif]

\g control

noop	( -- )		gforth
:
 ;

call	( #a_callee -- R:a_retaddr )	new
""Call callee (a variant of docol with inline argument).""
#ifdef NO_IP
assert(0);
INST_TAIL;
JUMP(a_callee);
#else
#ifdef DEBUG
    {
      CFA_TO_NAME((((Cell *)a_callee)-2));
      fprintf(stderr,"%08lx: call %08lx %.*s\n",(Cell)ip,(Cell)a_callee,
	      len,name);
    }
#endif
a_retaddr = (Cell *)IP;
SET_IP((Xt *)a_callee);
#endif

execute	( xt -- )		core
""Perform the semantics represented by the execution token, @i{xt}.""
#ifdef DEBUG
fprintf(stderr, "execute %08x\n", xt);
#endif
#ifndef NO_IP
ip=IP;
#endif
SUPER_END;
VM_JUMP(EXEC1(xt));

perform	( a_addr -- )	gforth
""@code{@@ execute}.""
/* and pfe */
#ifndef NO_IP
ip=IP;
#endif
SUPER_END;
VM_JUMP(EXEC1(*(Xt *)a_addr));
:
 @ execute ;

;s	( R:w -- )		gforth	semis
""The primitive compiled by @code{EXIT}.""
#ifdef NO_IP
INST_TAIL;
goto *(void *)w;
#else
SET_IP((Xt *)w);
#endif

unloop	( R:w1 R:w2 -- )	core
/* !! alias for 2rdrop */
:
 r> rdrop rdrop >r ;

lit-perform	( #a_addr -- )	new	lit_perform
#ifndef NO_IP
ip=IP;
#endif
SUPER_END;
VM_JUMP(EXEC1(*(Xt *)a_addr));

does-exec ( #a_cfa -- R:nest a_pfa )	new	does_exec
#ifdef NO_IP
/* compiled to LIT CALL by compile_prim */
assert(0);
#else
a_pfa = PFA(a_cfa);
nest = (Cell)IP;
#ifdef DEBUG
    {
      CFA_TO_NAME(a_cfa);
      fprintf(stderr,"%08lx: does %08lx %.*s\n",
	      (Cell)ip,(Cell)a_cfa,len,name);
    }
#endif
SET_IP(DOES_CODE1(a_cfa));
#endif

\+glocals

branch-lp+!# ( #a_target #nlocals -- )	gforth	branch_lp_plus_store_number
/* this will probably not be used */
lp += nlocals;
#ifdef NO_IP
INST_TAIL;
JUMP(a_target);
#else
SET_IP((Xt *)a_target);
#endif

\+

branch	( #a_target -- )	gforth
#ifdef NO_IP
INST_TAIL;
JUMP(a_target);
#else
SET_IP((Xt *)a_target);
#endif
:
 r> @ >r ;

\ condbranch(forthname,stackeffect,restline,code1,code2,forthcode)
\ this is non-syntactical: code must open a brace that is closed by the macro
#line 380


?branch ( #a_target f -- ) f83	question_branch
#line 382
	#ifdef NO_IP
#line 382
INST_TAIL;
#line 382
#endif
#line 382
if (f==0) {
#line 382
	#ifdef NO_IP
#line 382
JUMP(a_target);
#line 382
#else
#line 382
SET_IP((Xt *)a_target);
#line 382
INST_TAIL; NEXT_P2;
#line 382
#endif
#line 382
}
#line 382
SUPER_CONTINUE;
#line 382
:
#line 382
 0= dup 0=          \ !f f
#line 382
 r> tuck cell+      \ !f branchoffset f IP+
#line 382
 and -rot @ and or  \ f&IP+|!f&branch
#line 382
 >r ;
#line 382

#line 382
\+glocals
#line 382

#line 382
?branch-lp+!# ( #a_target #nlocals f -- ) f83	question_branch_lp_plus_store_number
#line 382
	#ifdef NO_IP
#line 382
INST_TAIL;
#line 382
#endif
#line 382
if (f==0) {
#line 382
	lp += nlocals;
#line 382
#ifdef NO_IP
#line 382
JUMP(a_target);
#line 382
#else
#line 382
SET_IP((Xt *)a_target);
#line 382
INST_TAIL; NEXT_P2;
#line 382
#endif
#line 382
}
#line 382
SUPER_CONTINUE;
#line 382

#line 382
\+
#line 388


\ we don't need an lp_plus_store version of the ?dup-stuff, because it
\ is only used in if's (yet)

\+xconds

?dup-?branch	( #a_target f -- S:... )	new	question_dupe_question_branch
""The run-time procedure compiled by @code{?DUP-IF}.""
if (f==0) {
#ifdef NO_IP
INST_TAIL;
JUMP(a_target);
#else
SET_IP((Xt *)a_target);
#endif
} else {
sp--;
sp[0]=f;
}

?dup-0=-?branch ( #a_target f -- S:... ) new	question_dupe_zero_equals_question_branch
""The run-time procedure compiled by @code{?DUP-0=-IF}.""
if (f!=0) {
  sp--;
  sp[0]=f;
#ifdef NO_IP
  JUMP(a_target);
#else
  SET_IP((Xt *)a_target);
#endif
}

\+
\fhas? skiploopprims 0= [IF]

(next) ( #a_target R:n1 -- R:n2 ) cmFORTH	paren_next
#line 424
n2=n1-1;
#line 424
	#ifdef NO_IP
#line 424
INST_TAIL;
#line 424
#endif
#line 424
if (n1) {
#line 424
	#ifdef NO_IP
#line 424
JUMP(a_target);
#line 424
#else
#line 424
SET_IP((Xt *)a_target);
#line 424
INST_TAIL; NEXT_P2;
#line 424
#endif
#line 424
}
#line 424
SUPER_CONTINUE;
#line 424
:
#line 424
 r> r> dup 1- >r
#line 424
 IF @ >r ELSE cell+ >r THEN ;
#line 424

#line 424
\+glocals
#line 424

#line 424
(next)-lp+!# ( #a_target #nlocals R:n1 -- R:n2 ) cmFORTH	paren_next_lp_plus_store_number
#line 424
n2=n1-1;
#line 424
	#ifdef NO_IP
#line 424
INST_TAIL;
#line 424
#endif
#line 424
if (n1) {
#line 424
	lp += nlocals;
#line 424
#ifdef NO_IP
#line 424
JUMP(a_target);
#line 424
#else
#line 424
SET_IP((Xt *)a_target);
#line 424
INST_TAIL; NEXT_P2;
#line 424
#endif
#line 424
}
#line 424
SUPER_CONTINUE;
#line 424

#line 424
\+
#line 429


(loop) ( #a_target R:nlimit R:n1 -- R:nlimit R:n2 ) gforth	paren_loop
#line 431
n2=n1+1;
#line 431
	#ifdef NO_IP
#line 431
INST_TAIL;
#line 431
#endif
#line 431
if (n2 != nlimit) {
#line 431
	#ifdef NO_IP
#line 431
JUMP(a_target);
#line 431
#else
#line 431
SET_IP((Xt *)a_target);
#line 431
INST_TAIL; NEXT_P2;
#line 431
#endif
#line 431
}
#line 431
SUPER_CONTINUE;
#line 431
:
#line 431
 r> r> 1+ r> 2dup =
#line 431
 IF >r 1- >r cell+ >r
#line 431
 ELSE >r >r @ >r THEN ;
#line 431

#line 431
\+glocals
#line 431

#line 431
(loop)-lp+!# ( #a_target #nlocals R:nlimit R:n1 -- R:nlimit R:n2 ) gforth	paren_loop_lp_plus_store_number
#line 431
n2=n1+1;
#line 431
	#ifdef NO_IP
#line 431
INST_TAIL;
#line 431
#endif
#line 431
if (n2 != nlimit) {
#line 431
	lp += nlocals;
#line 431
#ifdef NO_IP
#line 431
JUMP(a_target);
#line 431
#else
#line 431
SET_IP((Xt *)a_target);
#line 431
INST_TAIL; NEXT_P2;
#line 431
#endif
#line 431
}
#line 431
SUPER_CONTINUE;
#line 431

#line 431
\+
#line 437


(+loop) ( #a_target n R:nlimit R:n1 -- R:nlimit R:n2 ) gforth paren_plus_loop
#line 439
/* !! check this thoroughly */
#line 439
/* sign bit manipulation and test: (x^y)<0 is equivalent to (x<0) != (y<0) */
#line 439
/* dependent upon two's complement arithmetic */
#line 439
Cell olddiff = n1-nlimit;
#line 439
n2=n1+n;	
#line 439
	#ifdef NO_IP
#line 439
INST_TAIL;
#line 439
#endif
#line 439
if (((olddiff^(olddiff+n))    /* the limit is not crossed */
#line 439
     &(olddiff^n))	       /* OR it is a wrap-around effect */
#line 439
    >=0) { /* & is used to avoid having two branches for gforth-native */
#line 439
	#ifdef NO_IP
#line 439
JUMP(a_target);
#line 439
#else
#line 439
SET_IP((Xt *)a_target);
#line 439
INST_TAIL; NEXT_P2;
#line 439
#endif
#line 439
}
#line 439
SUPER_CONTINUE;
#line 439
:
#line 439
 r> swap
#line 439
 r> r> 2dup - >r
#line 439
 2 pick r@ + r@ xor 0< 0=
#line 439
 3 pick r> xor 0< 0= or
#line 439
 IF    >r + >r @ >r
#line 439
 ELSE  >r >r drop cell+ >r THEN ;
#line 439

#line 439
\+glocals
#line 439

#line 439
(+loop)-lp+!# ( #a_target #nlocals n R:nlimit R:n1 -- R:nlimit R:n2 ) gforth paren_plus_loop_lp_plus_store_number
#line 439
/* !! check this thoroughly */
#line 439
/* sign bit manipulation and test: (x^y)<0 is equivalent to (x<0) != (y<0) */
#line 439
/* dependent upon two's complement arithmetic */
#line 439
Cell olddiff = n1-nlimit;
#line 439
n2=n1+n;	
#line 439
	#ifdef NO_IP
#line 439
INST_TAIL;
#line 439
#endif
#line 439
if (((olddiff^(olddiff+n))    /* the limit is not crossed */
#line 439
     &(olddiff^n))	       /* OR it is a wrap-around effect */
#line 439
    >=0) { /* & is used to avoid having two branches for gforth-native */
#line 439
	lp += nlocals;
#line 439
#ifdef NO_IP
#line 439
JUMP(a_target);
#line 439
#else
#line 439
SET_IP((Xt *)a_target);
#line 439
INST_TAIL; NEXT_P2;
#line 439
#endif
#line 439
}
#line 439
SUPER_CONTINUE;
#line 439

#line 439
\+
#line 454


\+xconds

(-loop) ( #a_target u R:nlimit R:n1 -- R:nlimit R:n2 ) gforth paren_minus_loop
#line 458
UCell olddiff = n1-nlimit;
#line 458
n2=n1-u;
#line 458
	#ifdef NO_IP
#line 458
INST_TAIL;
#line 458
#endif
#line 458
if (olddiff>u) {
#line 458
	#ifdef NO_IP
#line 458
JUMP(a_target);
#line 458
#else
#line 458
SET_IP((Xt *)a_target);
#line 458
INST_TAIL; NEXT_P2;
#line 458
#endif
#line 458
}
#line 458
SUPER_CONTINUE;
#line 458

#line 458

#line 458
\+glocals
#line 458

#line 458
(-loop)-lp+!# ( #a_target #nlocals u R:nlimit R:n1 -- R:nlimit R:n2 ) gforth paren_minus_loop_lp_plus_store_number
#line 458
UCell olddiff = n1-nlimit;
#line 458
n2=n1-u;
#line 458
	#ifdef NO_IP
#line 458
INST_TAIL;
#line 458
#endif
#line 458
if (olddiff>u) {
#line 458
	lp += nlocals;
#line 458
#ifdef NO_IP
#line 458
JUMP(a_target);
#line 458
#else
#line 458
SET_IP((Xt *)a_target);
#line 458
INST_TAIL; NEXT_P2;
#line 458
#endif
#line 458
}
#line 458
SUPER_CONTINUE;
#line 458

#line 458
\+
#line 462


(s+loop) ( #a_target n R:nlimit R:n1 -- R:nlimit R:n2 ) gforth	paren_symmetric_plus_loop
#line 464
""The run-time procedure compiled by S+LOOP. It loops until the index
#line 464
crosses the boundary between limit and limit-sign(n). I.e. a symmetric
#line 464
version of (+LOOP).""
#line 464
/* !! check this thoroughly */
#line 464
Cell diff = n1-nlimit;
#line 464
Cell newdiff = diff+n;
#line 464
if (n<0) {
#line 464
    diff = -diff;
#line 464
    newdiff = -newdiff;
#line 464
}
#line 464
n2=n1+n;
#line 464
	#ifdef NO_IP
#line 464
INST_TAIL;
#line 464
#endif
#line 464
if (((~diff)|newdiff)<0) { /* use | to avoid two branches for gforth-native */
#line 464
	#ifdef NO_IP
#line 464
JUMP(a_target);
#line 464
#else
#line 464
SET_IP((Xt *)a_target);
#line 464
INST_TAIL; NEXT_P2;
#line 464
#endif
#line 464
}
#line 464
SUPER_CONTINUE;
#line 464

#line 464

#line 464
\+glocals
#line 464

#line 464
(s+loop)-lp+!# ( #a_target #nlocals n R:nlimit R:n1 -- R:nlimit R:n2 ) gforth	paren_symmetric_plus_loop_lp_plus_store_number
#line 464
""The run-time procedure compiled by S+LOOP. It loops until the index
#line 464
crosses the boundary between limit and limit-sign(n). I.e. a symmetric
#line 464
version of (+LOOP).""
#line 464
/* !! check this thoroughly */
#line 464
Cell diff = n1-nlimit;
#line 464
Cell newdiff = diff+n;
#line 464
if (n<0) {
#line 464
    diff = -diff;
#line 464
    newdiff = -newdiff;
#line 464
}
#line 464
n2=n1+n;
#line 464
	#ifdef NO_IP
#line 464
INST_TAIL;
#line 464
#endif
#line 464
if (((~diff)|newdiff)<0) { /* use | to avoid two branches for gforth-native */
#line 464
	lp += nlocals;
#line 464
#ifdef NO_IP
#line 464
JUMP(a_target);
#line 464
#else
#line 464
SET_IP((Xt *)a_target);
#line 464
INST_TAIL; NEXT_P2;
#line 464
#endif
#line 464
}
#line 464
SUPER_CONTINUE;
#line 464

#line 464
\+
#line 477


\+

(for)   ( ncount -- R:nlimit R:ncount )         cmFORTH         paren_for
/* or (for) = >r -- collides with unloop! */
nlimit=0;
:
 r> swap 0 >r >r >r ;

(do)    ( nlimit nstart -- R:nlimit R:nstart )  gforth          paren_do
:
 r> swap rot >r >r >r ;

(?do) ( #a_target nlimit nstart -- R:nlimit R:nstart ) gforth	paren_question_do
#ifdef NO_IP
    INST_TAIL;
#endif
if (nstart == nlimit) {
#ifdef NO_IP
    JUMP(a_target);
#else
    SET_IP((Xt *)a_target);
#endif
}
:
  2dup =
  IF   r> swap rot >r >r
       @ >r
  ELSE r> swap rot >r >r
       cell+ >r
  THEN ;				\ --> CORE-EXT

\+xconds

(+do)	( #a_target nlimit nstart -- R:nlimit R:nstart ) gforth	paren_plus_do
#ifdef NO_IP
    INST_TAIL;
#endif
if (nstart >= nlimit) {
#ifdef NO_IP
    JUMP(a_target);
#else
    SET_IP((Xt *)a_target);
#endif
}
:
 swap 2dup
 r> swap >r swap >r
 >=
 IF
     @
 ELSE
     cell+
 THEN  >r ;

(u+do)	( #a_target ulimit ustart -- R:ulimit R:ustart ) gforth	paren_u_plus_do
#ifdef NO_IP
    INST_TAIL;
#endif
if (ustart >= ulimit) {
#ifdef NO_IP
JUMP(a_target);
#else
SET_IP((Xt *)a_target);
#endif
}
:
 swap 2dup
 r> swap >r swap >r
 u>=
 IF
     @
 ELSE
     cell+
 THEN  >r ;

(-do)	( #a_target nlimit nstart -- R:nlimit R:nstart ) gforth	paren_minus_do
#ifdef NO_IP
    INST_TAIL;
#endif
if (nstart <= nlimit) {
#ifdef NO_IP
JUMP(a_target);
#else
SET_IP((Xt *)a_target);
#endif
}
:
 swap 2dup
 r> swap >r swap >r
 <=
 IF
     @
 ELSE
     cell+
 THEN  >r ;

(u-do)	( #a_target ulimit ustart -- R:ulimit R:ustart ) gforth	paren_u_minus_do
#ifdef NO_IP
    INST_TAIL;
#endif
if (ustart <= ulimit) {
#ifdef NO_IP
JUMP(a_target);
#else
SET_IP((Xt *)a_target);
#endif
}
:
 swap 2dup
 r> swap >r swap >r
 u<=
 IF
     @
 ELSE
     cell+
 THEN  >r ;

\+

\ don't make any assumptions where the return stack is!!
\ implement this in machine code if it should run quickly!

i	( R:n -- R:n n )		core
:
\ rp@ cell+ @ ;
  r> r> tuck >r >r ;

i'	( R:w R:w2 -- R:w R:w2 w )		gforth		i_tick
:
\ rp@ cell+ cell+ @ ;
  r> r> r> dup itmp ! >r >r >r itmp @ ;
variable itmp

j	( R:w R:w1 R:w2 -- w R:w R:w1 R:w2 )	core
:
\ rp@ cell+ cell+ cell+ @ ;
  r> r> r> r> dup itmp ! >r >r >r >r itmp @ ;
[IFUNDEF] itmp variable itmp [THEN]

k	( R:w R:w1 R:w2 R:w3 R:w4 -- w R:w R:w1 R:w2 R:w3 R:w4 )	gforth
:
\ rp@ [ 5 cells ] Literal + @ ;
  r> r> r> r> r> r> dup itmp ! >r >r >r >r >r >r itmp @ ;
[IFUNDEF] itmp variable itmp [THEN]

\f[THEN]

\ digit is high-level: 0/0%

\g strings

move	( c_from c_to ucount -- )		core
""Copy the contents of @i{ucount} aus at @i{c-from} to
@i{c-to}. @code{move} works correctly even if the two areas overlap.""
/* !! note that the standard specifies addr, not c-addr */
memmove(c_to,c_from,ucount);
/* make an Ifdef for bsd and others? */
:
 >r 2dup u< IF r> cmove> ELSE r> cmove THEN ;

cmove	( c_from c_to u -- )	string	c_move
""Copy the contents of @i{ucount} characters from data space at
@i{c-from} to @i{c-to}. The copy proceeds @code{char}-by-@code{char}
from low address to high address; i.e., for overlapping areas it is
safe if @i{c-to}=<@i{c-from}.""
cmove(c_from,c_to,u);
:
 bounds ?DO  dup c@ I c! 1+  LOOP  drop ;

cmove>	( c_from c_to u -- )	string	c_move_up
""Copy the contents of @i{ucount} characters from data space at
@i{c-from} to @i{c-to}. The copy proceeds @code{char}-by-@code{char}
from high address to low address; i.e., for overlapping areas it is
safe if @i{c-to}>=@i{c-from}.""
cmove_up(c_from,c_to,u);
:
 dup 0= IF  drop 2drop exit  THEN
 rot over + -rot bounds swap 1-
 DO  1- dup c@ I c!  -1 +LOOP  drop ;

fill	( c_addr u c -- )	core
""Store @i{c} in @i{u} chars starting at @i{c-addr}.""
memset(c_addr,c,u);
:
 -rot bounds
 ?DO  dup I c!  LOOP  drop ;

compare	( c_addr1 u1 c_addr2 u2 -- n )	string
""Compare two strings lexicographically. If they are equal, @i{n} is 0; if
the first string is smaller, @i{n} is -1; if the first string is larger, @i{n}
is 1. Currently this is based on the machine's character
comparison. In the future, this may change to consider the current
locale and its collation order.""
/* close ' to keep fontify happy */ 
n = compare(c_addr1, u1, c_addr2, u2);
:
 rot 2dup swap - >r min swap -text dup
 IF  rdrop  ELSE  drop r> sgn  THEN ;
: -text ( c_addr1 u c_addr2 -- n )
 swap bounds
 ?DO  dup c@ I c@ = WHILE  1+  LOOP  drop 0
 ELSE  c@ I c@ - unloop  THEN  sgn ;
: sgn ( n -- -1/0/1 )
 dup 0= IF EXIT THEN  0< 2* 1+ ;

\ -text is only used by replaced primitives now; move it elsewhere
\ -text	( c_addr1 u c_addr2 -- n )	new	dash_text
\ n = memcmp(c_addr1, c_addr2, u);
\ if (n<0)
\   n = -1;
\ else if (n>0)
\   n = 1;
\ :
\  swap bounds
\  ?DO  dup c@ I c@ = WHILE  1+  LOOP  drop 0
\  ELSE  c@ I c@ - unloop  THEN  sgn ;
\ : sgn ( n -- -1/0/1 )
\  dup 0= IF EXIT THEN  0< 2* 1+ ;

toupper	( c1 -- c2 )	gforth
""If @i{c1} is a lower-case character (in the current locale), @i{c2}
is the equivalent upper-case character. All other characters are unchanged.""
c2 = toupper(c1);
:
 dup [char] a - [ char z char a - 1 + ] Literal u<  bl and - ;

capscompare	( c_addr1 u1 c_addr2 u2 -- n )	gforth
""Compare two strings lexicographically. If they are equal, @i{n} is 0; if
the first string is smaller, @i{n} is -1; if the first string is larger, @i{n}
is 1. Currently this is based on the machine's character
comparison. In the future, this may change to consider the current
locale and its collation order.""
/* close ' to keep fontify happy */ 
n = capscompare(c_addr1, u1, c_addr2, u2);

/string	( c_addr1 u1 n -- c_addr2 u2 )	string	slash_string
""Adjust the string specified by @i{c-addr1, u1} to remove @i{n}
characters from the start of the string.""
c_addr2 = c_addr1+n;
u2 = u1-n;
:
 tuck - >r + r> dup 0< IF  - 0  THEN ;

\g arith

lit	( #w -- w )		gforth
:
 r> dup @ swap cell+ >r ;

+	( n1 n2 -- n )		core	plus
n = n1+n2;

\ lit+ / lit_plus = lit +

lit+	( n1 #n2 -- n )		new	lit_plus
#ifdef DEBUG
fprintf(stderr, "lit+ %08x\n", n2);
#endif
n=n1+n2;

\ PFE-0.9.14 has it differently, but the next release will have it as follows
under+	( n1 n2 n3 -- n n2 )	gforth	under_plus
""add @i{n3} to @i{n1} (giving @i{n})""
n = n1+n3;
:
 rot + swap ;

-	( n1 n2 -- n )		core	minus
n = n1-n2;
:
 negate + ;

negate	( n1 -- n2 )		core
/* use minus as alias */
n2 = -n1;
:
 invert 1+ ;

1+	( n1 -- n2 )		core		one_plus
n2 = n1+1;
:
 1 + ;

1-	( n1 -- n2 )		core		one_minus
n2 = n1-1;
:
 1 - ;

max	( n1 n2 -- n )	core
if (n1<n2)
  n = n2;
else
  n = n1;
:
 2dup < IF swap THEN drop ;

min	( n1 n2 -- n )	core
if (n1<n2)
  n = n1;
else
  n = n2;
:
 2dup > IF swap THEN drop ;

abs	( n -- u )	core
if (n<0)
  u = -n;
else
  u = n;
:
 dup 0< IF negate THEN ;

*	( n1 n2 -- n )		core	star
n = n1*n2;
:
 um* drop ;

/	( n1 n2 -- n )		core	slash
n = n1/n2;
if (CHECK_DIVISION_SW && n2 == 0)
  throw(BALL_DIVZERO);
if (CHECK_DIVISION_SW && n2 == -1 && n1 == CELL_MIN)
  throw(BALL_RESULTRANGE);
if (FLOORED_DIV && ((n1^n2) < 0) && (n1%n2 != 0))
  n--;
:
 /mod nip ;

mod	( n1 n2 -- n )		core
n = n1%n2;
if (CHECK_DIVISION_SW && n2 == 0)
  throw(BALL_DIVZERO);
if (CHECK_DIVISION_SW && n2 == -1 && n1 == CELL_MIN)
  throw(BALL_RESULTRANGE);
if(FLOORED_DIV && ((n1^n2) < 0) && n!=0) n += n2;
:
 /mod drop ;

/mod	( n1 n2 -- n3 n4 )		core		slash_mod
n4 = n1/n2;
n3 = n1%n2; /* !! is this correct? look into C standard! */
if (CHECK_DIVISION_SW && n2 == 0)
  throw(BALL_DIVZERO);
if (CHECK_DIVISION_SW && n2 == -1 && n1 == CELL_MIN)
  throw(BALL_RESULTRANGE);
if (FLOORED_DIV && ((n1^n2) < 0) && n3!=0) {
  n4--;
  n3+=n2;
}
:
 >r s>d r> fm/mod ;

*/mod	( n1 n2 n3 -- n4 n5 )	core	star_slash_mod
""n1*n2=n3*n5+n4, with the intermediate result (n1*n2) being double.""
#ifdef BUGGY_LL_MUL
DCell d = mmul(n1,n2);
#else
DCell d = (DCell)n1 * (DCell)n2;
#endif
#ifdef ASM_SM_SLASH_REM
ASM_SM_SLASH_REM(DLO(d), DHI(d), n3, n4, n5);
if (FLOORED_DIV && ((DHI(d)^n3)<0) && n4!=0) {
  if (CHECK_DIVISION && n5 == CELL_MIN)
    throw(BALL_RESULTRANGE);
  n5--;
  n4+=n3;
}
#else
DCell r = FLOORED_DIV ? fmdiv(d,n3) : smdiv(d,n3);
n4=DHI(r);
n5=DLO(r);
#endif
:
 >r m* r> fm/mod ;

*/	( n1 n2 n3 -- n4 )	core	star_slash
""n4=(n1*n2)/n3, with the intermediate result being double.""
#ifdef BUGGY_LL_MUL
DCell d = mmul(n1,n2);
#else
DCell d = (DCell)n1 * (DCell)n2;
#endif
#ifdef ASM_SM_SLASH_REM
Cell remainder;
ASM_SM_SLASH_REM(DLO(d), DHI(d), n3, remainder, n4);
if (FLOORED_DIV && ((DHI(d)^n3)<0) && remainder!=0) {
  if (CHECK_DIVISION && n4 == CELL_MIN)
    throw(BALL_RESULTRANGE);
  n4--;
}
#else
DCell r = FLOORED_DIV ? fmdiv(d,n3) : smdiv(d,n3);
n4=DLO(r);
#endif
:
 */mod nip ;

2*	( n1 -- n2 )		core		two_star
""Shift left by 1; also works on unsigned numbers""
n2 = 2*n1;
:
 dup + ;

2/	( n1 -- n2 )		core		two_slash
""Arithmetic shift right by 1.  For signed numbers this is a floored
division by 2 (note that @code{/} not necessarily floors).""
n2 = n1>>1;
:
 dup MINI and IF 1 ELSE 0 THEN
 [ bits/char cell * 1- ] literal 
 0 DO 2* swap dup 2* >r MINI and 
     IF 1 ELSE 0 THEN or r> swap
 LOOP nip ;

fm/mod	( d1 n1 -- n2 n3 )		core		f_m_slash_mod
""Floored division: @i{d1} = @i{n3}*@i{n1}+@i{n2}, @i{n1}>@i{n2}>=0 or 0>=@i{n2}>@i{n1}.""
#ifdef ASM_SM_SLASH_REM
ASM_SM_SLASH_REM(DLO(d1), DHI(d1), n1, n2, n3);
if (((DHI(d1)^n1)<0) && n2!=0) {
  if (CHECK_DIVISION && n3 == CELL_MIN)
    throw(BALL_RESULTRANGE);
  n3--;
  n2+=n1;
}
#else /* !defined(ASM_SM_SLASH_REM) */
DCell r = fmdiv(d1,n1);
n2=DHI(r);
n3=DLO(r);
#endif /* !defined(ASM_SM_SLASH_REM) */
:
 dup >r dup 0< IF  negate >r dnegate r>  THEN
 over       0< IF  tuck + swap  THEN
 um/mod
 r> 0< IF  swap negate swap  THEN ;

sm/rem	( d1 n1 -- n2 n3 )		core		s_m_slash_rem
""Symmetric division: @i{d1} = @i{n3}*@i{n1}+@i{n2}, sign(@i{n2})=sign(@i{d1}) or 0.""
#ifdef ASM_SM_SLASH_REM
ASM_SM_SLASH_REM(DLO(d1), DHI(d1), n1, n2, n3);
#else /* !defined(ASM_SM_SLASH_REM) */
DCell r = smdiv(d1,n1);
n2=DHI(r);
n3=DLO(r);
#endif /* !defined(ASM_SM_SLASH_REM) */
:
 over >r dup >r abs -rot
 dabs rot um/mod
 r> r@ xor 0< IF       negate       THEN
 r>        0< IF  swap negate swap  THEN ;

m*	( n1 n2 -- d )		core	m_star
#ifdef BUGGY_LL_MUL
d = mmul(n1,n2);
#else
d = (DCell)n1 * (DCell)n2;
#endif
:
 2dup      0< and >r
 2dup swap 0< and >r
 um* r> - r> - ;

um*	( u1 u2 -- ud )		core	u_m_star
/* use u* as alias */
#ifdef BUGGY_LL_MUL
ud = ummul(u1,u2);
#else
ud = (UDCell)u1 * (UDCell)u2;
#endif
:
   0 -rot dup [ 8 cells ] literal -
   DO
	dup 0< I' and d2*+ drop
   LOOP ;
: d2*+ ( ud n -- ud+n c )
   over MINI
   and >r >r 2dup d+ swap r> + swap r> ;

um/mod	( ud u1 -- u2 u3 )		core	u_m_slash_mod
""ud=u3*u1+u2, u1>u2>=0""
#ifdef ASM_UM_SLASH_MOD
ASM_UM_SLASH_MOD(DLO(ud), DHI(ud), u1, u2, u3);
#else /* !defined(ASM_UM_SLASH_MOD) */
UDCell r = umdiv(ud,u1);
u2=DHI(r);
u3=DLO(r);
#endif /* !defined(ASM_UM_SLASH_MOD) */
:
   0 swap [ 8 cells 1 + ] literal 0
   ?DO /modstep
   LOOP drop swap 1 rshift or swap ;
: /modstep ( ud c R: u -- ud-?u c R: u )
   >r over r@ u< 0= or IF r@ - 1 ELSE 0 THEN  d2*+ r> ;
: d2*+ ( ud n -- ud+n c )
   over MINI
   and >r >r 2dup d+ swap r> + swap r> ;

m+	( d1 n -- d2 )		double		m_plus
#ifdef BUGGY_LL_ADD
DLO_IS(d2, DLO(d1)+n);
DHI_IS(d2, DHI(d1) - (n<0) + (DLO(d2)<DLO(d1)));
#else
d2 = d1+n;
#endif
:
 s>d d+ ;

d+	( d1 d2 -- d )		double	d_plus
#ifdef BUGGY_LL_ADD
DLO_IS(d, DLO(d1) + DLO(d2));
DHI_IS(d, DHI(d1) + DHI(d2) + (d.lo<DLO(d1)));
#else
d = d1+d2;
#endif
:
 rot + >r tuck + swap over u> r> swap - ;

d-	( d1 d2 -- d )		double		d_minus
#ifdef BUGGY_LL_ADD
DLO_IS(d, DLO(d1) - DLO(d2));
DHI_IS(d, DHI(d1)-DHI(d2)-(DLO(d1)<DLO(d2)));
#else
d = d1-d2;
#endif
:
 dnegate d+ ;

dnegate	( d1 -- d2 )		double	d_negate
/* use dminus as alias */
#ifdef BUGGY_LL_ADD
d2 = dnegate(d1);
#else
d2 = -d1;
#endif
:
 invert swap negate tuck 0= - ;

d2*	( d1 -- d2 )		double		d_two_star
""Shift left by 1; also works on unsigned numbers""
d2 = DLSHIFT(d1,1);
:
 2dup d+ ;

d2/	( d1 -- d2 )		double		d_two_slash
""Arithmetic shift right by 1.  For signed numbers this is a floored
division by 2.""
#ifdef BUGGY_LL_SHIFT
DHI_IS(d2, DHI(d1)>>1);
DLO_IS(d2, (DLO(d1)>>1) | (DHI(d1)<<(CELL_BITS-1)));
#else
d2 = d1>>1;
#endif
:
 dup 1 and >r 2/ swap 2/ [ 1 8 cells 1- lshift 1- ] Literal and
 r> IF  [ 1 8 cells 1- lshift ] Literal + THEN  swap ;

and	( w1 w2 -- w )		core
w = w1&w2;

or	( w1 w2 -- w )		core
w = w1|w2;
:
 invert swap invert and invert ;

xor	( w1 w2 -- w )		core	x_or
w = w1^w2;

invert	( w1 -- w2 )		core
w2 = ~w1;
:
 MAXU xor ;

rshift	( u1 n -- u2 )		core	r_shift
""Logical shift right by @i{n} bits.""
#ifdef BROKEN_SHIFT
  u2 = rshift(u1, n);
#else
  u2 = u1 >> n;
#endif
:
    0 ?DO 2/ MAXI and LOOP ;

lshift	( u1 n -- u2 )		core	l_shift
#ifdef BROKEN_SHIFT
  u2 = lshift(u1, n);
#else
  u2 = u1 << n;
#endif
:
    0 ?DO 2* LOOP ;

\g compare

\ comparisons(prefix, args, prefix, arg1, arg2, wordsets...)
#line 1120


0=	( n -- f )		core	zero_equals
#line 1122
f = FLAG(n==0);
#line 1122
:
#line 1122
    [ char 0x char 0 = [IF]
#line 1122
	] IF false ELSE true THEN [
#line 1122
    [ELSE]
#line 1122
	] xor 0= [
#line 1122
    [THEN] ] ;
#line 1122

#line 1122
0<>	( n -- f )		core-ext	zero_not_equals
#line 1122
f = FLAG(n!=0);
#line 1122
:
#line 1122
    [ char 0x char 0 = [IF]
#line 1122
	] IF true ELSE false THEN [
#line 1122
    [ELSE]
#line 1122
	] xor 0<> [
#line 1122
    [THEN] ] ;
#line 1122

#line 1122
0<	( n -- f )		core	zero_less_than
#line 1122
f = FLAG(n<0);
#line 1122
:
#line 1122
    [ char 0x char 0 = [IF]
#line 1122
	] MINI and 0<> [
#line 1122
    [ELSE] char 0x char u = [IF]
#line 1122
	]   2dup xor 0<  IF nip ELSE - THEN 0<  [
#line 1122
	[ELSE]
#line 1122
	    ] MINI xor >r MINI xor r> u< [
#line 1122
	[THEN]
#line 1122
    [THEN] ] ;
#line 1122

#line 1122
0>	( n -- f )		core-ext	zero_greater_than
#line 1122
f = FLAG(n>0);
#line 1122
:
#line 1122
    [ char 0x char 0 = [IF] ] negate [ [ELSE] ] swap [ [THEN] ]
#line 1122
    0< ;
#line 1122

#line 1122
0<=	( n -- f )		gforth	zero_less_or_equal
#line 1122
f = FLAG(n<=0);
#line 1122
:
#line 1122
    0> 0= ;
#line 1122

#line 1122
0>=	( n -- f )		gforth	zero_greater_or_equal
#line 1122
f = FLAG(n>=0);
#line 1122
:
#line 1122
    [ char 0x char 0 = [IF] ] negate [ [ELSE] ] swap [ [THEN] ]
#line 1122
    0<= ;
#line 1122

#line 1122

=	( n1 n2 -- f )		core	equals
#line 1123
f = FLAG(n1==n2);
#line 1123
:
#line 1123
    [ char x char 0 = [IF]
#line 1123
	] IF false ELSE true THEN [
#line 1123
    [ELSE]
#line 1123
	] xor 0= [
#line 1123
    [THEN] ] ;
#line 1123

#line 1123
<>	( n1 n2 -- f )		core-ext	not_equals
#line 1123
f = FLAG(n1!=n2);
#line 1123
:
#line 1123
    [ char x char 0 = [IF]
#line 1123
	] IF true ELSE false THEN [
#line 1123
    [ELSE]
#line 1123
	] xor 0<> [
#line 1123
    [THEN] ] ;
#line 1123

#line 1123
<	( n1 n2 -- f )		core	less_than
#line 1123
f = FLAG(n1<n2);
#line 1123
:
#line 1123
    [ char x char 0 = [IF]
#line 1123
	] MINI and 0<> [
#line 1123
    [ELSE] char x char u = [IF]
#line 1123
	]   2dup xor 0<  IF nip ELSE - THEN 0<  [
#line 1123
	[ELSE]
#line 1123
	    ] MINI xor >r MINI xor r> u< [
#line 1123
	[THEN]
#line 1123
    [THEN] ] ;
#line 1123

#line 1123
>	( n1 n2 -- f )		core	greater_than
#line 1123
f = FLAG(n1>n2);
#line 1123
:
#line 1123
    [ char x char 0 = [IF] ] negate [ [ELSE] ] swap [ [THEN] ]
#line 1123
    < ;
#line 1123

#line 1123
<=	( n1 n2 -- f )		gforth	less_or_equal
#line 1123
f = FLAG(n1<=n2);
#line 1123
:
#line 1123
    > 0= ;
#line 1123

#line 1123
>=	( n1 n2 -- f )		gforth	greater_or_equal
#line 1123
f = FLAG(n1>=n2);
#line 1123
:
#line 1123
    [ char x char 0 = [IF] ] negate [ [ELSE] ] swap [ [THEN] ]
#line 1123
    <= ;
#line 1123

#line 1123

u=	( u1 u2 -- f )		gforth	u_equals
#line 1124
f = FLAG(u1==u2);
#line 1124
:
#line 1124
    [ char ux char 0 = [IF]
#line 1124
	] IF false ELSE true THEN [
#line 1124
    [ELSE]
#line 1124
	] xor 0= [
#line 1124
    [THEN] ] ;
#line 1124

#line 1124
u<>	( u1 u2 -- f )		gforth	u_not_equals
#line 1124
f = FLAG(u1!=u2);
#line 1124
:
#line 1124
    [ char ux char 0 = [IF]
#line 1124
	] IF true ELSE false THEN [
#line 1124
    [ELSE]
#line 1124
	] xor 0<> [
#line 1124
    [THEN] ] ;
#line 1124

#line 1124
u<	( u1 u2 -- f )		core	u_less_than
#line 1124
f = FLAG(u1<u2);
#line 1124
:
#line 1124
    [ char ux char 0 = [IF]
#line 1124
	] MINI and 0<> [
#line 1124
    [ELSE] char ux char u = [IF]
#line 1124
	]   2dup xor 0<  IF nip ELSE - THEN 0<  [
#line 1124
	[ELSE]
#line 1124
	    ] MINI xor >r MINI xor r> u< [
#line 1124
	[THEN]
#line 1124
    [THEN] ] ;
#line 1124

#line 1124
u>	( u1 u2 -- f )		core-ext	u_greater_than
#line 1124
f = FLAG(u1>u2);
#line 1124
:
#line 1124
    [ char ux char 0 = [IF] ] negate [ [ELSE] ] swap [ [THEN] ]
#line 1124
    u< ;
#line 1124

#line 1124
u<=	( u1 u2 -- f )		gforth	u_less_or_equal
#line 1124
f = FLAG(u1<=u2);
#line 1124
:
#line 1124
    u> 0= ;
#line 1124

#line 1124
u>=	( u1 u2 -- f )		gforth	u_greater_or_equal
#line 1124
f = FLAG(u1>=u2);
#line 1124
:
#line 1124
    [ char ux char 0 = [IF] ] negate [ [ELSE] ] swap [ [THEN] ]
#line 1124
    u<= ;
#line 1124

#line 1124


\ dcomparisons(prefix, args, prefix, arg1, arg2, wordsets...)
#line 1170


\+dcomps

d=	( d1 d2 -- f )		double	d_equals
#line 1174
#ifdef BUGGY_LL_CMP
#line 1174
f = FLAG(d1.lo==d2.lo && d1.hi==d2.hi);
#line 1174
#else
#line 1174
f = FLAG(d1==d2);
#line 1174
#endif
#line 1174

#line 1174
d<>	( d1 d2 -- f )		gforth	d_not_equals
#line 1174
#ifdef BUGGY_LL_CMP
#line 1174
f = FLAG(d1.lo!=d2.lo || d1.hi!=d2.hi);
#line 1174
#else
#line 1174
f = FLAG(d1!=d2);
#line 1174
#endif
#line 1174

#line 1174
d<	( d1 d2 -- f )		double	d_less_than
#line 1174
#ifdef BUGGY_LL_CMP
#line 1174
f = FLAG(d1.hi==d2.hi ? d1.lo<d2.lo : d1.hi<d2.hi);
#line 1174
#else
#line 1174
f = FLAG(d1<d2);
#line 1174
#endif
#line 1174

#line 1174
d>	( d1 d2 -- f )		gforth	d_greater_than
#line 1174
#ifdef BUGGY_LL_CMP
#line 1174
f = FLAG(d1.hi==d2.hi ? d1.lo>d2.lo : d1.hi>d2.hi);
#line 1174
#else
#line 1174
f = FLAG(d1>d2);
#line 1174
#endif
#line 1174

#line 1174
d<=	( d1 d2 -- f )		gforth	d_less_or_equal
#line 1174
#ifdef BUGGY_LL_CMP
#line 1174
f = FLAG(d1.hi==d2.hi ? d1.lo<=d2.lo : d1.hi<=d2.hi);
#line 1174
#else
#line 1174
f = FLAG(d1<=d2);
#line 1174
#endif
#line 1174

#line 1174
d>=	( d1 d2 -- f )		gforth	d_greater_or_equal
#line 1174
#ifdef BUGGY_LL_CMP
#line 1174
f = FLAG(d1.hi==d2.hi ? d1.lo>=d2.lo : d1.hi>=d2.hi);
#line 1174
#else
#line 1174
f = FLAG(d1>=d2);
#line 1174
#endif
#line 1174

#line 1174

d0=	( d -- f )		double	d_zero_equals
#line 1175
#ifdef BUGGY_LL_CMP
#line 1175
f = FLAG(d.lo==DZERO.lo && d.hi==DZERO.hi);
#line 1175
#else
#line 1175
f = FLAG(d==DZERO);
#line 1175
#endif
#line 1175

#line 1175
d0<>	( d -- f )		gforth	d_zero_not_equals
#line 1175
#ifdef BUGGY_LL_CMP
#line 1175
f = FLAG(d.lo!=DZERO.lo || d.hi!=DZERO.hi);
#line 1175
#else
#line 1175
f = FLAG(d!=DZERO);
#line 1175
#endif
#line 1175

#line 1175
d0<	( d -- f )		double	d_zero_less_than
#line 1175
#ifdef BUGGY_LL_CMP
#line 1175
f = FLAG(d.hi==DZERO.hi ? d.lo<DZERO.lo : d.hi<DZERO.hi);
#line 1175
#else
#line 1175
f = FLAG(d<DZERO);
#line 1175
#endif
#line 1175

#line 1175
d0>	( d -- f )		gforth	d_zero_greater_than
#line 1175
#ifdef BUGGY_LL_CMP
#line 1175
f = FLAG(d.hi==DZERO.hi ? d.lo>DZERO.lo : d.hi>DZERO.hi);
#line 1175
#else
#line 1175
f = FLAG(d>DZERO);
#line 1175
#endif
#line 1175

#line 1175
d0<=	( d -- f )		gforth	d_zero_less_or_equal
#line 1175
#ifdef BUGGY_LL_CMP
#line 1175
f = FLAG(d.hi==DZERO.hi ? d.lo<=DZERO.lo : d.hi<=DZERO.hi);
#line 1175
#else
#line 1175
f = FLAG(d<=DZERO);
#line 1175
#endif
#line 1175

#line 1175
d0>=	( d -- f )		gforth	d_zero_greater_or_equal
#line 1175
#ifdef BUGGY_LL_CMP
#line 1175
f = FLAG(d.hi==DZERO.hi ? d.lo>=DZERO.lo : d.hi>=DZERO.hi);
#line 1175
#else
#line 1175
f = FLAG(d>=DZERO);
#line 1175
#endif
#line 1175

#line 1175

du=	( ud1 ud2 -- f )		gforth	d_u_equals
#line 1176
#ifdef BUGGY_LL_CMP
#line 1176
f = FLAG(ud1.lo==ud2.lo && ud1.hi==ud2.hi);
#line 1176
#else
#line 1176
f = FLAG(ud1==ud2);
#line 1176
#endif
#line 1176

#line 1176
du<>	( ud1 ud2 -- f )		gforth	d_u_not_equals
#line 1176
#ifdef BUGGY_LL_CMP
#line 1176
f = FLAG(ud1.lo!=ud2.lo || ud1.hi!=ud2.hi);
#line 1176
#else
#line 1176
f = FLAG(ud1!=ud2);
#line 1176
#endif
#line 1176

#line 1176
du<	( ud1 ud2 -- f )		double-ext	d_u_less_than
#line 1176
#ifdef BUGGY_LL_CMP
#line 1176
f = FLAG(ud1.hi==ud2.hi ? ud1.lo<ud2.lo : ud1.hi<ud2.hi);
#line 1176
#else
#line 1176
f = FLAG(ud1<ud2);
#line 1176
#endif
#line 1176

#line 1176
du>	( ud1 ud2 -- f )		gforth	d_u_greater_than
#line 1176
#ifdef BUGGY_LL_CMP
#line 1176
f = FLAG(ud1.hi==ud2.hi ? ud1.lo>ud2.lo : ud1.hi>ud2.hi);
#line 1176
#else
#line 1176
f = FLAG(ud1>ud2);
#line 1176
#endif
#line 1176

#line 1176
du<=	( ud1 ud2 -- f )		gforth	d_u_less_or_equal
#line 1176
#ifdef BUGGY_LL_CMP
#line 1176
f = FLAG(ud1.hi==ud2.hi ? ud1.lo<=ud2.lo : ud1.hi<=ud2.hi);
#line 1176
#else
#line 1176
f = FLAG(ud1<=ud2);
#line 1176
#endif
#line 1176

#line 1176
du>=	( ud1 ud2 -- f )		gforth	d_u_greater_or_equal
#line 1176
#ifdef BUGGY_LL_CMP
#line 1176
f = FLAG(ud1.hi==ud2.hi ? ud1.lo>=ud2.lo : ud1.hi>=ud2.hi);
#line 1176
#else
#line 1176
f = FLAG(ud1>=ud2);
#line 1176
#endif
#line 1176

#line 1176


\+

within	( u1 u2 u3 -- f )		core-ext
""u2=<u1<u3 or: u3=<u2 and u1 is not in [u3,u2).  This works for
unsigned and signed numbers (but not a mixture).  Another way to think
about this word is to consider the numbers as a circle (wrapping
around from @code{max-u} to 0 for unsigned, and from @code{max-n} to
min-n for signed numbers); now consider the range from u2 towards
increasing numbers up to and excluding u3 (giving an empty range if
u2=u3); if u1 is in this range, @code{within} returns true.""
f = FLAG(u1-u2 < u3-u2);
:
 over - >r - r> u< ;

\g stack

useraddr	( #u -- a_addr )	new
a_addr = (Cell *)(up+u);

up!	( a_addr -- )	gforth	up_store
gforth_UP=up=(Address)a_addr;
:
 up ! ;
Variable UP

sp@	( S:... -- a_addr )		gforth		sp_fetch
a_addr = sp;

sp!	( a_addr -- S:... )		gforth		sp_store
sp = a_addr;

rp@	( -- a_addr )		gforth		rp_fetch
a_addr = rp;

rp!	( a_addr -- )		gforth		rp_store
rp = a_addr;

\+floating

fp@	( f:... -- f_addr )	gforth	fp_fetch
f_addr = fp;

fp!	( f_addr -- f:... )	gforth	fp_store
fp = f_addr;

\+

>r	( w -- R:w )		core	to_r
:
 (>r) ;
: (>r)  rp@ cell+ @ rp@ ! rp@ cell+ ! ;

r>	( R:w -- w )		core	r_from
:
 rp@ cell+ @ rp@ @ rp@ cell+ ! (rdrop) rp@ ! ;
Create (rdrop) ' ;s A,

rdrop	( R:w -- )		gforth
:
 r> r> drop >r ;

2>r	( d -- R:d )	core-ext	two_to_r
:
 swap r> swap >r swap >r >r ;

2r>	( R:d -- d )	core-ext	two_r_from
:
 r> r> swap r> swap >r swap ;

2r@	( R:d -- R:d d )	core-ext	two_r_fetch
:
 i' j ;

2rdrop	( R:d -- )		gforth	two_r_drop
:
 r> r> drop r> drop >r ;

over	( w1 w2 -- w1 w2 w1 )		core
:
 sp@ cell+ @ ;

drop	( w -- )		core
:
 IF THEN ;

swap	( w1 w2 -- w2 w1 )		core
:
 >r (swap) ! r> (swap) @ ;
Variable (swap)

dup	( w -- w w )		core	dupe
:
 sp@ @ ;

rot	( w1 w2 w3 -- w2 w3 w1 )	core	rote
:
[ defined? (swap) [IF] ]
    (swap) ! (rot) ! >r (rot) @ (swap) @ r> ;
Variable (rot)
[ELSE] ]
    >r swap r> swap ;
[THEN]

-rot	( w1 w2 w3 -- w3 w1 w2 )	gforth	not_rote
:
 rot rot ;

nip	( w1 w2 -- w2 )		core-ext
:
 swap drop ;

tuck	( w1 w2 -- w2 w1 w2 )	core-ext
:
 swap over ;

?dup	( w -- S:... w )	core	question_dupe
""Actually the stack effect is: @code{( w -- 0 | w w )}.  It performs a
@code{dup} if w is nonzero.""
if (w!=0) {
  *--sp = w;
}
:
 dup IF dup THEN ;

pick	( S:... u -- S:... w )		core-ext
""Actually the stack effect is @code{ x0 ... xu u -- x0 ... xu x0 }.""
w = sp[u];
:
 1+ cells sp@ + @ ;

2drop	( w1 w2 -- )		core	two_drop
:
 drop drop ;

2dup	( w1 w2 -- w1 w2 w1 w2 )	core	two_dupe
:
 over over ;

2over	( w1 w2 w3 w4 -- w1 w2 w3 w4 w1 w2 )	core	two_over
:
 3 pick 3 pick ;

2swap	( w1 w2 w3 w4 -- w3 w4 w1 w2 )	core	two_swap
:
 rot >r rot r> ;

2rot	( w1 w2 w3 w4 w5 w6 -- w3 w4 w5 w6 w1 w2 )	double-ext	two_rote
:
 >r >r 2swap r> r> 2swap ;

2nip	( w1 w2 w3 w4 -- w3 w4 )	gforth	two_nip
:
 2swap 2drop ;

2tuck	( w1 w2 w3 w4 -- w3 w4 w1 w2 w3 w4 )	gforth	two_tuck
:
 2swap 2over ;

\ toggle is high-level: 0.11/0.42%

\g memory

@	( a_addr -- w )		core	fetch
""@i{w} is the cell stored at @i{a_addr}.""
w = *a_addr;

\ lit@ / lit_fetch = lit @

lit@		( #a_addr -- w ) new	lit_fetch
w = *a_addr;

!	( w a_addr -- )		core	store
""Store @i{w} into the cell at @i{a-addr}.""
*a_addr = w;

+!	( n a_addr -- )		core	plus_store
""Add @i{n} to the cell at @i{a-addr}.""
*a_addr += n;
:
 tuck @ + swap ! ;

c@	( c_addr -- c )		core	c_fetch
""@i{c} is the char stored at @i{c_addr}.""
c = *c_addr;
:
[ bigendian [IF] ]
    [ cell>bit 4 = [IF] ]
	dup [ 0 cell - ] Literal and @ swap 1 and
	IF  $FF and  ELSE  8>>  THEN  ;
    [ [ELSE] ]
	dup [ cell 1- ] literal and
	tuck - @ swap [ cell 1- ] literal xor
 	0 ?DO 8>> LOOP $FF and
    [ [THEN] ]
[ [ELSE] ]
    [ cell>bit 4 = [IF] ]
	dup [ 0 cell - ] Literal and @ swap 1 and
	IF  8>>  ELSE  $FF and  THEN
    [ [ELSE] ]
	dup [ cell  1- ] literal and 
	tuck - @ swap
	0 ?DO 8>> LOOP 255 and
    [ [THEN] ]
[ [THEN] ]
;
: 8>> 2/ 2/ 2/ 2/  2/ 2/ 2/ 2/ ;

c!	( c c_addr -- )		core	c_store
""Store @i{c} into the char at @i{c-addr}.""
*c_addr = c;
:
[ bigendian [IF] ]
    [ cell>bit 4 = [IF] ]
	tuck 1 and IF  $FF and  ELSE  8<<  THEN >r
	dup -2 and @ over 1 and cells masks + @ and
	r> or swap -2 and ! ;
	Create masks $00FF , $FF00 ,
    [ELSE] ]
	dup [ cell 1- ] literal and dup 
	[ cell 1- ] literal xor >r
	- dup @ $FF r@ 0 ?DO 8<< LOOP invert and
	rot $FF and r> 0 ?DO 8<< LOOP or swap ! ;
    [THEN]
[ELSE] ]
    [ cell>bit 4 = [IF] ]
	tuck 1 and IF  8<<  ELSE  $FF and  THEN >r
	dup -2 and @ over 1 and cells masks + @ and
	r> or swap -2 and ! ;
	Create masks $FF00 , $00FF ,
    [ELSE] ]
	dup [ cell 1- ] literal and dup >r
	- dup @ $FF r@ 0 ?DO 8<< LOOP invert and
	rot $FF and r> 0 ?DO 8<< LOOP or swap ! ;
    [THEN]
[THEN]
: 8<< 2* 2* 2* 2*  2* 2* 2* 2* ;

2!	( w1 w2 a_addr -- )		core	two_store
""Store @i{w2} into the cell at @i{c-addr} and @i{w1} into the next cell.""
a_addr[0] = w2;
a_addr[1] = w1;
:
 tuck ! cell+ ! ;

2@	( a_addr -- w1 w2 )		core	two_fetch
""@i{w2} is the content of the cell stored at @i{a-addr}, @i{w1} is
the content of the next cell.""
w2 = a_addr[0];
w1 = a_addr[1];
:
 dup cell+ @ swap @ ;

cell+	( a_addr1 -- a_addr2 )	core	cell_plus
""@code{1 cells +}""
a_addr2 = a_addr1+1;
:
 cell + ;

cells	( n1 -- n2 )		core
"" @i{n2} is the number of address units of @i{n1} cells.""
n2 = n1 * sizeof(Cell);
:
 [ cell
 2/ dup [IF] ] 2* [ [THEN]
 2/ dup [IF] ] 2* [ [THEN]
 2/ dup [IF] ] 2* [ [THEN]
 2/ dup [IF] ] 2* [ [THEN]
 drop ] ;

char+	( c_addr1 -- c_addr2 )	core	char_plus
""@code{1 chars +}.""
c_addr2 = c_addr1 + 1;
:
 1+ ;

(chars)	( n1 -- n2 )	gforth	paren_chars
n2 = n1 * sizeof(Char);
:
 ;

count	( c_addr1 -- c_addr2 u )	core
""@i{c-addr2} is the first character and @i{u} the length of the
counted string at @i{c-addr1}.""
u = *c_addr1;
c_addr2 = c_addr1+1;
:
 dup 1+ swap c@ ;

\g compiler

\+f83headerstring

(f83find)	( c_addr u f83name1 -- f83name2 )	new	paren_f83find
for (; f83name1 != NULL; f83name1 = (struct F83Name *)(f83name1->next))
  if ((UCell)F83NAME_COUNT(f83name1)==u &&
      memcasecmp(c_addr, f83name1->name, u)== 0 /* or inline? */)
    break;
f83name2=f83name1;
#ifdef DEBUG
fprintf(stderr, "F83find ");
fwrite(c_addr, u, 1, stderr);
fprintf(stderr, " found %08x\n", f83name2); 
#endif
:
    BEGIN  dup WHILE  (find-samelen)  dup  WHILE
	>r 2dup r@ cell+ char+ capscomp  0=
	IF  2drop r>  EXIT  THEN
	r> @
    REPEAT  THEN  nip nip ;
: (find-samelen) ( u f83name1 -- u f83name2/0 )
    BEGIN  2dup cell+ c@ $1F and <> WHILE  @  dup 0= UNTIL  THEN ;
: capscomp ( c_addr1 u c_addr2 -- n )
 swap bounds
 ?DO  dup c@ I c@ <>
     IF  dup c@ toupper I c@ toupper =
     ELSE  true  THEN  WHILE  1+  LOOP  drop 0
 ELSE  c@ toupper I c@ toupper - unloop  THEN  sgn ;
: sgn ( n -- -1/0/1 )
 dup 0= IF EXIT THEN  0< 2* 1+ ;

\-

(listlfind)	( c_addr u longname1 -- longname2 )	new	paren_listlfind
longname2=listlfind(c_addr, u, longname1);
:
    BEGIN  dup WHILE  (findl-samelen)  dup  WHILE
	>r 2dup r@ cell+ cell+ capscomp  0=
	IF  2drop r>  EXIT  THEN
	r> @
    REPEAT  THEN  nip nip ;
: (findl-samelen) ( u longname1 -- u longname2/0 )
    BEGIN  2dup cell+ @ lcount-mask and <> WHILE  @  dup 0= UNTIL  THEN ;
: capscomp ( c_addr1 u c_addr2 -- n )
 swap bounds
 ?DO  dup c@ I c@ <>
     IF  dup c@ toupper I c@ toupper =
     ELSE  true  THEN  WHILE  1+  LOOP  drop 0
 ELSE  c@ toupper I c@ toupper - unloop  THEN  sgn ;
: sgn ( n -- -1/0/1 )
 dup 0= IF EXIT THEN  0< 2* 1+ ;

\+hash

(hashlfind)	( c_addr u a_addr -- longname2 )	new	paren_hashlfind
longname2 = hashlfind(c_addr, u, a_addr);
:
 BEGIN  dup  WHILE
        2@ >r >r dup r@ cell+ @ lcount-mask and =
        IF  2dup r@ cell+ cell+ capscomp 0=
	    IF  2drop r> rdrop  EXIT  THEN  THEN
	rdrop r>
 REPEAT nip nip ;

(tablelfind)	( c_addr u a_addr -- longname2 )	new	paren_tablelfind
""A case-sensitive variant of @code{(hashfind)}""
longname2 = tablelfind(c_addr, u, a_addr);
:
 BEGIN  dup  WHILE
        2@ >r >r dup r@ cell+ @ lcount-mask and =
        IF  2dup r@ cell+ cell+ -text 0=
	    IF  2drop r> rdrop  EXIT  THEN  THEN
	rdrop r>
 REPEAT nip nip ;
: -text ( c_addr1 u c_addr2 -- n )
 swap bounds
 ?DO  dup c@ I c@ = WHILE  1+  LOOP  drop 0
 ELSE  c@ I c@ - unloop  THEN  sgn ;
: sgn ( n -- -1/0/1 )
 dup 0= IF EXIT THEN  0< 2* 1+ ;

(hashkey1)	( c_addr u ubits -- ukey )		gforth	paren_hashkey1
""ukey is the hash key for the string c_addr u fitting in ubits bits""
ukey = hashkey1(c_addr, u, ubits);
:
 dup rot-values + c@ over 1 swap lshift 1- >r
 tuck - 2swap r> 0 2swap bounds
 ?DO  dup 4 pick lshift swap 3 pick rshift or
      I c@ toupper xor
      over and  LOOP
 nip nip nip ;
Create rot-values
  5 c, 0 c, 1 c, 2 c, 3 c,  4 c, 5 c, 5 c, 5 c, 5 c,
  3 c, 5 c, 5 c, 5 c, 5 c,  7 c, 5 c, 5 c, 5 c, 5 c,
  7 c, 5 c, 5 c, 5 c, 5 c,  6 c, 5 c, 5 c, 5 c, 5 c,
  7 c, 5 c, 5 c,

\+

\+

(parse-white)	( c_addr1 u1 -- c_addr2 u2 )	gforth	paren_parse_white
struct Cellpair r=parse_white(c_addr1, u1);
c_addr2 = (Char *)(r.n1);
u2 = r.n2;
:
 BEGIN  dup  WHILE  over c@ bl <=  WHILE  1 /string
 REPEAT  THEN  2dup
 BEGIN  dup  WHILE  over c@ bl >   WHILE  1 /string
 REPEAT  THEN  nip - ;

aligned	( c_addr -- a_addr )	core
"" @i{a-addr} is the first aligned address greater than or equal to @i{c-addr}.""
a_addr = (Cell *)((((Cell)c_addr)+(sizeof(Cell)-1))&(-sizeof(Cell)));
:
 [ cell 1- ] Literal + [ -1 cells ] Literal and ;

faligned	( c_addr -- f_addr )	float	f_aligned
"" @i{f-addr} is the first float-aligned address greater than or equal to @i{c-addr}.""
f_addr = (Float *)((((Cell)c_addr)+(sizeof(Float)-1))&(-sizeof(Float)));
:
 [ 1 floats 1- ] Literal + [ -1 floats ] Literal and ;

\ threading stuff is currently only interesting if we have a compiler
\fhas? standardthreading has? compiler and [IF]
threading-method	( -- n )	gforth	threading_method
""0 if the engine is direct threaded. Note that this may change during
the lifetime of an image.""
#if defined(DOUBLY_INDIRECT)
n=2;
#else
# if defined(DIRECT_THREADED)
n=0;
# else
n=1;
# endif
#endif
:
 1 ;

\f[THEN]

\g hostos

key-file	( wfileid -- c )		gforth	paren_key_file
""Read one character @i{c} from @i{wfileid}.  This word disables
buffering for @i{wfileid}.  If you want to read characters from a
terminal in non-canonical (raw) mode, you have to put the terminal in
non-canonical mode yourself (using the C interface); the exception is
@code{stdin}: Gforth automatically puts it into non-canonical mode.""
#ifdef HAS_FILE
fflush(stdout);
c = key((FILE*)wfileid);
#else
c = key(stdin);
#endif

key?-file	( wfileid -- f )	        gforth	key_q_file
""@i{f} is true if at least one character can be read from @i{wfileid}
without blocking.  If you also want to use @code{read-file} or
@code{read-line} on the file, you have to call @code{key?-file} or
@code{key-file} first (these two words disable buffering).""
#ifdef HAS_FILE
fflush(stdout);
f = key_query((FILE*)wfileid);
#else
f = key_query(stdin);
#endif

stdin	( -- wfileid )	gforth
""The standard input file of the Gforth process.""
wfileid = (Cell)stdin;

stdout	( -- wfileid )	gforth
""The standard output file of the Gforth process.""
wfileid = (Cell)stdout;

stderr	( -- wfileid )	gforth
""The standard error output file of the Gforth process.""
wfileid = (Cell)stderr;

\+os

form	( -- urows ucols )	gforth
""The number of lines and columns in the terminal. These numbers may
change with the window size.  Note that it depends on the OS whether
this reflects the actual size and changes with the window size
(currently only on Unix-like OSs).  On other OSs you just get a
default, and can tell Gforth the terminal size by setting the
environment variables @code{COLUMNS} and @code{LINES} before starting
Gforth.""
/* we could block SIGWINCH here to get a consistent size, but I don't
 think this is necessary or always beneficial */
urows=rows;
ucols=cols;

wcwidth	( u -- n )	gforth
""The number of fixed-width characters per unicode character u""
#ifdef HAVE_WCWIDTH
n = wcwidth(u);
#else
n = 1;
#endif

flush-icache	( c_addr u -- )	gforth	flush_icache
""Make sure that the instruction cache of the processor (if there is
one) does not contain stale data at @i{c-addr} and @i{u} bytes
afterwards. @code{END-CODE} performs a @code{flush-icache}
automatically. Caveat: @code{flush-icache} might not work on your
installation; this is usually the case if direct threading is not
supported on your machine (take a look at your @file{machine.h}) and
your machine has a separate instruction cache. In such cases,
@code{flush-icache} does nothing instead of flushing the instruction
cache.""
FLUSH_ICACHE((caddr_t)c_addr,u);

(bye)	( n -- )	gforth	paren_bye
SUPER_END;
return (Label *)n;

(system)	( c_addr u -- wretval wior )	gforth	paren_system
wretval = gforth_system(c_addr, u);  
wior = IOR(wretval==-1 || (wretval==127 && errno != 0));

getenv	( c_addr1 u1 -- c_addr2 u2 )	gforth
""The string @i{c-addr1 u1} specifies an environment variable. The string @i{c-addr2 u2}
is the host operating system's expansion of that environment variable. If the
environment variable does not exist, @i{c-addr2 u2} specifies a string 0 characters
in length.""
/* close ' to keep fontify happy */
c_addr2 = (Char *)getenv(cstr(c_addr1,u1,1));
u2 = (c_addr2 == NULL ? 0 : strlen((char *)c_addr2));

open-pipe	( c_addr u wfam -- wfileid wior )	gforth	open_pipe
wfileid=(Cell)popen(cstr(c_addr,u,1),pfileattr[wfam]); /* ~ expansion of 1st arg? */
wior = IOR(wfileid==0); /* !! the man page says that errno is not set reliably */

close-pipe	( wfileid -- wretval wior )		gforth	close_pipe
wretval = pclose((FILE *)wfileid);
wior = IOR(wretval==-1);

time&date	( -- nsec nmin nhour nday nmonth nyear )	facility-ext	time_and_date
""Report the current time of day. Seconds, minutes and hours are numbered from 0.
Months are numbered from 1.""
#if 1
time_t now;
struct tm *ltime;
time(&now);
ltime=localtime(&now);
#else
struct timeval time1;
struct timezone zone1;
struct tm *ltime;
gettimeofday(&time1,&zone1);
/* !! Single Unix specification: 
   If tzp is not a null pointer, the behaviour is unspecified. */
ltime=localtime((time_t *)&time1.tv_sec);
#endif
nyear =ltime->tm_year+1900;
nmonth=ltime->tm_mon+1;
nday  =ltime->tm_mday;
nhour =ltime->tm_hour;
nmin  =ltime->tm_min;
nsec  =ltime->tm_sec;

ms	( u -- )	facility-ext
""Wait at least @i{n} milli-second.""
gforth_ms(u);

allocate	( u -- a_addr wior )	memory
""Allocate @i{u} address units of contiguous data space. The initial
contents of the data space is undefined. If the allocation is successful,
@i{a-addr} is the start address of the allocated region and @i{wior}
is 0. If the allocation fails, @i{a-addr} is undefined and @i{wior}
is a non-zero I/O result code.""
a_addr = (Cell *)malloc(u?u:1);
wior = IOR(a_addr==NULL);

free	( a_addr -- wior )		memory
""Return the region of data space starting at @i{a-addr} to the system.
The region must originally have been obtained using @code{allocate} or
@code{resize}. If the operational is successful, @i{wior} is 0.
If the operation fails, @i{wior} is a non-zero I/O result code.""
free(a_addr);
wior = 0;

resize	( a_addr1 u -- a_addr2 wior )	memory
""Change the size of the allocated area at @i{a-addr1} to @i{u}
address units, possibly moving the contents to a different
area. @i{a-addr2} is the address of the resulting area.
If the operation is successful, @i{wior} is 0.
If the operation fails, @i{wior} is a non-zero
I/O result code. If @i{a-addr1} is 0, Gforth's (but not the Standard)
@code{resize} @code{allocate}s @i{u} address units.""
/* the following check is not necessary on most OSs, but it is needed
   on SunOS 4.1.2. */
/* close ' to keep fontify happy */
if (a_addr1==NULL)
  a_addr2 = (Cell *)malloc(u);
else
  a_addr2 = (Cell *)realloc(a_addr1, u);
wior = IOR(a_addr2==NULL);	/* !! Define a return code */

strerror	( n -- c_addr u )	gforth
c_addr = (Char *)strerror(n);
u = strlen((char *)c_addr);

strsignal	( n -- c_addr u )	gforth
c_addr = (Char *)strsignal(n);
u = strlen((char *)c_addr);

call-c	( ... w -- ... )	gforth	call_c
""Call the C function pointed to by @i{w}. The C function has to
access the stack itself. The stack pointers are exported in the global
variables @code{gforth_SP} and @code{gforth_FP}.""
/* This is a first attempt at support for calls to C. This may change in
   the future */
IF_fpTOS(fp[0]=fpTOS);
gforth_FP=fp;
gforth_SP=sp;
gforth_RP=rp;
gforth_LP=lp;
#ifdef HAS_LINKBACK
((void (*)())w)();
#else
((void (*)(void *))w)(gforth_pointers);
#endif
sp=gforth_SP;
fp=gforth_FP;
rp=gforth_RP;
lp=gforth_LP;
IF_fpTOS(fpTOS=fp[0]);

\+
\+file

close-file	( wfileid -- wior )		file	close_file
wior = IOR(fclose((FILE *)wfileid)==EOF);

open-file	( c_addr u wfam -- wfileid wior )	file	open_file
wfileid = opencreate_file(tilde_cstr(c_addr,u,1), wfam, 0, &wior);

create-file	( c_addr u wfam -- wfileid wior )	file	create_file
wfileid = opencreate_file(tilde_cstr(c_addr,u,1), wfam, O_CREAT|O_TRUNC, &wior);

delete-file	( c_addr u -- wior )		file	delete_file
wior = IOR(unlink(tilde_cstr(c_addr, u, 1))==-1);

rename-file	( c_addr1 u1 c_addr2 u2 -- wior )	file-ext	rename_file
""Rename file @i{c_addr1 u1} to new name @i{c_addr2 u2}""
wior = rename_file(c_addr1, u1, c_addr2, u2);

file-position	( wfileid -- ud wior )	file	file_position
/* !! use tell and lseek? */
ud = OFF2UD(ftello((FILE *)wfileid));
wior = IOR(UD2OFF(ud)==-1);

reposition-file	( ud wfileid -- wior )	file	reposition_file
wior = IOR(fseeko((FILE *)wfileid, UD2OFF(ud), SEEK_SET)==-1);

file-size	( wfileid -- ud wior )	file	file_size
struct stat buf;
wior = IOR(fstat(fileno((FILE *)wfileid), &buf)==-1);
ud = OFF2UD(buf.st_size);

resize-file	( ud wfileid -- wior )	file	resize_file
wior = IOR(ftruncate(fileno((FILE *)wfileid), UD2OFF(ud))==-1);

read-file	( c_addr u1 wfileid -- u2 wior )	file	read_file
/* !! fread does not guarantee enough */
u2 = fread(c_addr, sizeof(Char), u1, (FILE *)wfileid);
wior = FILEIO(u2<u1 && ferror((FILE *)wfileid));
/* !! is the value of ferror errno-compatible? */
if (wior)
  clearerr((FILE *)wfileid);

(read-line)	( c_addr u1 wfileid -- u2 flag u3 wior ) file	paren_read_line
struct Cellquad r = read_line(c_addr, u1, wfileid);
u2   = r.n1;
flag = r.n2;
u3   = r.n3;
wior = r.n4;

\+

write-file	( c_addr u1 wfileid -- wior )	file	write_file
/* !! fwrite does not guarantee enough */
#ifdef HAS_FILE
{
  UCell u2 = fwrite(c_addr, sizeof(Char), u1, (FILE *)wfileid);
  wior = FILEIO(u2<u1 && ferror((FILE *)wfileid));
  if (wior)
    clearerr((FILE *)wfileid);
}
#else
TYPE(c_addr, u1);
#endif

emit-file	( c wfileid -- wior )	gforth	emit_file
#ifdef HAS_FILE
wior = FILEIO(putc(c, (FILE *)wfileid)==EOF);
if (wior)
  clearerr((FILE *)wfileid);
#else
PUTC(c);
#endif

\+file

flush-file	( wfileid -- wior )		file-ext	flush_file
wior = IOR(fflush((FILE *) wfileid)==EOF);

file-status	( c_addr u -- wfam wior )	file-ext	file_status
struct Cellpair r = file_status(c_addr, u);
wfam = r.n1;
wior = r.n2;

file-eof?	( wfileid -- flag )	gforth	file_eof_query
flag = FLAG(feof((FILE *) wfileid));

open-dir	( c_addr u -- wdirid wior )	gforth	open_dir
""Open the directory specified by @i{c-addr, u}
and return @i{dir-id} for futher access to it.""
wdirid = (Cell)opendir(tilde_cstr(c_addr, u, 1));
wior =  IOR(wdirid == 0);

read-dir	( c_addr u1 wdirid -- u2 flag wior )	gforth	read_dir
""Attempt to read the next entry from the directory specified
by @i{dir-id} to the buffer of length @i{u1} at address @i{c-addr}. 
If the attempt fails because there is no more entries,
@i{ior}=0, @i{flag}=0, @i{u2}=0, and the buffer is unmodified.
If the attempt to read the next entry fails because of any other reason, 
return @i{ior}<>0.
If the attempt succeeds, store file name to the buffer at @i{c-addr}
and return @i{ior}=0, @i{flag}=true and @i{u2} equal to the size of the file name.
If the length of the file name is greater than @i{u1}, 
store first @i{u1} characters from file name into the buffer and
indicate "name too long" with @i{ior}, @i{flag}=true, and @i{u2}=@i{u1}.""
struct dirent * dent;
dent = readdir((DIR *)wdirid);
wior = 0;
flag = -1;
if(dent == NULL) {
  u2 = 0;
  flag = 0;
} else {
  u2 = strlen((char *)dent->d_name);
  if(u2 > u1) {
    u2 = u1;
    wior = -512-ENAMETOOLONG;
  }
  memmove(c_addr, dent->d_name, u2);
}

close-dir	( wdirid -- wior )	gforth	close_dir
""Close the directory specified by @i{dir-id}.""
wior = IOR(closedir((DIR *)wdirid));

filename-match	( c_addr1 u1 c_addr2 u2 -- flag )	gforth	match_file
char * string = cstr(c_addr1, u1, 1);
char * pattern = cstr(c_addr2, u2, 0);
flag = FLAG(!fnmatch(pattern, string, 0));

set-dir	( c_addr u -- wior )	gforth set_dir
""Change the current directory to @i{c-addr, u}.
Return an error if this is not possible""
wior = IOR(chdir(tilde_cstr(c_addr, u, 1)));

get-dir	( c_addr1 u1 -- c_addr2 u2 )	gforth get_dir
""Store the current directory in the buffer specified by @i{c-addr1, u1}.
If the buffer size is not sufficient, return 0 0""
c_addr2 = (Char *)getcwd((char *)c_addr1, u1);
if(c_addr2 != NULL) {
  u2 = strlen((char *)c_addr2);
} else {
  u2 = 0;
}

=mkdir ( c_addr u wmode -- wior )        gforth equals_mkdir
""Create directory @i{c-addr u} with mode @i{wmode}.""
wior = IOR(mkdir(tilde_cstr(c_addr,u,1),wmode));

\+

newline	( -- c_addr u )	gforth
""String containing the newline sequence of the host OS""
static const char newline[] = {
#if DIRSEP=='/'
/* Unix */
'\n'
#else
/* DOS, Win, OS/2 */
'\r','\n'
#endif
};
c_addr=(Char *)newline;
u=sizeof(newline);
:
 "newline count ;
Create "newline e? crlf [IF] 2 c, $0D c, [ELSE] 1 c, [THEN] $0A c,

\+os

utime	( -- dtime )	gforth
""Report the current time in microseconds since some epoch.""
struct timeval time1;
gettimeofday(&time1,NULL);
dtime = timeval2us(&time1);

cputime ( -- duser dsystem ) gforth
""duser and dsystem are the respective user- and system-level CPU
times used since the start of the Forth system (excluding child
processes), in microseconds (the granularity may be much larger,
however).  On platforms without the getrusage call, it reports elapsed
time (since some epoch) for duser and 0 for dsystem.""
#ifdef HAVE_GETRUSAGE
struct rusage usage;
getrusage(RUSAGE_SELF, &usage);
duser = timeval2us(&usage.ru_utime);
dsystem = timeval2us(&usage.ru_stime);
#else
struct timeval time1;
gettimeofday(&time1,NULL);
duser = timeval2us(&time1);
dsystem = DZERO;
#endif

\+

\+floating

\g floating

f=	( r1 r2 -- f )		gforth	f_equals
#line 2000
f = FLAG(r1==r2);
#line 2000
:
#line 2000
    [ char fx char 0 = [IF]
#line 2000
	] IF false ELSE true THEN [
#line 2000
    [ELSE]
#line 2000
	] xor 0= [
#line 2000
    [THEN] ] ;
#line 2000

#line 2000
f<>	( r1 r2 -- f )		gforth	f_not_equals
#line 2000
f = FLAG(r1!=r2);
#line 2000
:
#line 2000
    [ char fx char 0 = [IF]
#line 2000
	] IF true ELSE false THEN [
#line 2000
    [ELSE]
#line 2000
	] xor 0<> [
#line 2000
    [THEN] ] ;
#line 2000

#line 2000
f<	( r1 r2 -- f )		float	f_less_than
#line 2000
f = FLAG(r1<r2);
#line 2000
:
#line 2000
    [ char fx char 0 = [IF]
#line 2000
	] MINI and 0<> [
#line 2000
    [ELSE] char fx char u = [IF]
#line 2000
	]   2dup xor 0<  IF nip ELSE - THEN 0<  [
#line 2000
	[ELSE]
#line 2000
	    ] MINI xor >r MINI xor r> u< [
#line 2000
	[THEN]
#line 2000
    [THEN] ] ;
#line 2000

#line 2000
f>	( r1 r2 -- f )		gforth	f_greater_than
#line 2000
f = FLAG(r1>r2);
#line 2000
:
#line 2000
    [ char fx char 0 = [IF] ] negate [ [ELSE] ] swap [ [THEN] ]
#line 2000
    f< ;
#line 2000

#line 2000
f<=	( r1 r2 -- f )		gforth	f_less_or_equal
#line 2000
f = FLAG(r1<=r2);
#line 2000
:
#line 2000
    f> 0= ;
#line 2000

#line 2000
f>=	( r1 r2 -- f )		gforth	f_greater_or_equal
#line 2000
f = FLAG(r1>=r2);
#line 2000
:
#line 2000
    [ char fx char 0 = [IF] ] negate [ [ELSE] ] swap [ [THEN] ]
#line 2000
    f<= ;
#line 2000

#line 2000

f0=	( r -- f )		float	f_zero_equals
#line 2001
f = FLAG(r==0.);
#line 2001
:
#line 2001
    [ char f0x char 0 = [IF]
#line 2001
	] IF false ELSE true THEN [
#line 2001
    [ELSE]
#line 2001
	] xor 0= [
#line 2001
    [THEN] ] ;
#line 2001

#line 2001
f0<>	( r -- f )		gforth	f_zero_not_equals
#line 2001
f = FLAG(r!=0.);
#line 2001
:
#line 2001
    [ char f0x char 0 = [IF]
#line 2001
	] IF true ELSE false THEN [
#line 2001
    [ELSE]
#line 2001
	] xor 0<> [
#line 2001
    [THEN] ] ;
#line 2001

#line 2001
f0<	( r -- f )		float	f_zero_less_than
#line 2001
f = FLAG(r<0.);
#line 2001
:
#line 2001
    [ char f0x char 0 = [IF]
#line 2001
	] MINI and 0<> [
#line 2001
    [ELSE] char f0x char u = [IF]
#line 2001
	]   2dup xor 0<  IF nip ELSE - THEN 0<  [
#line 2001
	[ELSE]
#line 2001
	    ] MINI xor >r MINI xor r> u< [
#line 2001
	[THEN]
#line 2001
    [THEN] ] ;
#line 2001

#line 2001
f0>	( r -- f )		gforth	f_zero_greater_than
#line 2001
f = FLAG(r>0.);
#line 2001
:
#line 2001
    [ char f0x char 0 = [IF] ] negate [ [ELSE] ] swap [ [THEN] ]
#line 2001
    f0< ;
#line 2001

#line 2001
f0<=	( r -- f )		gforth	f_zero_less_or_equal
#line 2001
f = FLAG(r<=0.);
#line 2001
:
#line 2001
    f0> 0= ;
#line 2001

#line 2001
f0>=	( r -- f )		gforth	f_zero_greater_or_equal
#line 2001
f = FLAG(r>=0.);
#line 2001
:
#line 2001
    [ char f0x char 0 = [IF] ] negate [ [ELSE] ] swap [ [THEN] ]
#line 2001
    f0<= ;
#line 2001

#line 2001


s>f	( n -- r )		float	s_to_f
r = n;

d>f	( d -- r )		float	d_to_f
#ifdef BUGGY_LL_D2F
extern double ldexp(double x, int exp);
if (DHI(d)<0) {
#ifdef BUGGY_LL_ADD
  DCell d2=dnegate(d);
#else
  DCell d2=-d;
#endif
  r = -(ldexp((Float)DHI(d2),CELL_BITS) + (Float)DLO(d2));
} else
  r = ldexp((Float)DHI(d),CELL_BITS) + (Float)DLO(d);
#else
r = d;
#endif

f>d	( r -- d )		float	f_to_d
extern DCell double2ll(Float r);
d = double2ll(r);

f>s	( r -- n )		float	f_to_s
n = (Cell)r;

f!	( r f_addr -- )	float	f_store
""Store @i{r} into the float at address @i{f-addr}.""
*f_addr = r;

f@	( f_addr -- r )	float	f_fetch
""@i{r} is the float at address @i{f-addr}.""
r = *f_addr;

df@	( df_addr -- r )	float-ext	d_f_fetch
""Fetch the double-precision IEEE floating-point value @i{r} from the address @i{df-addr}.""
#ifdef IEEE_FP
r = *df_addr;
#else
!! df@
#endif

df!	( r df_addr -- )	float-ext	d_f_store
""Store @i{r} as double-precision IEEE floating-point value to the
address @i{df-addr}.""
#ifdef IEEE_FP
*df_addr = r;
#else
!! df!
#endif

sf@	( sf_addr -- r )	float-ext	s_f_fetch
""Fetch the single-precision IEEE floating-point value @i{r} from the address @i{sf-addr}.""
#ifdef IEEE_FP
r = *sf_addr;
#else
!! sf@
#endif

sf!	( r sf_addr -- )	float-ext	s_f_store
""Store @i{r} as single-precision IEEE floating-point value to the
address @i{sf-addr}.""
#ifdef IEEE_FP
*sf_addr = r;
#else
!! sf!
#endif

f+	( r1 r2 -- r3 )	float	f_plus
r3 = r1+r2;

f-	( r1 r2 -- r3 )	float	f_minus
r3 = r1-r2;

f*	( r1 r2 -- r3 )	float	f_star
r3 = r1*r2;

f/	( r1 r2 -- r3 )	float	f_slash
r3 = r1/r2;

f**	( r1 r2 -- r3 )	float-ext	f_star_star
""@i{r3} is @i{r1} raised to the @i{r2}th power.""
CLOBBER_TOS_WORKAROUND_START;
r3 = pow(r1,r2);
CLOBBER_TOS_WORKAROUND_END;

fm*	( r1 n -- r2 )	gforth	fm_star
r2 = r1*n;

fm/	( r1 n -- r2 )	gforth	fm_slash
r2 = r1/n;

fm*/	( r1 n1 n2 -- r2 )	gforth	fm_star_slash
r2 = (r1*n1)/n2;

f**2	( r1 -- r2 )	gforth	fm_square
r2 = r1*r1;

fnegate	( r1 -- r2 )	float	f_negate
r2 = - r1;

fdrop	( r -- )		float	f_drop

fdup	( r -- r r )	float	f_dupe

fswap	( r1 r2 -- r2 r1 )	float	f_swap

fover	( r1 r2 -- r1 r2 r1 )	float	f_over

frot	( r1 r2 r3 -- r2 r3 r1 )	float	f_rote

fnip	( r1 r2 -- r2 )	gforth	f_nip

ftuck	( r1 r2 -- r2 r1 r2 )	gforth	f_tuck

float+	( f_addr1 -- f_addr2 )	float	float_plus
""@code{1 floats +}.""
f_addr2 = f_addr1+1;

floats	( n1 -- n2 )	float
""@i{n2} is the number of address units of @i{n1} floats.""
n2 = n1*sizeof(Float);

floor	( r1 -- r2 )	float
""Round towards the next smaller integral value, i.e., round toward negative infinity.""
/* !! unclear wording */
CLOBBER_TOS_WORKAROUND_START;
r2 = floor(r1);
CLOBBER_TOS_WORKAROUND_END;

fround	( r1 -- r2 )	float	f_round
""Round to the nearest integral value.""
CLOBBER_TOS_WORKAROUND_START;
r2 = rint(r1);
CLOBBER_TOS_WORKAROUND_END;

fmax	( r1 r2 -- r3 )	float	f_max
if (r1<r2)
  r3 = r2;
else
  r3 = r1;

fmin	( r1 r2 -- r3 )	float	f_min
if (r1<r2)
  r3 = r1;
else
  r3 = r2;

represent	( r c_addr u -- n f1 f2 )	float
char *sig;
size_t siglen;
int flag;
int decpt;
sig=ecvt(r, u, &decpt, &flag);
n=(r==0. ? 1 : decpt);
f1=FLAG(flag!=0);
f2=FLAG(isdigit((unsigned)(sig[0]))!=0);
siglen=strlen((char *)sig);
if (siglen>u) /* happens in glibc-2.1.3 if 999.. is rounded up */
  siglen=u;
if (!f2) /* workaround Cygwin trailing 0s for Inf and Nan */
  for (; sig[siglen-1]=='0'; siglen--);
    ;
memcpy(c_addr,sig,siglen);
memset(c_addr+siglen,f2?'0':' ',u-siglen);

>float	( c_addr u -- f:... flag )	float	to_float
""Actual stack effect: ( c_addr u -- r t | f ).  Attempt to convert the
character string @i{c-addr u} to internal floating-point
representation. If the string represents a valid floating-point number
@i{r} is placed on the floating-point stack and @i{flag} is
true. Otherwise, @i{flag} is false. A string of blanks is a special
case and represents the floating-point number 0.""
Float r;
flag = to_float(c_addr, u, &r);
if (flag) {
  fp--;
  fp[0]=r;
}

fabs	( r1 -- r2 )	float-ext	f_abs
r2 = fabs(r1);

facos	( r1 -- r2 )	float-ext	f_a_cos
CLOBBER_TOS_WORKAROUND_START;
r2 = acos(r1);
CLOBBER_TOS_WORKAROUND_END;

fasin	( r1 -- r2 )	float-ext	f_a_sine
CLOBBER_TOS_WORKAROUND_START;
r2 = asin(r1);
CLOBBER_TOS_WORKAROUND_END;

fatan	( r1 -- r2 )	float-ext	f_a_tan
CLOBBER_TOS_WORKAROUND_START;
r2 = atan(r1);
CLOBBER_TOS_WORKAROUND_END;

fatan2	( r1 r2 -- r3 )	float-ext	f_a_tan_two
""@i{r1/r2}=tan(@i{r3}). ANS Forth does not require, but probably
intends this to be the inverse of @code{fsincos}. In gforth it is.""
CLOBBER_TOS_WORKAROUND_START;
r3 = atan2(r1,r2);
CLOBBER_TOS_WORKAROUND_END;

fcos	( r1 -- r2 )	float-ext	f_cos
CLOBBER_TOS_WORKAROUND_START;
r2 = cos(r1);
CLOBBER_TOS_WORKAROUND_END;

fexp	( r1 -- r2 )	float-ext	f_e_x_p
CLOBBER_TOS_WORKAROUND_START;
r2 = exp(r1);
CLOBBER_TOS_WORKAROUND_END;

fexpm1	( r1 -- r2 )	float-ext	f_e_x_p_m_one
""@i{r2}=@i{e}**@i{r1}@minus{}1""
CLOBBER_TOS_WORKAROUND_START;
#ifdef HAVE_EXPM1
extern double
#ifdef NeXT
              const
#endif
                    expm1(double);
r2 = expm1(r1);
#else
r2 = exp(r1)-1.;
#endif
CLOBBER_TOS_WORKAROUND_END;

fln	( r1 -- r2 )	float-ext	f_l_n
CLOBBER_TOS_WORKAROUND_START;
r2 = log(r1);
CLOBBER_TOS_WORKAROUND_END;

flnp1	( r1 -- r2 )	float-ext	f_l_n_p_one
""@i{r2}=ln(@i{r1}+1)""
CLOBBER_TOS_WORKAROUND_START;
#ifdef HAVE_LOG1P
extern double
#ifdef NeXT
              const
#endif
                    log1p(double);
r2 = log1p(r1);
#else
r2 = log(r1+1.);
#endif
CLOBBER_TOS_WORKAROUND_END;

flog	( r1 -- r2 )	float-ext	f_log
""The decimal logarithm.""
CLOBBER_TOS_WORKAROUND_START;
r2 = log10(r1);
CLOBBER_TOS_WORKAROUND_END;

falog	( r1 -- r2 )	float-ext	f_a_log
""@i{r2}=10**@i{r1}""
extern double pow10(double);
CLOBBER_TOS_WORKAROUND_START;
r2 = pow10(r1);
CLOBBER_TOS_WORKAROUND_END;

fsin	( r1 -- r2 )	float-ext	f_sine
CLOBBER_TOS_WORKAROUND_START;
r2 = sin(r1);

fsincos	( r1 -- r2 r3 )	float-ext	f_sine_cos
""@i{r2}=sin(@i{r1}), @i{r3}=cos(@i{r1})""
CLOBBER_TOS_WORKAROUND_START;
r2 = sin(r1);
r3 = cos(r1);
CLOBBER_TOS_WORKAROUND_END;

fsqrt	( r1 -- r2 )	float-ext	f_square_root
CLOBBER_TOS_WORKAROUND_START;
r2 = sqrt(r1);
CLOBBER_TOS_WORKAROUND_END;

ftan	( r1 -- r2 )	float-ext	f_tan
CLOBBER_TOS_WORKAROUND_START;
r2 = tan(r1);
CLOBBER_TOS_WORKAROUND_END;
:
 fsincos f/ ;

fsinh	( r1 -- r2 )	float-ext	f_cinch
CLOBBER_TOS_WORKAROUND_START;
r2 = sinh(r1);
CLOBBER_TOS_WORKAROUND_END;
:
 fexpm1 fdup fdup 1. d>f f+ f/ f+ f2/ ;

fcosh	( r1 -- r2 )	float-ext	f_cosh
CLOBBER_TOS_WORKAROUND_START;
r2 = cosh(r1);
CLOBBER_TOS_WORKAROUND_END;
:
 fexp fdup 1/f f+ f2/ ;

ftanh	( r1 -- r2 )	float-ext	f_tan_h
CLOBBER_TOS_WORKAROUND_START;
r2 = tanh(r1);
CLOBBER_TOS_WORKAROUND_END;
:
 f2* fexpm1 fdup 2. d>f f+ f/ ;

fasinh	( r1 -- r2 )	float-ext	f_a_cinch
CLOBBER_TOS_WORKAROUND_START;
r2 = asinh(r1);
CLOBBER_TOS_WORKAROUND_END;
:
 fdup fdup f* 1. d>f f+ fsqrt f/ fatanh ;

facosh	( r1 -- r2 )	float-ext	f_a_cosh
CLOBBER_TOS_WORKAROUND_START;
r2 = acosh(r1);
CLOBBER_TOS_WORKAROUND_END;
:
 fdup fdup f* 1. d>f f- fsqrt f+ fln ;

fatanh	( r1 -- r2 )	float-ext	f_a_tan_h
CLOBBER_TOS_WORKAROUND_START;
r2 = atanh(r1);
CLOBBER_TOS_WORKAROUND_END;
:
 fdup f0< >r fabs 1. d>f fover f- f/  f2* flnp1 f2/
 r> IF  fnegate  THEN ;

sfloats	( n1 -- n2 )	float-ext	s_floats
""@i{n2} is the number of address units of @i{n1}
single-precision IEEE floating-point numbers.""
n2 = n1*sizeof(SFloat);

dfloats	( n1 -- n2 )	float-ext	d_floats
""@i{n2} is the number of address units of @i{n1}
double-precision IEEE floating-point numbers.""
n2 = n1*sizeof(DFloat);

sfaligned	( c_addr -- sf_addr )	float-ext	s_f_aligned
""@i{sf-addr} is the first single-float-aligned address greater
than or equal to @i{c-addr}.""
sf_addr = (SFloat *)((((Cell)c_addr)+(sizeof(SFloat)-1))&(-sizeof(SFloat)));
:
 [ 1 sfloats 1- ] Literal + [ -1 sfloats ] Literal and ;

dfaligned	( c_addr -- df_addr )	float-ext	d_f_aligned
""@i{df-addr} is the first double-float-aligned address greater
than or equal to @i{c-addr}.""
df_addr = (DFloat *)((((Cell)c_addr)+(sizeof(DFloat)-1))&(-sizeof(DFloat)));
:
 [ 1 dfloats 1- ] Literal + [ -1 dfloats ] Literal and ;

v*	( f_addr1 nstride1 f_addr2 nstride2 ucount -- r ) gforth v_star
""dot-product: r=v1*v2.  The first element of v1 is at f_addr1, the
next at f_addr1+nstride1 and so on (similar for v2). Both vectors have
ucount elements.""
r = v_star(f_addr1, nstride1, f_addr2, nstride2, ucount);
:
 >r swap 2swap swap 0e r> 0 ?DO
     dup f@ over + 2swap dup f@ f* f+ over + 2swap
 LOOP 2drop 2drop ; 

faxpy	( ra f_x nstridex f_y nstridey ucount -- )	gforth
""vy=ra*vx+vy""
faxpy(ra, f_x, nstridex, f_y, nstridey, ucount);
:
 >r swap 2swap swap r> 0 ?DO
     fdup dup f@ f* over + 2swap dup f@ f+ dup f! over + 2swap
 LOOP 2drop 2drop fdrop ;

\+

\ The following words access machine/OS/installation-dependent
\   Gforth internals
\ !! how about environmental queries DIRECT-THREADED,
\   INDIRECT-THREADED, TOS-CACHED, FTOS-CACHED, CODEFIELD-DOES */

\ local variable implementation primitives

\+glocals

\g locals

@local#	( #noffset -- w )	gforth	fetch_local_number
w = *(Cell *)(lp+noffset);

@local0	( -- w )	new	fetch_local_zero
w = ((Cell *)lp)[0];

@local1	( -- w )	new	fetch_local_four
w = ((Cell *)lp)[1];

@local2	( -- w )	new	fetch_local_eight
w = ((Cell *)lp)[2];

@local3	( -- w )	new	fetch_local_twelve
w = ((Cell *)lp)[3];

\+floating

f@local#	( #noffset -- r )	gforth	f_fetch_local_number
r = *(Float *)(lp+noffset);

f@local0	( -- r )	new	f_fetch_local_zero
r = ((Float *)lp)[0];

f@local1	( -- r )	new	f_fetch_local_eight
r = ((Float *)lp)[1];

\+

laddr#	( #noffset -- c_addr )	gforth	laddr_number
/* this can also be used to implement lp@ */
c_addr = (Char *)(lp+noffset);

lp+!#	( #noffset -- )	gforth	lp_plus_store_number
""used with negative immediate values it allocates memory on the
local stack, a positive immediate argument drops memory from the local
stack""
lp += noffset;

lp-	( -- )	new	minus_four_lp_plus_store
lp += -sizeof(Cell);

lp+	( -- )	new	eight_lp_plus_store
lp += sizeof(Float);

lp+2	( -- )	new	sixteen_lp_plus_store
lp += 2*sizeof(Float);

lp!	( c_addr -- )	gforth	lp_store
lp = (Address)c_addr;

>l	( w -- )	gforth	to_l
lp -= sizeof(Cell);
*(Cell *)lp = w;

\+floating

f>l	( r -- )	gforth	f_to_l
lp -= sizeof(Float);
*(Float *)lp = r;

fpick	( f:... u -- f:... r )		gforth
""Actually the stack effect is @code{ r0 ... ru u -- r0 ... ru r0 }.""
r = fp[u];
:
 floats fp@ + f@ ;

\+
\+

\+OS

\g syslib

open-lib	( c_addr1 u1 -- u2 )	gforth	open_lib
u2 = gforth_dlopen(c_addr1, u1);

lib-sym	( c_addr1 u1 u2 -- u3 )	gforth	lib_sym
#ifdef HAVE_LIBLTDL
u3 = (UCell) lt_dlsym((lt_dlhandle)u2, cstr(c_addr1, u1, 1));
#elif defined(HAVE_LIBDL) || defined(HAVE_DLOPEN)
u3 = (UCell) dlsym((void*)u2,cstr(c_addr1, u1, 1));
#else
#  ifdef _WIN32
u3 = (Cell) GetProcAddress((HMODULE)u2, cstr(c_addr1, u1, 1));
#  else
#warning Define lib-sym!
u3 = 0;
#  endif
#endif

wcall	( ... u -- ... )	gforth
gforth_FP=fp;
sp=(Cell*)(SYSCALL(Cell*(*)(Cell *, void *))u)(sp, &gforth_FP);
fp=gforth_FP;

uw@ ( c_addr -- u )	gforth u_w_fetch
""@i{u} is the zero-extended 16-bit value stored at @i{c_addr}.""
u = *(UWyde*)(c_addr);

sw@ ( c_addr -- n )	gforth s_w_fetch
""@i{n} is the sign-extended 16-bit value stored at @i{c_addr}.""
n = *(Wyde*)(c_addr);

w! ( w c_addr -- )	gforth w_store
""Store the bottom 16 bits of @i{w} at @i{c_addr}.""
*(Wyde*)(c_addr) = w;

ul@ ( c_addr -- u )	gforth u_l_fetch
""@i{u} is the zero-extended 32-bit value stored at @i{c_addr}.""
u = *(UTetrabyte*)(c_addr);

sl@ ( c_addr -- n )	gforth s_l_fetch
""@i{n} is the sign-extended 32-bit value stored at @i{c_addr}.""
n = *(Tetrabyte*)(c_addr);

l! ( w c_addr -- )	gforth l_store
""Store the bottom 32 bits of @i{w} at @i{c_addr}.""
*(Tetrabyte*)(c_addr) = w;

lib-error ( -- c_addr u )       gforth  lib_error
""Error message for last failed @code{open-lib} or @code{lib-sym}.""
#ifdef HAVE_LIBLTDL
c_addr = (Char *)lt_dlerror();
u = (c_addr == NULL) ? 0 : strlen((char *)c_addr);
#else
c_addr = "libltdl is not configured";
u = strlen(c_addr);
#endif

\+
\g peephole

\+peephole

compile-prim1 ( a_prim -- ) gforth compile_prim1
""compile prim (incl. immargs) at @var{a_prim}""
compile_prim1(a_prim);

finish-code ( ... -- ... ) gforth finish_code
""Perform delayed steps in code generation (branch resolution, I-cache
flushing).""
/* The ... above are a workaround for a bug in gcc-2.95, which fails
   to save spTOS (gforth-fast --enable-force-reg) */
finish_code();

forget-dyncode ( c_code -- f ) gforth-internal forget_dyncode
f = forget_dyncode(c_code);

decompile-prim ( a_code -- a_prim ) gforth-internal decompile_prim
""a_prim is the code address of the primitive that has been
compile_prim1ed to a_code""
a_prim = (Cell *)decompile_code((Label)a_code);

\ set-next-code and call2 do not appear in images and can be
\ renumbered arbitrarily

set-next-code ( #w -- ) gforth set_next_code
#ifdef NO_IP
next_code = (Label)w;
#endif

call2 ( #a_callee #a_ret_addr -- R:a_ret_addr ) gforth
/* call with explicit return address */
#ifdef NO_IP
INST_TAIL;
JUMP(a_callee);
#else
assert(0);
#endif

tag-offsets ( -- a_addr ) gforth tag_offsets
extern Cell groups[32];
a_addr = groups;

\+

\g static_super

#line 1 "peeprules.vmg"
\ Gforth superinstructions and stack caching replicas

\ Copyright (C) 2003,2004,2005,2007 Free Software Foundation, Inc.

\ This file is part of Gforth.

\ Gforth is free software; you can redistribute it and/or
\ modify it under the terms of the GNU General Public License
\ as published by the Free Software Foundation, either version 3
\ of the License, or (at your option) any later version.

\ This program is distributed in the hope that it will be useful,
\ but WITHOUT ANY WARRANTY; without even the implied warranty of
\ MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
\ GNU General Public License for more details.

\ You should have received a copy of the GNU General Public License
\ along with this program. If not, see http://www.gnu.org/licenses/.

\ taken from David Gregg's EuroForth 2001 paper; omitted some sequences
\ eliminated for gforth-native:
\ 1) sequences containing call
\ 2) sequences with immediate arguments not in the first position

\ no new prim-nums for supers and state-replicas
\E ' noop is output-c-prim-num

super1 = lit +
\ super2 = lit call
super3 = lit @
\ super4 = lit @ call
\ super5 = @ call
super6 = lit !
\ super7 = lit lit
\ super8 = dup lit
\ super9 = ! lit
\ super10 = lit ! lit
super11 = ! ;s
super12 = lit + @
\ super13 = 0= ?branch
\ super14 = dup call
super15 = useraddr @
super16 = + @
\ super17 = lit @ ?branch
super18 = lit ! ;s
super19 = lit @ and
\ super20 = = ?branch
\ super21 = lit lit !
\ super22 = @ ?branch
super23 = useraddr !
\ super24 = dup ?branch
super25 = @ ;s
super26 = lit @ +
super27 = dup @

\F 0 [if]

\ \E prim-states ;s                   \ 2950159
\E prim-states lit                  \ 2802835
\ \E prim-states call                 \ 2558373
\E prim-states @                    \ 2244351
\E branch-states ?branch              \ 1134432
\E prim-states lit@                 \ 1051813
\E prim-states swap                 \ 737988
\E S0 S2 state-prim swap
\E S1 S2 state-prim swap
\E S2 S3 state-prim swap
\E S3 S2 state-prim swap
\E prim-states c@                   \ 651406
\E prim-states =                    \ 590006
\E prim-states 0=                   \ 584487
\E prim-states dup                  \ 566855
\E S0 S1 state-prim dup
\E S1 S1 state-prim dup
\E prim-states +                    \ 566003
\E prim-states i                    \ 502908
\E prim-states +!                   \ 448925
\ \E prim-states branch               \ 409561
\ \E prim-states (loop)               \ 379646
\ \E prim-states lp!                  \ 326743
\E prim-states and                  \ 309427
\E prim-states useraddr             \ 303254
\E prim-states over                 \ 283556
\E S0 S1 state-prim over
\E S1 S2 state-prim over
\E S2 S1 state-prim over
\E S3 S2 state-prim over
\E prim-states negate               \ 257417
\E prim-states cells                \ 254644
\E prim-states rot                  \ 220273
\E S3 S1 state-prim rot
\E S2 S3 state-prim rot
\E S1 S3 state-prim rot
\E S0 S3 state-prim rot
\E S4 S2 state-prim rot
\E S5 S3 state-prim rot
\E prim-states !                    \ 218672
\E prim-states 2dup                 \ 211315
\E S0 S1 state-prim 2dup
\E S0 S2 state-prim 2dup
\E S1 S3 state-prim 2dup
\E S2 S2 state-prim 2dup
\E S3 S1 state-prim 2dup
\E S4 S4 state-prim 2dup
\E S4 S2 state-prim 2dup
\ \E branch-states lit-perform          \ 188331
\E prim-states <>                   \ 179502
\E prim-states c!                   \ 179332
\E prim-states lit+                 \ 179156
\E prim-states drop                 \ 173995
\E S0 S0 state-prim drop
\E prim-states lshift               \ 164671
\E prim-states /mod                 \ 164670
\E prim-states >r                   \ 145247
\E prim-states r>                   \ 133792
\ \E branch-states does-exec            \ 120944
\E prim-states cell+                \ 116183
\E prim-states lp+!#                \ 106697 \ --
\E prim-states -                    \ 106245
\E prim-states unloop               \ 98938 \ --
\E prim-states lp+                  \ 87190 \ --
\E prim-states >=                   \ 80994
\E prim-states tuck                 \ 78696
\E S2 S2 state-prim tuck
\E S3 S3 state-prim tuck
\E prim-states /string              \ 78595
\E prim-states char+                \ 77542
\E prim-states ?dup                 \ 76850
\E prim-states @local0              \ 75322
\E prim-states min                  \ 75264
\ \E prim-states compare              \ 65603
\E branch-states (u+do)               \ 63823
\ \E prim-states (read-line)          \ 63823
\E prim-states 2>r                  \ 62646
\E prim-states 2r>                  \ 62644
\E prim-states 2r@                  \ 61338
\E prim-states 2@                   \ 61067
\E prim-states nip                  \ 54961
\E S1 S1 state-prim nip
\E S0 S1 state-prim nip
\E S2 S2 state-prim nip
\E prim-states within               \ 51075
\E prim-states 1-                   \ 47441
\E branch-states execute              \ 46674
\E prim-states lp-                  \ 45385
\E branch-states perform              \ 38756
\E prim-states xor                  \ 35599
\E prim-states @local#              \ 34586
\ \E prim-states pick                 \ 32015
\E prim-states u>                   \ 29373
\E prim-states -rot                 \ 26211
\E S3 S2 state-prim -rot
\E S1 S3 state-prim -rot
\E S4 S3 state-prim -rot
\E S2 S4 state-prim -rot
\E S3 S5 state-prim -rot
\E prim-states 2drop                \ 25418
\E S0 S0 state-prim 2drop
\E S1 S0 state-prim 2drop
\ \E prim-states (tablelfind)         \ 22243
\E prim-states or                   \ 21587
\E prim-states @local2              \ 20859
\E branch-states (+loop)              \ 20006
\E prim-states 1+                   \ 17944
\E prim-states rdrop                \ 17902
\E branch-states (?do)                \ 17348
\E prim-states max                  \ 16948
\E prim-states 2*                   \ 15606
\ \E prim-states filename-match       \ 15003
\ \E prim-states (listlfind)          \ 13074
\ \E prim-states sp@                  \ 12741
\ \E prim-states fp@                  \ 12384
\ \E prim-states um/mod               \ 12288
\E prim-states 2!                   \ 11904
\ \E prim-states fill                 \ 10781
\ \E prim-states (parse-white)        \ 10624
\E branch-states (do)                 \ 10516
\ \E prim-states (hashkey1)           \ 10239
\E prim-states u<                   \ 9602
\ \E prim-states write-file           \ 8973
\E prim-states count                \ 8873
\ \E prim-states rp@                  \ 8410
\E prim-states 0<                   \ 8380
\E prim-states <                    \ 7741
\E prim-states @local1              \ 7458
\ \E prim-states move                 \ 7050
\E prim-states u>=                  \ 6138
\E branch-states (+do)                \ 5863
\ \E prim-states va-return-double     \ 5517
\E prim-states um*                  \ 5342
\ \E prim-states toupper              \ 3517
\ \E prim-states f@local1             \ 2907
\ \E prim-states rp!                  \ 2859
\ \E prim-states ?dup-?branch         \ 2829
\E prim-states d+                   \ 2671
\ \E prim-states ftuck                \ 2636
\ \E prim-states read-file            \ 2623
\ \E prim-states ms                   \ 2454
\ \E prim-states (s+loop)             \ 2429
\ \E prim-states allocate             \ 1869
\E prim-states *                    \ 1520
\E prim-states 0<>                  \ 925
\ \E prim-states noop                 \ 715
\E prim-states aligned              \ 714
\E prim-states u<=                  \ 684
\E prim-states i'                   \ 684
\E prim-states >                    \ 411
\ \E prim-states (hashlfind)          \ 397
\E prim-states 2swap                \ 336
\E S0 S3 state-prim 2swap
\E S1 S3 state-prim 2swap
\E S2 S4 state-prim 2swap
\E S4 S2 state-prim 2swap
\E prim-states laddr#               \ 335
\ \E prim-states faxpy                \ 286
\ \E prim-states (next)               \ 272
\ \E prim-states (-loop)-lp+!#        \ 248
\E prim-states <=                   \ 199
\E prim-states invert               \ 170
\E branch-states (-do)                \ 169
\E prim-states 2over                \ 165
\E S0 S2 state-prim 2over
\E S1 S3 state-prim 2over
\E S2 S4 state-prim 2over
\E S3 S5 state-prim 2over
\E S4 S2 state-prim 2over
\E S5 S3 state-prim 2over
\E S6 S4 state-prim 2over
\E prim-states under+               \ 154
\E prim-states dnegate              \ 128
\E prim-states u<>                  \ 128
\E prim-states 0>                   \ 122
\ \E prim-states (loop)-lp+!#         \ 118
\E prim-states j                    \ 117
\E prim-states float+               \ 78
\ \E prim-states (for)                \ 68
\E prim-states 2rdrop               \ 60 \ --
\ \E prim-states f!                   \ 14
\E prim-states >l                   \ 14
\ \E prim-states close-file           \ 5
\ \E prim-states call-c               \ 4
\ \E prim-states reposition-file      \ 3
\E prim-states /                    \ 3
\ \E prim-states resize-file          \ 2
\ \E prim-states free                 \ 2
\E prim-states 2/                   \ 2
\ \E prim-states up!                  \ 1
\ \E prim-states stdin                \ 1
\ \E prim-states key?-file            \ 1
\ \E prim-states flush-icache         \ 1
\ \E prim-states cmove                \ 1
\ \E prim-states (system)             \ 1

\E ' noop is output-nextp0
\E ' noop is output-nextp1

\E gen-transitions noop

\F [ENDIF]
#line 2566 "prim"


\g end
