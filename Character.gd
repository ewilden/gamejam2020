extends RigidBody2D

var looking_at_pos = Vector2(0, 0)
var is_looking = false

func boost_to(pos: Vector2, click_duration: float):
	click_duration = min(click_duration, 2)
#	return
	var dist_sq = position.distance_squared_to(pos)
	apply_impulse(Vector2(0, 0), 
		(pos - position).normalized() 
			* (pow(click_duration * 400, 1.2) + 400.0))
	
func look_follow(pos: Vector2):
	is_looking = true
	looking_at_pos = pos
	
func look_follow_impl(state: Physics2DDirectBodyState, 
		current_transform: Transform2D, 
		target_position: Vector2):
	var cur_dir = current_transform.basis_xform(Vector2(0, -1))
	var target_dir = (target_position - current_transform.origin).normalized()
	var rotation_angle = cur_dir.angle_to(target_dir)
	state.set_angular_velocity((rotation_angle / state.get_step()))

func _integrate_forces(state):
	if is_looking:
		var target_position = looking_at_pos
		look_follow_impl(state, get_global_transform(), target_position)
		is_looking = false
		linear_damp = 2
	else:
		linear_damp = -1
		pass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
