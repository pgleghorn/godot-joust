extends RichTextLabel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.text = ""
	self.text += "delta: " + String(delta) + "\n"
	var myPlayer = get_node("/root/MainScene/Player")
	var myPlayerPos = myPlayer.get("position")
	self.text += "x: " + String(int(myPlayerPos.x)) + ", "
	self.text += "y: " + String(int(myPlayerPos.y)) + "\n"
	var myPlayerVel = myPlayer.get("vel")
	self.text += "xvel: " + String(int(myPlayerVel.x)) + ", "
	self.text += "yvel: " + String(int(myPlayerVel.y)) + "\n"
	var myPlayerLastColliderName = myPlayer.get("lastColliderName")
	self.text += "lastColliderName: " + myPlayerLastColliderName + "\n"
