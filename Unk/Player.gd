extends "res://Object.gd"

var mouse_position

func _ready():
	
	pass
	
func _input(event):
	if event is InputEventMouseMotion:
		mouse_position = event.position - get_viewport_rect().size/2
	pass

func process(delta):
	stop = false
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		var dir = mouse_position.normalized()
		var deg = dir.angle() - rotation
		var clockwise = 0
		if sin(deg) > 0:
			clockwise = 1
		if sin(deg) < 0:
			clockwise = -1

		rotation += clockwise * rotate_speed * delta
		if velocity.length() <= max_speed: 
			velocity = velocity.linear_interpolate(Vector2(1,0).rotated(rotation) * max_speed,velocity_t)
		else:
			stop = true
		
	elif Input.is_key_pressed(KEY_W):
		var clockwise = 0
		if Input.is_key_pressed(KEY_D):
			clockwise = 1
		if Input.is_key_pressed(KEY_A):
			clockwise = -1
			
		rotation += clockwise * rotate_speed * delta
		velocity = velocity.linear_interpolate(Vector2(1,0).rotated(rotation) * max_speed,velocity_t)

		
	else:
		stop = true
		
	pass