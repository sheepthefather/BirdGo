extends Label

var fontSizeBig:bool=false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_text_timer_timeout():
	if !fontSizeBig:
		self.add_theme_font_size_override("font_size",30)
		fontSizeBig=true
	else:
		self.add_theme_font_size_override("font_size",25)
		fontSizeBig=false
	pass # Replace with function body.
