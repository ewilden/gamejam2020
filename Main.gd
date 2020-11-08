extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Character/SpriteLaser.visible = Input.is_action_pressed("click")
	if Input.is_action_pressed("click"):
		$Character.look_follow(get_tree().get_root().get_mouse_position())
	if Input.is_action_just_released("click"):
		$Character.boost_to(get_tree().get_root().get_mouse_position())
		
