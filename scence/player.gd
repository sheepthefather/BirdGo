extends Area2D

var isFly:bool=false
var downSpeed:float=0
@export var speed:float=5
@export var upPower=-5

var isOver:bool=false
# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size=get_viewport_rect().size
	pass # Replace with function body.

var screen_size:Vector2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	if !GlobalGameState.gaming:
		$"./BirdPlayer".pause()
		return
	
	downSpeed+=delta*speed+1*delta
	self.position.y+=downSpeed
	
	if isFly:
		downSpeed=upPower
		isFly=false
	if self.rotation_degrees<45 && downSpeed>0:
		self.rotation_degrees+=70*delta
	
	if self.rotation_degrees>-30 && downSpeed<0:
		self.rotation_degrees-=200*delta
		
		
	if (self.position.y<0 || self.position.y>screen_size.y)&&!isOver:
		GlobalGameState.gaming=false
		isOver=true
	
	pass


func _on_body_entered(body):
	GlobalGameState.gaming=false
	pass # Replace with function body.
