extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var time_since_press_start = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Player/SpriteLaser.visible = Input.is_action_pressed("click")
	if Input.is_action_pressed("click"):
		$Player.look_follow(get_global_mouse_position())
		$Enemy.look_follow(get_global_mouse_position())
		time_since_press_start += delta
	if Input.is_action_just_pressed("click"):
		time_since_press_start = 0
	if Input.is_action_just_released("click"):
		$Player.boost_to(get_global_mouse_position(), time_since_press_start)
		$Enemy.boost_to(get_global_mouse_position(), time_since_press_start)		
