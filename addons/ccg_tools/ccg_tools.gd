@tool
extends EditorPlugin


func _enter_tree():
	add_custom_type("Card","Control",preload("res://addons/ccg_tools/scripts/card.gd"),preload("res://addons/ccg_tools/icon.png"))
	add_custom_type("Hand","Control",preload("res://addons/ccg_tools/scripts/hand.gd"),preload("res://addons/ccg_tools/icon.png"))
	add_custom_type("Deck","Control",preload("res://addons/ccg_tools/scripts/deck.gd"),preload("res://addons/ccg_tools/icon.png"))
	print("CCG Tools initialised!")
	pass


func _exit_tree():
	remove_custom_type("Card")
	remove_custom_type("Hand")
	remove_custom_type("Deck")
	pass
