extends Node2D

onready var variables_node = $CanvasLayer/NinePatchRect/HBoxContainer/Variables.get_children()
onready var count = {
	"Purple":0,
	"Black":0,
	"Green":0,
	}

onready var text = {
	"name" : "",
	"max_speed": 0,
	"rotate_speed": 0,
	"mass": 0,
	"velocity_t": 0,
	}
	
onready var hud = {
	"Label1" : "name",
	"Label2" : "max_speed",
	"Label3" : "rotate_speed",
	"Label4" : "mass",
	"Label5" : "velocity_t",
	}

onready var change_info = {
	"max_speed":[200,300,400,500,600,700,800,0],
	"rotate_speed":[6,8,12,14,18,20,24,0],
	"velocity_t":[0.1,0.15,0.2,0.25,0.3,0.4,0.5,0.02],
	}

func _ready():
	if $Purple.has_method("_on_Object_mouse_entered"):
		$Purple._on_Object_mouse_entered()
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _on_object_info(node_name, max_speed, rotate_speed, mass, velocity_t):
	text["name"] = node_name
	text["max_speed"] = max_speed
	text["rotate_speed"] = rotate_speed
	text["mass"] = mass
	text["velocity_t"] = velocity_t

	for node in variables_node:
		node.text = str(text[hud[node.name]])
	pass 

func _on_RoundStart_body_exited(body):
	var cnt = count[body.name]
	if body.has_method("set_variables"):
		body.set_variables(change_info["max_speed"][cnt],change_info["rotate_speed"][cnt],change_info["velocity_t"][cnt])
	if body.name == 'Purple':
		_on_object_info(body.name, change_info["max_speed"][cnt], change_info["rotate_speed"][cnt], body.get("mass"), change_info["velocity_t"][cnt])
	if cnt <= 6:
		count[body.name] += 1
		
	pass

