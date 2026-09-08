class_name GraphNodeGomiUiBeanNamedBooleanButton
extends Node

@export var _line_edit_source:LineEdit
@export var _button_source:Button

func _ready() -> void:
    self.add_child(_line_edit_source)
    self.add_child(_button_source)
    _button_source.button_down.connect(_on_button_down)
    _button_source.button_up.connect(_on_button_up)
    
func _on_button_down() -> void:
    _line_edit_source.color = Color(0, 1, 0)
    GOMI.bool(_line_edit_source.name, true)

func _on_button_up() -> void:
    _line_edit_source.color = Color(1,0, 0)
    GOMI.bool(_line_edit_source.name, false)

