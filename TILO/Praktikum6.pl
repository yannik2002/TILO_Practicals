
%%% Link für Breitensuche %%%
% https://askuri.github.io/PrologBFS/wasm/

% PDA ist ein 6-Tupel
% M = {Z (Zustaende),
%      S (Sigma/ Eingabealphabet),
%      G (Gamma/ Kelleralphabet),
%      d (Delta/ Transitionsrelationen),
%      z0 (Startzustand),
%      # (Kellersymbol) }
	   
% a^2n b^n | n >= 0, DPDA


% Z
zustand(z0).
zustand(z1).

%zustand(z0).
%zustand(z1).
%zustand(z2).

% S
sigma(a).
sigma(b).

% G
gamma(a).
gamma(b).
gamma(#).

% z0
start(z0).

% Kellersymbol
kellersymbol(#).

% d delta(AktZ, W, G, NeuZ, Gs) Transitionsrelation
% AktZ = aktueller Zustand, W = gelesener Buchstabe, G = gelesener bzw. gelöschter Kellerbuchstabe, NeuZ = neuer Zustand
% und Gs = Wort aus Kellerbuchstaben, welches nach der Transition auf den Stack getan wird

delta(z0,a,#,z0,[a,a,#]).
delta(z0,a,a,z0,[a,a,a]).
delta(z0,b,a,z1,[]).
delta(z1,b,a,z1,[]).
delta(z1,nix,#,_,[]).

%delta(z0, nix, #, _, []). % leeres Wort
%delta(z0, a, #, z1, [#]). % erstes a gelesen, nichts auf Keller gelegt
%delta(z1, a, #, z0, [a,#]). % zweites a wird gelesen und auf den PD gelegt
%delta(z0, a, a, z1, [a]). % weiteres "erstes" a, das nicht auf den Keller gelegt wird
%delta(z1, a, a, z0, [a,a]). % zweites a, das auf den PD gelegt wird
%delta(z0, b, a, z2, []). % das erste b wird verglichen
%delta(z2, b, a, z2, []). % weitere b's vergleichen
%delta(z2, nix, #, _, []). % fertig mit dem vergleichen -> Eingabe und Stack sind leer




%%% Ab hier fuer jeden PDA gleich %%%

% AktZ, A, G sind die Lesenden
% man kommt von delta zu es, wenn AktZ im Register steht
% wenn A oben auf der Eingabe steht
% wenn G oben auf dem PushDown steht

% es (Einzelschrittrelation)
es(AktZ, [A|Ws], [G|Stacks], NeuZ, Ws, StackNeus) :- delta(AktZ, A, G, NeuZ, StackAdds), 
							append(StackAdds, Stacks, StackNeus).
% die Eingabe Ws ist egal und bleibt erhalten
es(AktZ, Ws, [G|Stacks], NeuZ, Ws, StackNeus) :- delta(AktZ, nix, G, NeuZ, StackAdds), 
							append(StackAdds, Stacks, StackNeus).
														

								
% es_plus(AktZ, altesWort, alterStack, NeuZ, neuesWort, neuerStack): transitiver Abschluss der Einzelschrittrelation darüber
% Im Grunde wie beim vorigen Praktikum. Man soll mit der Einzelschrittrelation von diesem Zustand, Wort und Stackzustand
% in den neuen Zustand NeuZ mit dem neuen Wort neuesWort und mit dem neuen Stackzustand neuerStack kommen
% erster Fall / Basisfall: es gibt eine Transition, die direkt zum gewünschten Ziel führt.
es_plus(AktZ, Ws, Stacks, NeuZ, WNeus, StackNeus) :- es(AktZ, Ws, Stacks, NeuZ, WNeus, StackNeus).

% zweiter Fall: es gibt keine Transitionen, die direkt zum gewünschten Zustand führen. Mache Umweg über Zwischenzustände für Zustand, Wort und Stack
es_plus(AktZ, Ws, Stacks, NeuZ, WNeus, StackNeus):-
         es(AktZ, Ws, Stacks, FolgeZ, Wtemps, Stacktemps), es_plus(FolgeZ, Wtemps, Stacktemps, NeuZ, WNeus, StackNeus).											
														
														

% sigma_stern(Ws): Ws ist ein Wort von Sigma_stern des Alphabets welches oben beschrieben ist
% Leeres Wort wird akzeptiert, nehme so lange Zeichen vorne weg bis das Wort leer ist
sigma_stern([]).
sigma_stern([A|Ws]):- sigma_stern(Ws), sigma(A).

% lvonM(Ws): Ws ist ein Wort der vom oben definierten PDA erzeugten Sprache
% Definition vom Skript, wenn man für das Wort Ws mit Kellersymbol auf dem Stack => leeres Wort und leerer Stack, dann ist Wort in L
lvonM(Ws) :- sigma_stern(Ws), start(AktZ), kellersymbol(#), es_plus(AktZ, Ws, [#], _, [], []).


rS([]). %S -> epsilon
rS([a,a|Ws]) :- rS(As), append(As, [b], Ws). %S -> aaSb

















