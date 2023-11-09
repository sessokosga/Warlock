extends ParallaxBackground

@onready var sprite := $"%Sprite2D"
var scroll_speed_x = 25
var scroll_speed_y = 14

func _process(delta: float) -> void:
	sprite.region_rect.position += delta * Vector2(scroll_speed_x,scroll_speed_y)
