extends Control

func _ready() -> void:
    print("Selected deck : %s \n Selected opp : %s" % [Utilities.get_hero_deck(), Utilities.get_opponent_deck()])


func _on_back_pressed() -> void:
    get_tree().change_scene_to_file("res://common/level_selection.tscn")
