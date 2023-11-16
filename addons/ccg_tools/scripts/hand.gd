@tool

extends Control

class_name Hand

const CARD_FAN_SPACING = [0,40,80,120,160,200] 
const CARD_FAN_ROTATION = [0,2,5,12,12,15] 
const CARD_FAN_HEIGHT = [0,10,15,25,35,40] 

@export var curve_rotation : Curve
@export var curve_spacing : Curve
@export var curve_height : Curve

enum HandType{Player, Opponent}

@export var type :HandType = HandType.Player
@onready var screen_size = get_window().size

static var hand_node = preload("res://addons/ccg_tools/scenes/hand.tscn")

static func get_instance():
	return hand_node.instantiate()



func _ready():
#	size = get_viewport().size
#	print(size)
	
	pass
	
func _process(delta: float) -> void:
	pass
	
func fan():
	var hand_count = get_child_count()
	for card in get_children():
		var card_ratio = .5
		if hand_count > 1 :
			card_ratio = float(card.get_index()) /float(hand_count-1)
			
		var width:float
		var idx:int
		if CARD_FAN_SPACING.size() >= hand_count:
			idx = hand_count-1
		else:
			idx=CARD_FAN_SPACING.size()-1
		#var card_size = card.size.x *1.4
		#width=curve_spacing.sample(card_ratio) * card_size
		width=curve_spacing.sample(card_ratio) * CARD_FAN_SPACING[idx]
		var card_size = card.size.x * card._scale.x*2
		card.position.x = (screen_size.x - card_size)/2 + width
		if type == HandType.Opponent:
			card.position.y = -200
			#card.position.y = -420
			card.position += curve_height.sample(card_ratio)* CARD_FAN_HEIGHT[idx] *Vector2.DOWN
			card.rotation = curve_rotation.sample(card_ratio)*deg_to_rad(CARD_FAN_ROTATION[idx])
			card.scale.y = - abs(card.scale.y)
		else:
			card.position.y = 35
			#card.position.y = 550
			card.position += curve_height.sample(card_ratio)*CARD_FAN_HEIGHT[idx]*Vector2.UP
			card.rotation = curve_rotation.sample(card_ratio)*deg_to_rad(-CARD_FAN_ROTATION[idx])
			
		card.initial_position = card.position 
		card.initial_rotation = card.rotation 


func _on_child_order_changed() -> void:
	fan()
