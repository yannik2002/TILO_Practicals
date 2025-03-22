
% AUFGABE 1:

% praefix(Xs,Ys) : Liste Ys beginnt mit der Liste Xs
% Bis man Xs komplett durchlaufen ist müssen die ersten Elemente X gleich sein
praefix([X],[X|_]).
praefix([X|Xs],[X|Ys]) :- praefix(Xs,Ys).


% postfix(Xs,Ys) :- Liste Ys endet mit der Liste Xs
% postfix(Zs,[a,b]). alle postfixe der list mit a und b

% beide Listen reversen, dann ist die umgedrehte Xs praefix von umgedrehter Ys
postfix1(Xs,Ys) :- reverse(Xs,Xsr), reverse(Ys,Ysr), praefix(Xsr,Ysr).

% infix mit postfix und praefix
% Liste Xs ist in Liste Ys enthalten
infix(Xs,Ys) :- praefix(Hs,Ys), postfix1(Xs,Hs).

% Rs + Xs = Ys, Xs an Rs angehangen ergibt Ys
% Es muss möglich sein die Liste Ys zu erstellen, indem ich Xs an eine Liste hinten anhänge
postfix2(Xs,Ys) :- append(_,Xs,Ys).

%postfix2(Zs,[1,2,3,4]).

%  1, 2, 3, 4   Ys
%        3, 4   Xs
	  
%  4, 3, 2, 1   Ysr
%  4, 3		Xsr




% AUFGABE 2:

% Ueberpruefung
binbaum(empty).
binbaum(node(_,Lb,Rb)) :- binbaum(Lb), binbaum(Rb).

% Zum testen: membertree(2,node(1,node(2,empty,empty),node(3,empty,empty))).
% membertree(X,Xb) : Baum Xb enthaelt Eintrag X
membertree(X,node(X,_,_)).
membertree(X,node(_,Lb,_)) :- membertree(X,Lb),binbaum(Lb).
membertree(X,node(_,_,Rb)) :- membertree(X,Rb),binbaum(Rb).




% AUFGABE 3:

% praeorder(Xb,Ys) : Ys ist die Liste der Knotenbeschriftungen des Binaerbaums Xb in praeorder
% Preorder: Wurzel, Links, Rechts
% Entsprechend wird zuerst die Wurzel mit der Liste verglichen, dann rekursiv den linken und rechten Teilbaum
% Es werden nach Teillisten gesucht, welche Ls + Rs = Ys ergeben
praeorder(empty,[]).
praeorder(node(X,Lb,Rb),[X|Ys]) :- praeorder(Lb,Ls), praeorder(Rb,Rs), append(Ls,Rs,Ys), 
								binbaum(Lb), binbaum(Rb).
									
%praeorder(node(10,node(5,node(1,empty,empty),node(8,empty,empty)),node(20,empty,empty)),Zs).


%postorder(Xb,Ys): Ys ist die Liste der Knotenbeschriftungen des Binaerbaums Xb in Postorder
% Postorder: Links, Rechts, Wurzel
% Ganz ähnlich zu oben, nur dass man die Preorderliste Ys nicht durch Ls+Rs=Ys zusammensetzt
% sondern eine Liste Gesamts sucht, welche mit der Wurzel appended Gesamts+X=Ys ergibt
postorder(empty,[]).
postorder(node(X,Lb,Rb),Ys) :- postorder(Lb,Ls), postorder(Rb,Rs), append(Ls,Rs,Gesamts), append(Gesamts,[X],Ys),
											binbaum(Lb), binbaum(Rb).
								
%postorder(node(10,node(5,node(1,empty,empty),node(8,empty,empty)),node(20,empty,empty)),Zs).


% roots(Xbs,Ys): Xbs ist Liste an Baeumen und Ys ist Liste der roots von den Baeumen aus Xbs
% geht die Liste Xbs von vorne nach hinten durch und vergleicht synchron die Wurzelknoten mit der Liste Ys
% Bei gleichheit geht er eins weiter, falls nicht false. True wenn bei Listen leer sind
% Listen müssten bei true gleiche Mächtigkeit haben
roots([],[]).
roots([node(X,_,_)|Xbs],[X|Ys]) :- roots(Xbs,Ys).

% roots([node(42,node(35,empty,empty),node(1,empty,empty)),node(2,empty,empty)],Zs).





