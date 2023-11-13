extends  Control
class_name Card 

signal select_box_toggled(card)
signal add_pressed(card)
signal remove_pressed(card)

static var card_node = preload("res://addons/ccg_tools/scenes/card.tscn")
var initial_position:Vector2
var initial_scale:Vector2
var initial_rotation:float
var initial_z_index:int
var is_dragged := false
var is_hovered := false
var is_dropped := false
var is_queing_for_field := false
var is_traveling := false
var is_going_to_hand := false
var id:StringName

@onready var select_box := $"%SelectBox"


var is_selected := false:
	set(value):
		is_selected = value
		select_box.button_pressed=value

enum Mode { Full, Field, Hero}

@export var mode : Mode:
	set(value):
		match value:
			Mode.Full:
				$"%FullMode".show()
				$FieldMode.hide()
				size = $"%FullMode".size
				scale = $"%FullMode".scale
			_:
				$"%FullMode".hide()
				$FieldMode.show()
				size = $FieldMode.size
				scale = $FieldMode.scale
		mode  = value
		update_size()

var timer : float
var mana:int:
	get:
		return mana
	set(value):
		$"%Mana".text = str(value)
		mana = value

@export var pos:Vector2:
	get:
		return global_position
	set(value):
		global_position = value


var title:String :
	get:
		return $"%Title".text
	set(value):
		$"%Title".text = value
		
var profile:String:
	get:
		return profile
	set(file_name):
		$"%Profile".texture = load(file_name )
		$"%ProfileField".texture = $"%Profile".texture
		profile = file_name
		
var attack:int:
	get:
		return attack
	set(value):
		$"%Attack".text = str(value)
		$"%AttackField".text = str(value)
		attack = value
		
var health:int:
	get:
		return health
	set(value):
		$"%Health".text = str(value)
		$"%HealthField".text = str(value)
		health = value
		
@export var description:String :
	get:
		return description
	set(value):
		$"%Description".text = value
		description = value
var sample : int=0
	
	
var back:String:
	get:
		return back
	set(file_name):
		$"%Back".texture = load(file_name )
		back = file_name

var _scale : Vector2: 
	get:
		if _scale <= Vector2.ZERO:
			_scale = Vector2.ONE
		return _scale
	set(value):
		scale = value
		_scale = value
		custom_minimum_size = size *value 
		$"%FullMode".scale = value
		update_size()
			

@export var rota:float:
	get:
		return rad_to_deg(rotation)
	set(value):
		rotation = value


var effect : StringName
var type : CardData.Warlock.Type:
	set(value):
		type = value
		$"%Type".text = Utilities.card_type_string(type)
	
var emblem:String :
	set(file_name):
		emblem = file_name
		$"%Emblem".texture = load(file_name)

var decoration : String:
	set(file_name):
		decoration = file_name
		$"%Decoration".texture = load(file_name)

func show_back():
	if mode == Mode.Full:
		$"%Mana".hide()
		$"%Attack".hide()
		$"%Health".hide()
		$"%Description".hide()
		$"%Emblem".hide()
		$"%Type".hide()
		$"%Title".hide()
		$"%Icon".hide()
		$"%Back".z_index += 1
	
func show_front():
	if mode == Mode.Full:
		$"%Mana".show()
		$"%Attack".show()
		$"%Health".show()
		$"%Description".show()
		$"%Emblem".show()
		$"%Type".show()
		$"%Title".show()
		$"%Icon".show()
		$"%Back".z_index -= 1
	
func show_health():
	$"%Health".show()
	$"%HealthbackField".show()

func hide_health():
	$"%Health".hide()
	$"%HealthbackField".hide()
	
func show_attack():
	$"%Attack".show()
	$"%AttackBackField".show()
	
func hide_attack():
	$"%Attack".hide()
	$"%AttackBackField".hide()

func show_mana():
	$"%Mana".show()
	
func hide_mana():
	$"%Mana".hide()
	
func hide_select_box():
	$"%SelectBox".hide()

func show_select_box():
	$"%SelectBox".show()
	
func hide_add_or_remove():
	$"%AddOrRemove".hide()

func show_add_or_remove():
	$"%AddOrRemove".show()

func hide_checkmark()->void:
	$"%Checkmark".hide()
func show_checkmark()->void:
	$"%Checkmark".show()
	
func update_count_label(value):
	$"%CountLabel".text = "Count: %d" % value
	
func enable_add(value):
	$"%Add".disabled = not value

func enable_remove(value):
	$"%Remove".disabled = not value

func update_size():
	if mode == Mode.Field or mode == Mode.Hero:
		pivot_offset = Vector2(0,0)
		custom_minimum_size = $FieldMode.size * _scale
		size =  $FieldMode.size * _scale
		
	else:
		pivot_offset = Vector2(0,0)
		custom_minimum_size = $"%FullMode".size* _scale
		size =  $"%FullMode".size* _scale
	pivot_offset = size / 2
	

static func get_instance():
	return card_node.instantiate()

func get_profile_texture()->Texture2D:
	return $"%Profile".texture

# Called when the node enters the scene tree for the first time.
func _ready():
	#if mode == Mode.Full:
	#	_scale = Vector2(1,1)
	update_size()
	pass
	
func _physics_process(delta):
	
	#update_size()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_select_box_toggled(button_pressed):
	if button_pressed:
		select_box.text = tr("Selected")
	else:
		select_box.text = tr("Select")
	is_selected = button_pressed
	select_box_toggled.emit(self)


func _on_add_pressed():
	add_pressed.emit(self)


func _on_remove_pressed():
	remove_pressed.emit(self)
