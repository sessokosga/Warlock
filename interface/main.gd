extends Control

@onready var language_option := $"%Language Option"
@onready var start_btn := $"%Start"
@onready var credits_btn := $"%Credits"

func _ready() -> void:
    pass


func _on_language_option_item_selected(index:int) -> void:
    match index:
        0:
            TranslationServer.set_locale("en")
        1:
            TranslationServer.set_locale("fr")
        _:
            TranslationServer.set_locale("en")

    pass # Replace with function body.
