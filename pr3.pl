%Predicados para cruzar pasillos
cruzarP(pasillo(X,Modo),Palancas,Seguro):-
	Modo = regular,
	obtenerClave((X,arriba),Palancas),
	Seguro=seguro.

cruzarP(pasillo(X,Modo),Palancas,Seguro):-
	Modo = regular,
	obtenerClave((X,abajo),Palancas),
	Seguro=muerte.

cruzarP(pasillo(X,Modo),Palancas,Seguro):-
	Modo = de_cabeza,
	obtenerClave((X,arriba),Palancas),
	Seguro=muerte.

cruzarP(pasillo(X,Modo),Palancas,Seguro):-
	Modo = de_cabeza,
	obtenerClave((X,abajo),Palancas),
	Seguro=seguro.

%Predicados para cruzar mapas

%Predicado para cruzar en caso de que sea un pasillo
cruzar(Mapa,Palancas,Seguro):-
	esPasillo(Mapa),
	cruzarP(Mapa,Palancas,Seguro).

cruzar(Mapa,Palancas,Seguro):-
	esJunta(Mapa),
	Mapa=junta(SubMapa1,SubMapa2),
	cruzar(SubMapa1, Palancas, Seguro),
	cruzar(SubMapa2, Palancas, Seguro).

cruzar(Mapa,Palancas,Seguro):-
	esBifurcacion(Mapa),
	Mapa=bifurcacion(SubMapa1,SubMapa2),
	cruzar(SubMapa1,Palancas,Seguro1),
	cruzar(SubMapa2,Palancas,Seguro2),
	oSeguro(Seguro1,Seguro2,Seguro).

esPasillo(X):- functor(X,pasillo,2).
esJunta(X):- functor(X,junta,2).
esBifurcacion(X):- functor(X,bifurcacion,2).

%Verifica si Ele pertenece a una lista
obtenerClave(Ele,[H|_]):-Ele=H.
obtenerClave(Ele,[_|T]):-
	obtenerClave(Ele,T).

existe(_,[]):-!. 
existe(X,[X|_]):-!. 
existe(X,[_|R]):- 
	existe(X,R). 

oSeguro(S1,_,S):-
	S1=seguro,
	S=seguro.

oSeguro(_,S2,S):-
	S2=seguro,
	S=seguro.

oSeguro(_,_,S):-
	S=muerte.

prueba(Seguro):-
	cruzar(
		junta(
			pasillo(a, regular),
			bifurcacion(
				pasillo(b, regular),
				pasillo(c, de_cabeza)
			)
		),
		[(a, arriba), (b, arriba), (c, abajo)],
		Seguro
		).

%cabezaLista(L):-L=[H|T],write(H).

/*probar(submundo):-functor(submundo,Functor,Aridad),Functor=
 Junta: los dos submapas deben cumplirse. True,True
cruzarP(junta(Mapa1,Mapa2),Palanca,seguro):-
 Mapa1 = 
 Mapa2 = 

Bifurcacion: alguno de los dos submapas deben cumplirse . True \/ _
cruzarP(Bifurcacion(Mapa1,Mapa2),Palanca,seguro):-
 Mapa1
 Mapa2
*/
