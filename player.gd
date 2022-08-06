extends KinematicBody2D

const hspeed : int = 10
const xmax : int = 600
const gravity : int = 600
const flapPower : int = -200
var frictionAir : float = 0.4
const frictionGround : float = 5.0
const bounceDamperEdge : float = 2.0
const bounceDamperCeiling : float = 1.5
const bounceDamperFloor : float = 3.0
var score : int = 0
const eggScore : int = 10

var lastColliderName : String = "none"

var vel : Vector2 = Vector2()

onready var sprite : AnimatedSprite = get_node("AnimatedSprite")

func _physics_process(delta):
	# friction to slow the bird down
	if (vel.x < 0):
		if is_on_floor():
			vel.x = vel.x + frictionGround
		else:
			vel.x = vel.x + frictionAir
	if (vel.x > 0):
		if is_on_floor():
			vel.x = vel.x - frictionGround
		else:
			vel.x = vel.x - frictionAir
	
	# prevent drift from constant little adjustments
	if (abs(vel.x)) < frictionGround:
		vel.x = 0
	if (abs(vel.y) < 10):
		vel.y = 0

	# controls
	if Input.is_action_pressed("input_left"):
		if (vel.x > -xmax):
			vel.x -= hspeed
		sprite.flip_h = true
	if Input.is_action_pressed("input_right"):
		if (vel.x < xmax):
			vel.x += hspeed
		sprite.flip_h  = false
		
	if Input.is_action_just_pressed("input_flap"):
		vel.y = flapPower
		$FlapSound.play()
		sprite.play("wingup")
	if Input.is_action_just_released("input_flap"):
		sprite.play("default")
	
	# apply gravity whilst in the air
	if !is_on_floor():
		vel.y += gravity * delta
	
	# wrap around the play area
# warning-ignore:narrowing_conversion
	var gameWidth : int = OS.get_window_size().x
	if position.x > gameWidth-250:
		position.x = -300
		
	if position.x < -300:
		position.x = 750
		
	#  move the player
	move_and_slide(vel, Vector2.UP)	
	
	# check for collisions
	if get_slide_count() > 0:
		
		var collision = get_slide_collision(0)
		var collider = collision.collider
		if (collider != null):
			lastColliderName = collider.get("name")
			
		# collect egg and increase score
		if "Egg" in collider.get("name"):
			print(collision.collider.get("name"))
			collision.collider.free()
			score += eggScore
			var scoreText = get_node("/root/MainScene/ScoreText")
			scoreText.set("text", "Score: %s" % score)
			return # dont process any more collisions
			
		# bounce off the wall
		if self.is_on_wall():
			vel = vel.bounce(collision.normal)
			vel.x = vel.x / bounceDamperEdge
			sprite.flip_h  = !sprite.flip_h
			return
			
		if self.is_on_ceiling():
			vel = vel.bounce(collision.normal)
			vel.y = vel.y / bounceDamperCeiling
			return
			
		if self.is_on_floor():
			vel = vel.bounce(collision.normal)
			vel.y = vel.y / bounceDamperFloor
			return
		
# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.play("default")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
