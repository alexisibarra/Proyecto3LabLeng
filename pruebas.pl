prueba:-	
	Mapa=junta(
		bifurcacion(
			pasillo(a, de_cabeza), 
			pasillo(a, regular)
		), 
		bifurcacion(
			pasillo(b, de_cabeza), 
			pasillo(b, regular)
		)
	),
	siempre_seguro(Mapa),!.

% Probar con entrada desde archivo
prueba(Seguro):-
	write('Mapa:'),
	leer(Mapa),
	write('Palancas:'),
	leer(Claves),
	cruzar(
		Mapa,
		Claves,
		Seguro
	),!
	.
