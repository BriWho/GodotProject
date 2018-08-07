extends "res://Object.gd"

onready var detector = {
	"Ahead":Vector2(1,0),
	"AheadLeft1":Vector2(1,-0.5).normalized(),
	"AheadRight1":Vector2(1,0.5).normalized(),
	"AheadLeft2":Vector2(1,-1).normalized(),
	"AheadRight2":Vector2(1,1).normalized(),
	"AheadLeft3":Vector2(0.5,-1).normalized(),
	"AheadRight3":Vector2(0.5,1).normalized(),
	"Left":Vector2(0,-1),
	"Right":Vector2(0,1),
	}
	
export (int) var detector_min_length = 50
export (int) var detector_max_length = 1000

func _ready():
	for key in detector:
		get_node(key).cast_to = detector[key] * detector_max_length
	pass

func process(delta):
	var total_cast_to = Vector2() 
	
	for key in detector:
		var raycast = get_node(key)
		var dir = detector[key]

		if raycast.is_colliding():
			raycast.cast_to = raycast.cast_to.linear_interpolate(dir * detector_min_length,0.1)
		else:
			raycast.cast_to = raycast.cast_to.linear_interpolate(dir * detector_max_length,0.1)
		
		total_cast_to += raycast.cast_to

	var rotate = 0
	if velocity != Vector2():
		rotate = sin(total_cast_to.normalized().angle())
	rotation += rotate * rotate_speed * delta
	
	if total_cast_to != detector["Ahead"] * detector_min_length:
		velocity = velocity.linear_interpolate(Vector2(1,0).rotated(rotation) * max_speed,velocity_t)
		stop = false
	else:
		stop = true

	pass
