% Predicados para cruzar pasillos
cruzarP(pasillo(X,Modo),Palancas,Seguro):-
	Modo = regular,
	memberchk((X,arriba),Palancas),
	Seguro=seguro.

cruzarP(pasillo(X,Modo),Palancas,Seguro):-
	Modo = regular,
	memberchk((X,abajo),Palancas),
	Seguro=muerte.

cruzarP(pasillo(X,Modo),Palancas,Seguro):-
	Modo = de_cabeza,
	memberchk((X,arriba),Palancas),
	Seguro=muerte.

cruzarP(pasillo(X,Modo),Palancas,Seguro):-
	Modo = de_cabeza,
	memberchk((X,abajo),Palancas),
	Seguro=seguro.

% Predicados para cruzar mapas

% Cruzar en caso de que sea un pasillo
cruzar(Mapa,Palancas,Seguro):-
	esPasillo(Mapa),
	cruzarP(Mapa,Palancas,Seguro).

% Cruzar en caso de que sea una junta
cruzar(Mapa,Palancas,Seguro):-
	esJunta(Mapa),
	Mapa=junta(SubMapa1,SubMapa2),
	cruzar(SubMapa1, Palancas, Seguro1),
	cruzar(SubMapa2, Palancas, Seguro2),
	ySeguro(Seguro1,Seguro2,Seguro).

% Cruzar en caso de que sea una bifurcacion
cruzar(Mapa,Palancas,Seguro):-
	esBifurcacion(Mapa),
	Mapa=bifurcacion(SubMapa1,SubMapa2),
	cruzar(SubMapa1,Palancas,Seguro1),
	cruzar(SubMapa2,Palancas,Seguro2),
	oSeguro(Seguro1,Seguro2,Seguro).

% Verificar que tipo de mapa es
esPasillo(X):- functor(X,pasillo,2).
esJunta(X):- functor(X,junta,2).
esBifurcacion(X):- functor(X,bifurcacion,2).

% Verifica si Ele pertenece a una lista
%obtenerClave(Ele,[H|_]):-
%	Ele=H.
%obtenerClave(Ele,[_|T]):-
%	obtenerClave(Ele,T).

% Y logico para Seguro
%  seguro /\ seguro == seguro
%  muerte en cualquier otro caso
ySeguro(S1,S2,S):-
	S1=seguro,
	S2=seguro,
	S=seguro.

ySeguro(_,_,S):-
	S=muerte.

% O logico para Seguro
%  seguro si alguno de los dos es seguro
%  muerte en cualquier otro caso
oSeguro(S1,_,S):-
	S1=seguro,
	S=seguro.

oSeguro(_,S2,S):-
	S2=seguro,
	S=seguro.

oSeguro(_,_,S):-
	S=muerte.
% Verificar si sin importar que combinacion de Palancas, un mapa 
% siempre es cruzable de manera segura
siempre_seguro(Mapa):-
	esPasillo(Mapa),fail.

% Si el mapa es una junta, sus submapas deben ser siempre_seguro
siempre_seguro(Mapa):-
	esJunta(Mapa),
	Mapa=junta(SubMapa1,SubMapa2),
	siempre_seguro(SubMapa1),
	siempre_seguro(SubMapa2).

siempre_seguro(Mapa):-
	esBifurcacion(Mapa),
	Mapa=bifurcacion(SubMapa1,SubMapa2),
	esPasillo(SubMapa1),
	esPasillo(SubMapa2),
	SubMapa1=pasillo(X,regular),
	SubMapa2=pasillo(Y,de_cabeza),
	X==Y.

siempre_seguro(Mapa):-
	esBifurcacion(Mapa),
	Mapa=bifurcacion(SubMapa1,SubMapa2),
	esPasillo(SubMapa1),
	esPasillo(SubMapa2),
	SubMapa2=pasillo(X,regular),
	SubMapa1=pasillo(Y,de_cabeza),
	X==Y.

% Si el mapa es una bifurcacion, sus submapas deben ser siempre_seguro
siempre_seguro(Mapa):-
	esBifurcacion(Mapa),
	Mapa=bifurcacion(SubMapa1,SubMapa2),
	siempre_seguro(SubMapa1),
	siempre_seguro(SubMapa2).

% Entrada desde archivo
leer(Mapa):-
	read(A),
	see(A),
	read(Mapa),
	seen.
