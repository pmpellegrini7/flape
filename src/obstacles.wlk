import wollok.game.*
import flappy.*
import flappyGame.*

class Obstacle {

	// image(100, 300)

	var property p // Posicion
	var property cA // Area de colision 
	const image = 'obstacle.png'
	
	method image() = image
	method position() = p
	method position(newPosition) { p = newPosition }
	method cA() = cA
	
}

object obstacles {
	
	const collection = [
		[ 
			// Obstaculo inicial
			new Obstacle(p = game.at(20, 10), cA = (10..20)), 
			new Obstacle(p = game.at(20,-15), cA = (-15..4))
		]
	]
	
	// Con esto indico la posicion de la parte de arriba y la parte de abajo de un obstaculo
	// dejando un hueco para que el pajaro pueda pasar.
	const obstaclesPositions = [ 
	//  TOP  BOTTOM en el eje Y 
		[14,  -11],
		[8,   -17], 
		[5,   100],
		[100,  -9]
	]
	
/*
 * 		[
			new Obstacle(p = game.at(null,10)),
			new Obstacle(p = game.at(null,-15))			
		],
		[
			new Obstacle(p = game.at(null,14)),
			new Obstacle(p = game.at(null,-11))			
		],
		[
			new Obstacle(p = game.at(null,8)),
			new Obstacle(p = game.at(null,-17))			
		],
		[
			new Obstacle(p = game.at(null,4))
		]
	 * 
 */
	method getCollection() = collection
		
	method render() {
		const posY = obstaclesPositions.anyOne()
		const topPiece = posY.first()
		const bottomPiece = posY.last()
		
		const newObstacle = [
			// Parte de arriba
			new Obstacle( p = game.at(20, topPiece), cA = (topPiece..20) ),
			
			// Parte de abajo
			new Obstacle( p = game.at(20, bottomPiece), cA = (bottomPiece..bottomPiece+20) )
		]
		
		collection.add(newObstacle)
		newObstacle.forEach({ piece => game.addVisual(piece) })
	}
	
	method behaviour(piece) {
		const posX = piece.position().x()
		const posY = piece.position().y()
		
		// Realiza el movimiento del obstaculo
		piece.position(game.at(posX - 1, posY))
		
		// Cuando el obstaculo desaparece de la pantalla se lo destruye
		if(posX == -3) {
			game.removeVisual(piece)
			console.println('Piece was destroyed >:c')
		}
		
		// Cuando se detecta la colision del pajaro en una de las partes se termina el juego
		if(flappy.position().x() == posX && piece.cA().contains(flappy.position().y())) {
			game.clear()
			flappyGame.showMenu()
		}
		
	}
	
}