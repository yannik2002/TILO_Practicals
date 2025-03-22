
%%% link für breitensuche %%%
% https://askuri.github.io/PrologBFS/wasm/



% die fünf relationen eines NEA = {Z, Sigma, Delta, Z0, E}


% NEA für sprache der bin wörter, die mit 010 enden (s. skript)

% Z (endliche zustandsmenge)
zustand(z0).
zustand(z1).
zustand(z2).
zustand(z3).


% Sigma (eingabealphabet)
sigma(0).
sigma(1).


% delta(AktZ,A,NeuZ) (transitionen)
% AktZ der aktuelle zustand, A das symbol (terminal) und NeuZ der neue zustand
delta(z0,0,z0).
delta(z0,1,z0).
delta(z0,0,z1).
delta(z1,1,z2).
delta(z2,0,z3).


% Z0 (startzustandmenge)
start(z0).


% E (endzustandsmenge)
end(z3).



%%% NICHT ÄNDERN %%%
% dieser teil ist für jeden NEA gleich (s. definitionen im skript/klausurblatt)


% delta_stern(AktZ,Ws,NeuZ): vom AktZ kommt man mit dem wort Ws zum NeuZ
% wird rekursiv aufgebaut, man geht einen schritt mit delta und macht ab da mit delta_stern weiter
% mit dem leeren wort kommt man vom AktZ zum AktZ
% man kommt von dem AktZ mit dem vordersten terminal zu einem ZwischenZ, von dem aus
% man mit dem restwort Ws wieder rekursiv über delta_stern zum NeuZ kommt,
% bis man alle terminale abgearbeitet hat und bei NeuZ angekommen ist
delta_stern(AktZ,[],AktZ).
delta_stern(AktZ,[A|Ws],NeuZ) :- delta(AktZ,A,ZwischenZ), delta_stern(ZwischenZ,Ws,NeuZ), sigma(A), sigma_stern(Ws).


% sigma_stern(Ws): Ws ist ein wort über sigma_stern
% leeres wort wird akzeptiert, nehme so lange zeichen vorne weg bis das wort leer ist
% beschreibt ALLE wörter die man mit den terminalen aus dem eingabealphabet beschreiben kann
sigma_stern([]).
sigma_stern([A|Ws]):- sigma_stern(Ws), sigma(A).


% lvonN(Ws): Ws ist ein wort in der sprache des oben beschriebenen NEAs
% nimmt den start- und endzustand und sucht den produktionspfad mit delta_stern
lvonN(Ws) :- sigma_stern(Ws), start(Vstart), end(Vend), delta_stern(Vstart,Ws,Vend).



