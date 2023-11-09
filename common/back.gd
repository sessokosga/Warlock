extends Button
var has_resized :bool

signal was_pressed()

func _on_pressed() -> void:
	AudioPlayer.play_sfx(AudioPlayer.Sfx.Click)
	was_pressed.emit()

func _ready() -> void:
	has_resized=false


func _on_resized() -> void:
	if not has_resized:
		custom_minimum_size = size + Vector2(26,0)
		has_resized = true
	
