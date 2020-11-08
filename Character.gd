extends RigidBody2D

var looking_at_pos = Vector2(0, 0)
var is_looking = false

func boost_to(pos: Vector2):
#	return
	var dist_sq = position.distance_squared_to(pos)
	apply_impulse(Vector2(0, 0), pos - position)
	
func look_follow(pos: Vector2):
	is_looking = true
	looking_at_pos = pos
	
func look_follow_impl(state: Physics2DDirectBodyState, 
		current_transform: Transform2D, 
		target_position: Vector2):
#	current_transform.basis_xform()
	var cur_dir = current_transform.basis_xform(Vector2(0, -1))
	var target_dir = (target_position - current_transform.origin).normalized()
	var rotation_angle = cur_dir.angle_to(target_dir)
	state.set_angular_velocity((rotation_angle / state.get_step()))
#
func _integrate_forces(state):
	if is_looking:
		var target_position = looking_at_pos
		look_follow_impl(state, get_global_transform(), target_position)
	
var desired_rotation: float = 0
var should_rotate: bool = false

func rotate_to(angle_radians: float):
	desired_rotation = angle_radians
	should_rotate = true
	
func _physics_process(delta):
	if should_rotate:
		var ang_dist = fmod(desired_rotation, 2 * PI) - fmod(rotation, 2 * PI)
#		if ang_dist < 0.001:
#			should_rotate = false
		add_torque(ang_dist * ang_dist * 1000 * delta)
	
#func _integrate_forces(state):
#	pass
#	print("_integrate_forces")
#	if should_rotate:
#		var xform = state.get_transform()
#		var xform_rot = xform.get_rotation()
#		state.set_transform(
#			xform.rotated(should_rotate_to - xform_rot))
#		should_rotate = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
