viveEn(remy, gusteaus).
viveEn(amelie, chizMilleBar).
viveEn(django, pizzeriaJeSuis).
sabeCocinar(linguini, ratatouille, 3).
sabeCocinar(linguini, sopa, 5).
sabeCocinar(colette, salmonRosado, 9).
sabeCocinar(horst, ensaladaRusa, 8).
trabajaEn(linguini, gusteaus).
trabajaEn(colette, gusteaus).
trabajaEn(horst, gusteaus).
trabajaEn(skimer, gusteaus).
trabajaEn(amelie, cafeDes2Moulins).

estaEnMenu(Plato, Restaurante) :- trabajaEn(Cocinero, Restaurante), sabeCocinar(Cocinero, Plato, _).

cocineBien(Platos, Cocinero) :- sabeCocinar(Cocinero, Plato, Nivel), Nivel > 7.
cocineBien(Plato Cocinero) :- tutor(Cocinero, Tutor), cocineBien(Plato, Tutor).
tutor(linguini, Tutor) :- trabajaEn(linguini, Lugar), viveEn(Tutor, Lugar).
tutor(skimer, amelie).
cocinaBien(Plato, remy) :- sabeCocinar(_,Plato,_).

chef(Cocinero,Resto) :- trabajaEn(Cocinero, Resto), cumpleCondiciones(Cocinero,Resto).
cumpleCondiciones(Cocinero,Resto) :- forall(estaEnMenu(Plato, Resto), cocinaBien(Plato, linguini)).
cumpleCondiciones(Cocinero, _) :- findall(Nivel, sabeCocinar(Cocinero, _, Nivel), Lista), sumlist(Lista,Total), Total >= 20.

encargado(Plato, Persona, Resto) :- experienciaDe( Plato, Persona, Resto, Experiencia),
forall(experienciaDe(Plato, _, Resto, OtraExperiencia), Experiencia >= OtraExperiencia).

forall((experienciaDe(Plato,OtraPersona,Resto,OtraExperiencia), OtraPersona \=  Persona), Experiencia > OtraExperiencia)

experienciaDe(Plato, Persona, Resto, Experiencia) :- sabeCocinar(Persona, Plato, Experiencia), trabajaEn(Persona, Resto).

esSaludable(NombrePlato) :- plato(NombrePlato, TipoPlato), cantCalorias(TipoPlato, Calorias) Calorias < 75.

cantCalorias(entrada(Ingredientes), Total) :- length(Ingredientes,Cant), Total is Cant * 15.
cantCalorias(principal(Guarnicion, Minuta), Total) :- caloriasGuarnicion(Guarnicion, Cant), Total is (5 * Minutos) + Cant.
cantCalorias(postre(Calorias), Calorias).

caloriasGuarnicion(papasFrias, 50).
caloriasGuarnicion(pure, 20).
caloriasGuarnicion(ensalada, 0).

reseñaPastilla(Critico, Restaurante) :- restaurante(Restaurante),
not(viveEn(_, Restaurante)),
criterioCritico(Criterio, Restaurante).

criterioCritico(ontanEgo, Resto) :- esEspecialista(ratatouille, Resto).
criterioCritico(cormillot, Resto) :- forall(estaEnMenu(Plato,Resto), esSaludable(Plato)).
criterioCritico(martiniano, Resto) :- esChef(Cocinero, Resto), 
not((esChef(OtroCocinero,Resto), OtroCocinero \= Cocinero))

esEspecialista(Plato,Resto) :- forall(trabajaEn(Persona,Resto), cocinaBien(Plato,Persona)).
