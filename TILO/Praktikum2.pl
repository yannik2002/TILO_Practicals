maennlich(albert).
maennlich(leopold).
maennlich(alexander).
maennlich(rupprecht).
maennlich(heinrich).
maennlich(moritz).
maennlich(hans).
weiblich(victoria).
weiblich(helene).
weiblich(beatrice).
weiblich(alice).
weiblich(elizabeth).

% elternteil(X,Y) X ist Elternteil von Y
elternteil(albert,leopold).
elternteil(albert,beatrice).
elternteil(victoria,leopold).
elternteil(victoria,beatrice).
elternteil(leopold,alice).
elternteil(helene,alice).
elternteil(alice,rupprecht).
elternteil(alexander,rupprecht).
elternteil(beatrice,moritz).
elternteil(beatrice,hans).
elternteil(beatrice,elizabeth).
elternteil(heinrich,moritz).
elternteil(heinrich,hans).
elternteil(heinrich,elizabeth).

% vater(X,Y) X ist Vater von Y
vater(X,Y):- elternteil(X,Y), maennlich(X).

% mutter(X,Y) X ist Mutter von Y
mutter(X,Y):- elternteil(X,Y), weiblich(X).

% sohn(X,Y) X ist Sohn von Y
sohn(X,Y):- elternteil(Y,X), maennlich(X).

% tochter(X,Y) X ist Tochter von Y
tochter(X,Y):- elternteil(Y,X), weiblich(X).

% bruder(X,Y) X ist Bruder von Y
% X und Y haben selbe Mutter und selben Vater, X maennlich, X\=Y (man kann nicht sein eigener Bruder sein)
bruder(X,Y):- mutter(VMutter,X), mutter(VMutter,Y),
            vater(VVater,X), vater(VVater,Y), maennlich(X), X\=Y.

% schwester(X,Y) X ist Schwester von Y
% X und Y haben selbe Mutter und selben Vater, X weiblich, X\=Y (man kann nicht seine eigene Schwester sein)
schwester(X,Y):- mutter(VMutter,X), mutter(VMutter,Y),
            vater(VVater,X), vater(VVater,Y), weiblich(X), X\=Y.

% onkel(X,Y) X ist Onkel von Y
% X ist Bruder vom Elternteil von Y
onkel(X,Y):- elternteil(VElternteil,Y), bruder(X,VElternteil).

% tante(X,Y) X ist Tante von Y
% X ist Schwester vom Elternteil von Y
tante(X,Y):- elternteil(VElternteil,Y), schwester(X,VElternteil).

% geschwister(X,Y) X und Y sind Geschwister
% Wie Bruder und Schwester nur ohne Geschlecht
geschwister(X,Y):- mutter(Mutter,X), mutter(Mutter,Y),
            vater(Vater,X), vater(Vater,Y), X\=Y.

% cousine(X,Y) X ist Cousine von Y
% Elternteil von Tochter X ist Geschwister von Elternteil2 von Y
cousine(X,Y):- tochter(X, Elternteil1), geschwister(Elternteil1,Elternteil2),
            elternteil(Elternteil2,Y).
            
% cousin(X,Y) X ist Cousin von Y
cousin(X, Y):- sohn(X,Elternteil1), geschwister(Elternteil1,Elternteil2), 
elternteil(Elternteil2,Y).

% cousin2(X,Y) X ist Cousin von Y
cousin2(X,Y):- sohn(X, Elternteil1), onkel(Elternteil1, Y).
cousin2(X,Y):- sohn(X, Elternteil1), tante(Elternteil1, Y).

% grossvater(X,Y) X ist Grossvater von Y
grossvater(X,Y):- vater(X,Elternteil), elternteil(Elternteil,Y).


