class_name GraphNodeGomiBeanUiNamedBooleanButton
extends GraphNode

@export var _named_of_boolean:LineEdit
@export var _button_to_value_of_boolean:Button

func _ready() -> void:
	_button_to_value_of_boolean.button_down.connect(_on_button_down)
	_button_to_value_of_boolean.button_up.connect(_on_button_up)
	
func _on_button_down() -> void:
	_named_of_boolean.add_theme_color_override("font_color", Color(0, 1, 0))
	GOMI.bool(_named_of_boolean.text, true)

func _on_button_up() -> void:
	_named_of_boolean.add_theme_color_override("font_color", Color(1, 0, 0))
	GOMI.bool(_named_of_boolean.text, false)
