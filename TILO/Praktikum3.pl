
% AUFGABE 1:

% linListe(Xs) : ueberprueft ob Xs eine gueltige Liste ist, beliebige Listeneintraege
linListe(nil).
linListe(list(_,Xs)) :- linListe(Xs).

% (Hilfsrelation)
% app(Xs,Ys,Zs): Xs + Ys = Zs, in der genauen Reihenfolge (LISTENKONKATENATION)
app(nil,Ys,Ys).
app(list(X,X1s),Ys,list(X,X2s)) :- app(X1s,Ys,X2s).

% member2(X,Ys) : Element X ist in Liste Ys enthalten
% Falls der Head von Ys gleich dem gesuchten Element ist.
% Falls der Head nicht gleich dem gesuchten Element ist wird weitergesucht.
% Falls X gefunden wurde => true
member2(X,list(X,Ys)) :- linListe(Ys).
member2(X,list(_,Ys)):- member2(X,Ys), linListe(Ys).

% Zum testen : infix(list(b,list(c,nil)), list(a,list(b,list(c,list(d,nil))))).
% infix(Xs,Ys): Liste Xs ist in Liste Ys drin
% Anfs + Xs + Ends = Ys
% Anfs ist die moegliche Liste vor Xs
% Ends ist die moegliche Liste nach Xs
% Gibt es eine Moeglichkeit, dass die Liste Xs in Zusammensetzung mit einer moeglichen
% davor und dahinter stehenden Liste die Liste Ys ergibt? Wenn ja ist infix true
infix(Xs,Ys) :- app(Rs,Ends,Ys), app(Anfs,Xs,Rs), 
	        linListe(Anfs), linListe(Xs), linListe(Ends).
			
			
% attach(Xs,X,Ys) : Liste Ys ist die liste Xs verlaengert um X
% Wie append, nur dass die anzuhaengende Liste nur ein Element hat
attach(Xs,X,Ys) :- app(Xs,list(X,nil),Ys), linListe(Xs).


% rev(Xs,Ys) : Liste Ys ist die gespiegelte Liste Xs
% Zum testen: rev(list(a,list(b,list(c,list(d,nil)))),Z).
% Man nimmt bei Xs ein Element X vorne weg und bei Ys dasselbe Element X hinten weg mit attach (Rs ist Ys ohne letztes Element)
% dies macht man so lange bis beide Listen nil also leer sind, Xs und Rs also irgendwann nil
% findet man irgendwo zwei verschiedene Elemente => false (Falls man zwei Baeume einsetzt)
% Somit wird geprueft: Ist das erste Element der ersten Liste immer gleich dem letzten Element der zweiten Liste?
rev(nil,nil).
rev(list(X,Xs),Ys) :- rev(Xs,Rs), attach(Rs,X,Ys), linListe(list(X,Xs)), linListe(Ys).



% AUFGABE 2:

% construct(Root,Lb,Rb,Xneub): Xneub ist der Baum mit Wurzelbeschriftung Root, linkem Teilbaum Lb und rechtem Teilbaum Rb.
% Erstellt einen Baum mit den gegebenen Variablen und testet auf Gleichheit des erstellten Baumes mit Xneub
construct(Root,Lb,Rb,Xneub) :- binbaum(node(Root,Lb,Rb)), node(Root,Lb,Rb) = Xneub.		

% Ueberpruefung
binbaum(empty).
binbaum(node(_,Lb,Rb)) :- binbaum(Lb), binbaum(Rb).

% add(X,Y,E) : X + Y = E, Hilfsrelation fuer knotenanz
% true wenn E = X + Y
add(o,Y,Y).
add(s(X),Y,s(E)):- add(X,Y,E).

% knotenanz(Xb,N) : N ist die Anzahl der Knoten des Baumes Xb
% Zum testen: knotenanz(node(a,node(b,empty,empty),node(c,node(e,empty,empty),empty)),Z).
% Starte bei Wurzel erhoehe N um 1 und rufe Knotenanz auf die linken und rechten Teilbäume auf
% Wenn Wurzel vorhanden, mindestens ein Knoten, deshalb s(N)
% Die jeweiligen Anzahlen links und rechts bekommt man durch Addition
% Sind die Anzahlen bei allen rekursiven Aufrufen 0, wenn man alle Blaetter erreicht hat => true
knotenanz(empty,o).
knotenanz(node(X,Lb,Rb), s(N)) :- binbaum(node(X,Lb,Rb)),add(N1, N2, N), knotenanz(Lb, N1), knotenanz(Rb, N2).
											
										
