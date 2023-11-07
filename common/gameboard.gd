extends Control

func _load_hero()->void:
    pass
    
func _load_opponent()->void:
    pass

func _ready() -> void:
    Utilities.load_test_data()
    _load_hero()
    _load_opponent()


func _on_back_pressed() -> void:
    get_tree().change_scene_to_file("res://common/level_selection.tscn")
