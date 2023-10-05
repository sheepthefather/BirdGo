extends Node2D

@export var backgroundSpeed:float=200
@export var pillerSpace:float=360

var isPlaying:bool=true
var pillerPositonArray:Array[float]
var poolPiller:Array[Node2D]

var score:int=0
func _ready():
	for i in range(6):
		pillerPositonArray.append(get_viewport_rect().size.x+i*pillerSpace)
		var piller:Node2D=preload("res://scence/piller.tscn").instantiate() as Node2D
		piller.position.x=pillerPositonArray[i]
		var upBody:StaticBody2D=piller.get_node("upStaticBody")
		var downBody:StaticBody2D=piller.get_node("downStaticBody")
		randPillerHeight(upBody,downBody)
		self.add_child(piller)
		poolPiller.append(piller)
		pass
	pass


func _process(delta):
	if !GlobalGameState.gaming:
		return
	
	for i in pillerPositonArray.size():
		pillerPositonArray[i]-=backgroundSpeed*delta
		pass
	if pillerPositonArray[0]<-35:
		loopPiller()
		pass
	# loop piller
	for i in pillerPositonArray.size():
		poolPiller[i].position.x=pillerPositonArray[i]
		pass
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
	
	if !GlobalGameState.gaming:
		GlobalGameState.gaming=true
		get_tree().change_scene_to_file("res://main.tscn")
		return
	$Player.isFly=true
	pass
	
func loopPiller()->void:
	for i in range(pillerPositonArray.size()-1):
		pillerPositonArray[i]=pillerPositonArray[i+1]
		
		poolPiller[i].get_node("upStaticBody").position.y= \
			poolPiller[i+1].get_node("upStaticBody").position.y
		poolPiller[i].get_node("downStaticBody").position.y= \
			poolPiller[i+1].get_node("downStaticBody").position.y
		pass
	
	pillerPositonArray[pillerPositonArray.size()-1]= \
	pillerPositonArray[pillerPositonArray.size()-2]+pillerSpace
	var upBody:StaticBody2D=poolPiller[poolPiller.size()-1].get_node("upStaticBody")
	var downBody:StaticBody2D=poolPiller[poolPiller.size()-1].get_node("downStaticBody")
	randPillerHeight(upBody,downBody)
	
	pass
	
func randPillerHeight(upBody:StaticBody2D,downBody:StaticBody2D)->void:
	var spaceSize:float=randf_range(100,200)
	var vertical_down_position:float=randf_range(0,200)
	downBody.position.y=vertical_down_position
	upBody.position.y=vertical_down_position-spaceSize
	pass


func _on_get_score(area):
	score+=1
	$Score/Label.text="SCORE:"+String.num_int64(score)
	pass # Replace with function body.
