/* header file for libcc-generated C code

  Copyright (C) 2006,2007,2008 Free Software Foundation, Inc.

  This file is part of Gforth.

  Gforth is free software; you can redistribute it and/or
  modify it under the terms of the GNU General Public License
  as published by the Free Software Foundation, either version 3
  of the License, or (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program. If not, see http://www.gnu.org/licenses/.
*/

#include <gforth/0.7.3/config.h>

#if defined(_WIN32) || defined(__WIN32__) || defined(__CYGWIN__)
#undef HAS_BACKLINK
#else
#define HAS_BACKLINK 1
#endif

typedef CELL_TYPE Cell;
typedef double Float;

#define Clongest long long
typedef unsigned Clongest UClongest;

#ifdef HAS_BACKLINK
extern Cell *gforth_SP;
extern Float *gforth_FP;
extern Cell *gforth_RP;
extern char *gforth_LP;
extern char *gforth_UP;
extern void *gforth_engine(void *, Cell *, Cell *, Float *, char *, char *);
extern char *cstr(char *from, Cell size, int clear);
extern char *tilde_cstr(char *from, Cell size, int clear);
#define GFORTH_ARGS void
#else
#define gforth_SP *((Cell **)(gforth_pointers[0]))
#define gforth_FP *((Float **)(gforth_pointers[1]))
#define gforth_LP *((char **)(gforth_pointers[2]))
#define gforth_RP *((Cell **)(gforth_pointers[3]))
#define gforth_UP *((char **)(gforth_pointers[4]))
#define gforth_engine ((char *(*)(Xt *, Cell *, Cell *, Float *, char *, char *))(((void **)(gforth_pointers[5]))))
#define cstr ((char *(*)(char *, Cell, int))(((void **)(gforth_pointers[6]))))
#define tilde_cstr ((char *(*)(char *, Cell, int))(((void **)(gforth_pointers[7]))))
#define GFORTH_ARGS void ** gforth_pointers 
#endif

#define CELL_BITS	(sizeof(Cell) * 8)

#define gforth_d2ll(lo,hi) \
  ((sizeof(Cell) < sizeof(Clongest)) \
   ? (((UClongest)(lo))|(((UClongest)(hi))<<CELL_BITS)) \
   : (lo))

#define gforth_ll2d(ll,lo,hi) \
  do { \
    UClongest _ll = (ll); \
    (lo) = (Cell)_ll; \
    (hi) = ((sizeof(Cell) < sizeof(Clongest)) \
            ? (_ll >> CELL_BITS) \
            : 0); \
  } while (0);
