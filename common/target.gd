class_name Target extends Node

var from : Vector2
var to : Vector2
var victim:Card
var offender:Card
var is_active:bool
var victim_parent :Node
var offender_parent :Node

func _init() -> void:
	from = Vector2.ZERO
	to = Vector2.ZERO
	victim=null
	offender=null
	is_active = false
	victim_parent = null
	offender_parent = null