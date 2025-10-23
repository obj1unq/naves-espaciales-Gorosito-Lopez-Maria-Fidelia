class Nave{
	var property velocidad = 0
	var property carga = 0
	
	method propulsar(){
		const velocidadPostPropulsada = velocidad + 20000
		if(velocidadPostPropulsada <= 300000){
			velocidad =  velocidadPostPropulsada
		}else{
			velocidad = 300000
		}
	}

	method preparar(){
		const velocidadPostPropulsada = velocidad + 15000
		if(velocidadPostPropulsada <= 300000){
			velocidad =  velocidadPostPropulsada
		}else{
			velocidad = 300000
		}
	}

	method recibirAmenaza(){

	}

	method sufrirAtaque(){
		self.recibirAmenaza()
		self.propulsar()
	}
}

class NaveDeCarga inherits Nave {
	var property estaCerradaAlVacio = false 
	method sobrecargada() = carga > 100000

	method excedidaDeVelocidad() = velocidad > 100000

	override method recibirAmenaza() {
		carga = 0
	}
	
	override method preparar(){
		self.estaCerradaAlVacio(true)
		super()

	}
}


class NaveDeResiduosRadiactivos inherits NaveDeCarga  {

	override method recibirAmenaza() {
		velocidad = 0

	}


}




class NaveDePasajeros inherits Nave  {

	var property alarma = false
	const cantidadDePasajeros = 0

	method tripulacion() = cantidadDePasajeros + 4

	method velocidadMaximaLegal() = 300000 / self.tripulacion() - if (cantidadDePasajeros > 100) 200 else 0

	method estaEnPeligro() = velocidad > self.velocidadMaximaLegal() or alarma

	override method recibirAmenaza() {
		alarma = true
	}



}

class NaveDeCombate inherits Nave  {
	var property modo = reposo
	const property mensajesEmitidos = []

	method emitirMensaje(mensaje) {
		mensajesEmitidos.add(mensaje)
	}
	
	method ultimoMensaje() = mensajesEmitidos.last()

	method estaInvisible() = velocidad < 10000 and modo.invisible()

	override method recibirAmenaza() {
		modo.recibirAmenaza(self)
	}
	override method preparar(){
		if(modo.invisible()){
		 self.emitirMensaje("Volviendo a la base")
		}else{
			self.emitirMensaje("Saliendo en mision")
			self.modo(ataque)
		}
		super()
		
	}

	
}

object reposo {

	method invisible() = false

	method recibirAmenaza(nave) {
		nave.emitirMensaje("¡RETIRADA!")
	}

}

object ataque {

	method invisible() = true

	method recibirAmenaza(nave) {
		nave.emitirMensaje("Enemigo encontrado")
	}

}
