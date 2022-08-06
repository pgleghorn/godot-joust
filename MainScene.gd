extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_EggTimer_timeout():
	var scene = load("res://egg.tscn")
	var egg = scene.instance()
	egg.set_name("Egg")
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var rx = rng.randf_range(-250, 700)
	var ry = rng.randf_range(-150, 300)
	var initialPosition : Vector2 = Vector2(rx, ry)
	egg.global_position = initialPosition
	add_child(egg)
