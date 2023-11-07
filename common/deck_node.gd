extends Control
class_name DeckNode
signal pressed(deck_node)

static var node = preload("res://common/deck_node.tscn")

@export var id :StringName
@export var title:String:
	get:
		return title
	set(value):
		title = value
		$"%Button".text = title

func set_profile(texture:Texture2D)->void:
	$"%Profile".texture = texture

func get_profile()->Texture2D:
	return $"%Profile".texture

static func get_instance()->DeckNode:
	return node.instantiate()

func _on_button_pressed() -> void:
	pressed.emit(self)
