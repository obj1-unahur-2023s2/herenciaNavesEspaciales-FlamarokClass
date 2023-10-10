
class Nave {
	var velocidad = 0 // expresado en km/seg
	var direccion   // respecto al Sol
	var combustible = 0
	
	method velocidad() = velocidad
	
	method acelerar(cuanto) {
		velocidad= 100000.min(velocidad + cuanto)
	}
	
	method desacelerar(cuanto) {
		velocidad = 0.max(velocidad + cuanto)
	}

	method irHaciaElSol() {
		direccion = 10
	}
	
	method escaparDelSol() {
		direccion = -10
	}
	
	method ponerseParaleloAlSol() {
		direccion = 0
	}
	
	method acercarseUnPocoAlSol() {
		direccion = 10.min(direccion +1)
	}
	
	method alejarseUnPocoDelSol() {
		direccion = -10.max(direccion -1)
	}
	
	method cargarCombustible(cantidad) {
		combustible += cantidad
	}
	
	method descargarCombustible(cantidad) {
		combustible = 0.max(combustible-cantidad)
	}
	
	
	method prepararViaje() { // Template method
		self.accionAdicionalEnPrepararViaje()
		self.cargarCombustible(30000)
		self.acelerar(5000)
	}
	
	method accionAdicionalEnPrepararViaje() // clase abstracta que creamos ya que en prepararViaje debimos agregarle codigo, no se puede hacer instancia de nave 
	
	method estaTranquila() = combustible >= 4000 and velocidad < 12000 
	
	method recibirAmenaza(){ // template method 
		self.escapar()
		self.avisar()
	} 
	
	method escapar() 
	
	method avisar()
	
	method relajo(){
		return self.estaTranquila() and self.pocaActividad()
	}
	
	method pocaActividad()
	
}


class Baliza inherits Nave{
	var color
	var cambioColorBaliza = false
	
	method color() = color
	
	method cambiarColorDeBaliza(colorNuevo) {
		color = colorNuevo
		cambioColorBaliza = true
	}
	
	override method accionAdicionalEnPrepararViaje() {
		self.cambiarColorDeBaliza("verde")
		self.ponerseParaleloAlSol()
	}
	
	override method estaTranquila() {
		return super() and color != "rojo" 
	}
	
	override method escapar() {
		self.irHaciaElSol()
	}
	
	override method avisar() {
		self.cambiarColorDeBaliza("rojo")
	}
	
	override method pocaActividad() {
		return not cambioColorBaliza 
	}
	
	
} 



class Pasajero inherits Nave {
	var pasajeros
	var raciones
	var bebidas
	var descargadas = 0
	
	method pasajeros() = pasajeros
	method raciones() = raciones
	method bebidas() = bebidas
	
	method cargarRacion(cantidad){
		raciones += cantidad
	}
	
	method descargarRacion(cantidad){
		raciones = 0.max(raciones - cantidad)
		descargadas += cantidad
	}
	
	method cargarBebida(cantidad){
		bebidas += cantidad
	}
	
	method descargarBebida(cantidad){
		bebidas = 0.max(bebidas - cantidad)
	}
	
	override method accionAdicionalEnPrepararViaje(){
		self.cargarRacion(pasajeros*4)
		self.cargarBebida(pasajeros*6)
		self.acercarseUnPocoAlSol()
	}
	
	override method escapar() {
		self.acelerar(velocidad)
	}
	
	override method avisar() {
		self.descargarRacion(pasajeros)
		self.descargarBebida(pasajeros*2)
	}
	
	override method pocaActividad() {
		return descargadas <= 50
	}
}



class Combate inherits Nave {
	var visible = true
	var misilesDesplegados = false  
	const mensajes = []
	method mensajes() = mensajes
	
	method ponerseVisible() {
		visible = true
	}
	
	method ponerseInvisible() {
		visible = false
	}
	
	method estaInvisible() = not visible
	
	
	method desplegarMisiles() {
		misilesDesplegados = true
	}
	
	method replegarMisiles() {
		misilesDesplegados = false 
	}
	
	method misilesDesplegados() = misilesDesplegados
	
	
	method emitirMensaje(mensaje) {
		mensajes.add(mensaje)
	} 
	
	method mensajesEmitidos() {
		return mensajes.size() // cantidad de mensajes emitidos
	}
	
	method primerMensajeEmitido() {
		if(mensajes.isEmpty()){
			self.error("No hay mensajes emitidos")
		}
		return mensajes.first()		
	}
	
	method ultimoMensajeEmitido() {
		if(mensajes.isEmpty()){
			self.error("No hay mensajes emitidos")
		}
		return mensajes.last()		
	}
	
	method esEscueta() {
		return mensajes.all({m=> m.size() <= 30}) // cuenta el largo de cada objeto, no de la lista
	}
	
	method esEscueta1() {
		return not mensajes.any({m=> m.size() > 30})
	}
	
	method emitioMensaje(mensaje) {
		return mensajes.contains(mensaje)
	}
	
	override method accionAdicionalEnPrepararViaje(){
		self.ponerseVisible()
		self.replegarMisiles()
		self.acelerar(15000)
		self.emitirMensaje("Saliendo en misión") 
		self.acelerar(15000)
	}
	
	override method estaTranquila() {
		return super() and not misilesDesplegados
	}
	
	/*
	Antes del metodo  accionAdicionalEnPrepararViaje() y prepararViaje era el abstracto
	override method prepararViaje() { // polimórfico en las subClases, se puede poner como metodo abstracto, haciendo que la super clase sea abstracta, ()
		self.ponerseVisible()
		self.replegarMisiles()
		self.acelerar(15000)
		self.emitirMensaje("Saliendo en misión") 
		super()
		self.acelerar(15000)
	}

	*/
	
	override method escapar() {
		self.irHaciaElSol()
		self.irHaciaElSol()
	}
	
	override method avisar() {
		self.emitirMensaje("Amenaza Recibida")
	}
	
	override method pocaActividad() {
		return self.esEscueta()
	}

}	

class Hospital inherits Pasajero{
	var quirofanoPreparados = false
	
	method prepararQuirofano() {
		quirofanoPreparados = true
	}
	
	method quirofanoSinPreparar() {
		quirofanoPreparados = false
	}
	
	method quirofanoPreparados() = quirofanoPreparados
	
	override method estaTranquila() {
		return super() and quirofanoPreparados
	}
	
	override method recibirAmenaza() {
		super()
		self.prepararQuirofano()
	}
}

class Sigilosa inherits Combate {
	
	override method estaTranquila() {
	return super() and visible
	}
	
	override method recibirAmenaza() {
		super()
		self.desplegarMisiles()
		self.ponerseInvisible() 
	}
}



	



// instancia naveDeCombate.prepararViaje() : buscará el metodo en la clase Combate y como no está lo busca en Nave, este ejecuta accionAdicionalEnPrepararViaje()  y self.cargarCombustible(30000), self.acelerar(5000)
// en accionAdicionalEnPrepararViaje, combate hará self.ponerseVisible(), self.replegarMisiles(), self.acelerar(15000), self.emitirMensaje("Saliendo en misión"), self.acelerar(15000) y luego  del metodo prepararViaje() self.cargarCombustible(30000), self.acelerar(5000)

 




