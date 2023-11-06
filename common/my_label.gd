extends Label
class_name MyLabel

var id:String
static var my_label = preload("res://common/my_label.tscn")

static func get_instance():
    return my_label.instantiate()