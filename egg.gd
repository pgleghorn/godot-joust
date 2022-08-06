extends KinematicBody2D

const gravity : int = 450
const bounceDamper : int = 2

var vel : Vector2 = Vector2()

func _physics_process(delta):
	# apply gravity whilst in the air
	if !is_on_floor():
		vel.y += gravity * delta
	else:
		vel.y == 0
	
	#  move the egg
	var _r = move_and_slide(vel, Vector2.UP)	
	
	# check for collisions
	if get_slide_count() > 0:
		var collision = get_slide_collision(0)
		
		# bounce off the wall
		if collision != null:
			vel = vel.bounce(collision.normal)
			vel = vel / bounceDamper

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
