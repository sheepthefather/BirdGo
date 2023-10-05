extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _input(event):
	if event is InputEventScreenTouch:
		event=event as InputEventScreenTouch
		if !event.pressed:
			return
	elif event is InputEventMouseButton:
		event=event as InputEventMouseButton
		if !(event.button_index==MOUSE_BUTTON_LEFT && event.is_pressed()):
			return
	else:
		return
	get_tree().change_scene_to_file("res://main.tscn")
	pass
