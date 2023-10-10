
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
	
	
	method prepararViaje() 
}


class Baliza inherits Nave{
	var color
	
	method color() = color
	
	method cambiarColorDeBaliza(colorNuevo) {
		color = colorNuevo
	}
	
	override method prepararViaje() {
		color = "verde"
		self.ponerseParaleloAlSol()
		self.cargarCombustible(30000)
		self.acelerar(5000)
	}
} 

class Pasajero inherits Nave {
	var pasajeros
	var raciones
	var bebidas
	
	method pasajeros() = pasajeros
	method raciones() = raciones
	method bebidas() = bebidas
	
	method cargarRacion(cantidad){
		raciones += cantidad
	}
	
	method descargarRacion(cantidad){
		raciones = 0.max(raciones - cantidad)
	}
	
	method cargarBebida(cantidad){
		bebidas += cantidad
	}
	
	method descargarBebida(cantidad){
		bebidas = 0.max(bebidas - cantidad)
	}
	
	override method prepararViaje() {
		self.cargarRacion(pasajeros*4)
		self.cargarBebida(pasajeros*6)
		self.acercarseUnPocoAlSol()
		self.cargarCombustible(30000)
		self.acelerar(5000)
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
	
	override method prepararViaje() { // polimórfico en las subClases, se puede poner como metodo abstracto, haciendo que la super clase sea abstracta, ()
		self.ponerseVisible()
		self.replegarMisiles()
		self.acelerar(15000)
		self.emitirMensaje("Saliendo en misión") 
		self.cargarCombustible(30000)
		self.acelerar(5000)
		self.acelerar(15000)
	}
	
}





/*`ponerseVisible()`, `ponerseInvisible()`, `estaInvisible()`: puede estar visiblo o invisible.
	- `desplegarMisiles()`, `replegarMisiles()`, `misilesDesplegados()`: los misiles pueden, o no, estar desplegados.
	- `emitirMensaje(mensaje)`, `mensajesEmitidos()`, `primerMensajeEmitido()`, `ultimoMensajeEmitido()`, `esEscueta()`, `emitioMensaje(mensaje)`.  
	 Las naves de combate tienen la capacidad de emitir mensajes, cada mensaje se representa como un String, p.ej. "Llegando a Saturno". Una nave de combate es _escueta_ si no emitió ningún mensaje de más de 30 caracteres. */

 




