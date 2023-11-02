extends Control

func _on_language_option_item_selected(index:int) -> void:
    match index:
        0:
            TranslationServer.set_locale("en")
        1:
            TranslationServer.set_locale("fr")
        _:
            TranslationServer.set_locale("en")

    pass # Replace with function body.



func _on_my_collection_pressed() -> void:
    #get_tree().change_scene_to_file()
    pass # Replace with function body.

func _on_start_pressed() -> void:
    pass # Replace with function body.


func _on_credits_pressed() -> void:
    pass # Replace with function body.
