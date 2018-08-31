extends Node

onready var terminal = $HBoxContainer/VBoxContainer/Panel/MarginContainer/RichTextLabel
onready var lineedit = $HBoxContainer/VBoxContainer/LineEdit

var ip = '127.0.0.1'
var port = 4200

func _ready():
	get_tree().connect("connected_to_server",self,"_connected_to_server")
	get_tree().connect("connection_failed",self,"_connection_failed")
	get_tree().connect("network_peer_connected",self,"_peer_connected")
	get_tree().connect("network_peer_disconnected",self,"_peer_disconnected")
	get_tree().connect("server_disconnected",self,"_server_disconnected")
	pass

func _connected_to_server():
	input('connected to server')
	pass
	
func _server_disconnected():
	input('server disconnected')
	pass
	
func _connection_failed():
	input('connection_failed')
	pass
	
func _peer_connected(id):
	input(str(id) + ' connected')
	pass
	
func _peer_disconnected(id):
	input(str(id) + ' disconnected')
	pass

func input(new_text):
	terminal.add_text('> ' + new_text)
	terminal.newline()
	pass

func _on_Host_button_down():
	var peer = NetworkedMultiplayerENet.new()
	peer.create_server(port,16)
	get_tree().set_network_peer(peer)
	input('id: ' + str(get_tree().get_network_unique_id()))
	input('start server')
	pass

func _on_Connect_button_down():
	var peer = NetworkedMultiplayerENet.new()
	peer.create_client(ip,port)
	get_tree().set_network_peer(peer)
	input('id: ' + str(get_tree().get_network_unique_id()))
	pass


func _on_Button1_button_down():
	rpc('remote_func',get_tree().get_network_unique_id())
	pass

func _on_Button2_button_down():
	var id = int(lineedit.text)
	if not id: return
	rpc_id(id,'remote_func',get_tree().get_network_unique_id())
	pass

func _on_Button3_button_down():
	rpc('sync_func',get_tree().get_network_unique_id())
	pass

func _on_Button4_button_down():
	var id = int(lineedit.text)
	if not id: return
	rpc_id(id,'sync_func',get_tree().get_network_unique_id())
	pass

func _on_Button5_button_down():
	rpc('slave_func',get_tree().get_network_unique_id())
	pass

func _on_Button6_button_down():
	var id = int(lineedit.text)
	if not id: return
	rpc_id(id,'slave_func',get_tree().get_network_unique_id())
	pass

func _on_Button7_button_down():
	rpc('master_func',get_tree().get_network_unique_id())
	pass

func _on_Button8_button_down():
	var id = int(lineedit.text)
	if not id: return
	rpc_id(id,'master_func',get_tree().get_network_unique_id())
	pass
