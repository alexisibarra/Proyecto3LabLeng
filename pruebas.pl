prueba(Seguro):-	
	cruzar(
		bifurcacion(
			bifurcacion(
				pasillo(a, de_cabeza), 
				pasillo(a, regular)
			), 
			bifurcacion(
				pasillo(a, de_cabeza), 
				pasillo(a, regular)
			)
		),
		[(a,arriba)],
		%[(a,abajo)],
		Seguro
	)
	.

% Probar con entrada desde archivo
pruebaA(Seguro):-
	write('Mapa:'),
	leer(Mapa),
	write('Palancas:'),
	leer(Claves),
	cruzar(
		Mapa,
		Claves,
		Seguro
	)
	.

pruebaP(Palancas):-
	write('Mapa:'),
	leer(Mapa),
	cruzar(
		Mapa,
		Palancas,
		muerte	
	)
	.
