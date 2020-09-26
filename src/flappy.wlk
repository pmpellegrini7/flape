import wollok.game.*
import obstacles.*

object flappy {
	
	const  fallSpeed = 300
	var image = 'flappy.png'
	var position = game.at(6,10)
	
	// Wollok
	method image() =  image
	method position() { return position }
	method position(newPosition) { position = newPosition }
	method fallSpeed() = fallSpeed
	
	method fall() {
		self.position(game.at(position.x(), position.y() - 1))
		image = 'flappy.png'
	}
	
	method fly() {
		self.position(game.at(position.x(), position.y() + 2))
		image = 'flappy2.png'
	}
	
}
