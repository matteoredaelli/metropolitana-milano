

exchange(Station, Line1, Line2):-
        station(Station, Line1),
        station(Station, Line2),
        not(Line1 == Line2).

edge(X,Y) :- link(X,Y, _) ; link(Y, X, _).
        
path(Start, End, Path) :- path(Start, End, [Start], Path).

path(Node, Node, _, [Node]).                      % rule 1
path(Start, Finish, Visited, [Start | Path]) :-   % rule 2
     edge(Start, X),
     not(member(X, Visited)),
     path(X, Finish, [X | Visited], Path).

shortest_path(A,B,S) :-
    findall(P, path(A,B,P), Ps),
    maplist(prepend_length, Ps, Ls),
    sort(Ls, [[_,S]|_]).

prepend_length(P, [L,P]) :-
    length(P,L).