import wollok.game.*
import flappy.*
import obstacles.*

object flappyGame {
	
	var totalScore = 0
	
	method init() {
		game.width(20)
		game.height(15)
		game.title('Flappy Bird')
		game.boardGround('background.png')
	}
	
	method play() {
		
		self.init()
		
		
		
		// Player
		game.addVisual(flappy)
		
		// Obstacles
		obstacles.getCollection().forEach({
			obstacle => obstacle.forEach({ 
				piece => game.addVisual(piece)
			})
		})
		
		// Score
		game.addVisual(score)
		
		// Events
		keyboard.space().onPressDo({ flappy.fly() })

		// Ticks
		game.onTick(100, 'add score', { 
			game.say( score, 'Puntaje\n' + totalScore.toString()); 
			totalScore += 2
		})
		
		// Creacion de los obstaculos cada 3 segundos
		game.onTick(3000, 'obstacle appear', {
			obstacles.render()
		})
		
		// Caida del pajaro
		game.onTick(flappy.fallSpeed(), 'free fall', {
			flappy.fall()
		})
		
		// Movimiento de los obstaculos
		game.onTick(350, 'obstacles movement', {
			obstacles.getCollection().forEach({ 
				obstacle => obstacle.forEach({ 
					piece => obstacles.behaviour(piece)
				})
			})
		})
		
	}
	
	method showMenu() {
		
		game.clear()
		self.init()
		game.addVisual(menu)
		
		keyboard.c().onPressDo({ 
			game.clear()
			self.play()
		})
		
	}
	
}

object menu {
	method image() = 'menu.png'
	method position() = game.at(2, 2)
}

object score {
	
	var position = game.at(0, 15)
	// ingame game.at(0, 15)
	// menu game.at()
	
	method image() = 'score.png'
	method position() = position
	method position(newPosition) = { position = newPosition } 
}
