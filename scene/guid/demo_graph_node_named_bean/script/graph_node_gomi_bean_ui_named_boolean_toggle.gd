class_name GraphNodeGomiBeanUiNamedBooleanToggle
extends GraphNode

@export var _named_of_boolean:LineEdit
@export var _toggle_to_value_of_boolean:CheckButton
	
func _ready() -> void:
	_toggle_to_value_of_boolean.toggled.connect(_on_toggled)
	
func _on_toggled(pressed: bool) -> void:
	if pressed:
		_named_of_boolean.add_theme_color_override("font_color", Color(0, 1, 0))
	else:
		_named_of_boolean.add_theme_color_override("font_color", Color(1, 0, 0))
	GOMI.bool(_named_of_boolean.text, pressed)
