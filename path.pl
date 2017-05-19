/*
    metropolitana-milano
    Copyright (C) 2017  Matteo.Redadelli@gmail.com

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/
connected([X,L1], [Y,L1]) :- edge(X,Y, L1) ; edge(Y, X, L1).
connected([X,L1], [X,L2]) :-
	station(X,L1), station(X,L2), not(L1 == L2).
        
path(Start, End, Path) :-
	station(Start,L1),
	station(End,L2),
	path([Start,L1], [End,L2], [[Start,L1]], Path).

path(Node, Node, _, [Node]).                      % rule 1
path(Start, Finish, Visited, [Start | Path]) :-   % rule 2
     connected(Start, X),
     not(member(X, Visited)),
     path(X, Finish, [X | Visited], Path).

shortest_path(A,B,S) :-
    findall(P, path(A,B,P), Ps),
    maplist(prepend_length, Ps, Ls),
    sort(Ls, [[_,S]|_]).

prepend_length(P, [L,P]) :-
    length(P,L).