extends Control


func _on_back_pressed() -> void:
	AudioPlayer.play_sfx(AudioPlayer.Sfx.Click)
	get_tree().change_scene_to_file("res://common/main.tscn")
