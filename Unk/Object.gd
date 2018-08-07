extends KinematicBody2D

export (float) var max_speed = 200
export (float) var rotate_speed = 6
export (float) var mass = 5
export (float) var velocity_t = 0.08

signal object_info(node_name,max_speed,rotate_speed,mass,velocity_t)

var velocity
var stop

func _ready():
	velocity = Vector2()
	stop = true
	pass

func _process(delta):

	var col_v = move_and_slide(velocity)
	if velocity != col_v:
		var collision = get_slide_collision(0)
		if collision.collider.has_method("collide"):
			velocity = collision.collider.collide(velocity - col_v,mass)

	process(delta)

	if stop:
		velocity = velocity.linear_interpolate(Vector2(),0.01)

	pass

func process(delta):
	if velocity.length() > 0:
		stop = true
	else:
		stop = false
	pass

func center_velocity(self_v, self_m ,obj_v , obj_m):
	return (self_m * self_v + obj_m * obj_v)/(self_m + obj_m)
	
func collide(obj_v,obj_m):
	var center_v = center_velocity(velocity,mass,obj_v,obj_m)
	velocity = 2*center_v - velocity
	return 2*center_v - obj_v

func _on_Object_mouse_entered():
	emit_signal("object_info",name,max_speed,rotate_speed,mass,velocity_t)
	pass
	
func set_variables(s,r,t):
	max_speed = s
	rotate_speed = r
	velocity_t = t
	pass
