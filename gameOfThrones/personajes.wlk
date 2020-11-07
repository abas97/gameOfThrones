class Personajes{
	var property casa
	var property conyugues
	var property estaVivo
	var property acompanantes=[]
	var property personalidad
	
	method mePuedoCasarCon(personaje){
		return casa.puedenCasarce(self,personaje) && personaje.mePuedoCasarCon(self)
	}
	
	method casarse(personaje){
		if(self.mePuedoCasarCon(personaje)){
			conyugues.add(personaje)
		}
		else{
			throw new ExcepcionDeConyugue (message = "no se pudieron casar")
		}
	}
	
	method riquezaDeTodosLosAliados(){
		return self.aliados().sum({aliado=>aliado.miPatrimonio()})
	}
	
	method tieneTodosLosConyuguesDeCasaRica(){
		return conyugues.all({conyugue=>conyugue.casa().esRica()})
	}
	
	method miPatrimonio(){
		return casa.patrimonioPorPersonaje()
	}
	method aliados(){
		return acompanantes + casa.miembros()
	}
	
	method estaSolo(){
		return acompanantes.size() == 0
	}
	
	method algunAliadoPeligroso(){
		self.aliados().any({aliado=>aliado.esPeligroso()})
	}
	
	method esPeligroso(){
		return self.riquezaDeTodosLosAliados() >=10000 && self.tieneTodosLosConyuguesDeCasaRica()
	}
}

class Casa {
	var property patrimonio
	var property nombreCiudad
	var property miembros
	
	method puedenCasarce(personaje,posibleConyugue)
	
	method esRica(){
		return patrimonio>1000
	}
	
	method patrimonioPorPersonaje(){
		return patrimonio / miembros.size()
	}
}

object lannister inherits Casa{ 
	override method puedenCasarce(personaje,posibleConyugue){
		return personaje.conyugues().size() < 1
	}
}

object strak inherits Casa{ 
	override method puedenCasarce(personaje,posibleConyugue){
		return personaje.casa() != posibleConyugue.casa()
	}
}

object guardiaDeLaNoche inherits Casa{ 
	override method puedenCasarce(personaje,posibleConyugue){
		return false 
	}
}

class Dragones{
	method esPeligroso(){
		return true
	}
	method miPatrimonio(){
		return 0
	}
	
}
class Lobo{
	var tipoDeLobo
	
	method esPeligroso(){
		return tipoDeLobo == "hungaro"
	}
	method miPatrimonio(){
		return 0
	}
}

object sutiles{
	s
}

class ExcepcionDeConyugue inherits Exception{}