/**
  * Rules for lists manipulation.
  *
  * This library is needed to manipulate list elements.
  */

/* given a list L, find the maximum value M, and the index I of it
   where no other element E in the list is larger than M */
list_max(L, M, I) :- nth0(I, L, M), not((member(E, L), E > M)).

/* increment the disease at index I by recursively passing through list tail T */
increment_disease(I, [H|T], [H|R]):-
  I > -1,
  I2 is I-1,
  increment_disease(I2, T, R), !.
/* stop when index 0 is reached */
increment_disease(0, [H|T], [H1|T]):- H1 is H+1.

/* find index of element E, given E and its list */
indexOf(E, [_|T], I):-
  indexOf(E, T, I2),
  !,
  I is I2+1.
/* stop when index 0 is reached */
indexOf(E, [E|_], 0):- !.

/* count the number of elements in list L by recursively passing through list tail T */
list_length([_|T] , L ) :- list_length(T,I) , L is I+1 .
/* stop when list is empty */
list_length([], 0 ).

/* print out the list contents and write a new line when list is empty */
print_list([H|T]):- write(H), print_list(T).
print_list([]):- nl.
