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

direct_connected(X, Y, L1):-
    edge(X,Y, L1) ; edge(Y, X, L1).

adiacent([X,L1], [Y,L1]) :- direct_connected(X, Y, L1).

%% a station where I can change teh Line ...

change(L1,L2, X) :-
	station(X,L1),
        station(X,L2),
        not(L1 == L2).
                     
same_line_path(Node, Node, _, [Node]).                      % rule 1
same_line_path(Start, Finish, Visited, [Start | Path]) :-   % rule 2
     adiacent(Start, X),
     not(member(X, Visited)),
     same_line_path(X, Finish, [X | Visited], Path).

one_change_line_path([Start,L1], [End,L2], Visited, Path):-
        station(Start,L1),
	station(End,L2),
        change(L1,L2, X), 
        same_line_path([Start,L1], [X,L1], [[Start,L1]|Visited], Path1),       
        same_line_path([X,L2], [End,L2], [[X,L2]|Visited], Path2),
        append(Path1, Path2, Path).

two_changes_line_path([Start,L1], [End,L2], Visited, Path):-
        station(Start,L1),
	station(End,L2),
        change(L1,L3, X),
        not(L2 == L3),
        same_line_path([Start,L1], [X,L1], [[Start,L1]|Visited], Path1),
        one_change_line_path([X,L3], [End,L2], [[X,L2]|Path1], Path2),
        append(Path1, Path2, Path).

path(S1, S2, Path, 0):-
        same_line_path(S1, S2, [S1], Path), !.
path(S1, S2, Path, 1):-
        one_change_line_path(S1, S2, [S1], Path), !.
path(S1, S2, Path, 2):-
        two_changes_line_path(S1, S2, [S1], Path).

route(Start, End, Path, Changes):-
        station(Start,L1),
	station(End,L2),
        not(Start == End),
        path([Start,L1], [End,L2], Path, Changes).

shortest_route(A,B,S) :-
        findall([C,P], route(A,B,P,C), Ps), sort(Ps, [[_,S]|_]).

all_routes(A,B,Ps) :-
    findall([C,P], route(A,B,P,C), Ps).
