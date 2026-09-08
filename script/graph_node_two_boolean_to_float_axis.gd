class_name GraphNodeTwoBooleanToFloatAxis
extends GraphNode


@export var _positive_value:float=1
@export var _unactive_value:float=0
@export var _negative_value:float=-1


var _result_display_label:Label
var _output_slot_values:Dictionary={}

func _ready() -> void:
	self.title="2 bool -> float axis"
	var negative:=Label.new()
	negative.text= "Negative Bool"
	var positive:=Label.new()
	positive.text= "Positive Bool"
	var output:=Label.new()
	output.text= "Axis"
	var result:=Label.new()
	result.text= "-1, 0, 1"
	_result_display_label=result
	
	self.add_child(positive)
	self.add_child(negative)
	self.add_child(output)
	self.add_child(result)
	set_slot(0, true, TYPE_BOOL, Color.GREEN, false, 0, Color.GREEN)
	set_slot(1, true, TYPE_BOOL, Color.GREEN, false, 0, Color.GREEN)
	set_slot(2, false, 0, Color.BLUE, true, TYPE_FLOAT, Color.BLUE)

func _process(delta: float) -> void:
	var negative_pressed:=bool(get_input_slot_value(0, false))
	var positive_pressed:=bool(get_input_slot_value(1, false))
	var axis_value:=get_axis_value(negative_pressed, positive_pressed)
	set_output_slot_value(2, axis_value)
	_result_display_label.text=str(axis_value)


func get_input_slot_value(slot_index:int, default_value:Variant=false) -> Variant:
	var graph_edit:=get_parent() as GraphEdit
	if graph_edit == null:
		return default_value
	for connection in graph_edit.get_connection_list():
		if str(connection.get("to_node", "")) != str(name):
			continue
		if int(connection.get("to_port", -1)) != slot_index:
			continue
		var from_node:=graph_edit.get_node_or_null(NodePath(str(connection.get("from_node", ""))))
		if from_node != null and from_node.has_method("get_output_slot_value"):
			return from_node.get_output_slot_value(int(connection.get("from_port", -1)))
	return default_value


func set_output_slot_value(slot_index:int, value:Variant) -> void:
	_output_slot_values[slot_index]=value


func get_output_slot_value(slot_index:int, default_value:Variant=0.0) -> Variant:
	return _output_slot_values.get(slot_index, default_value)



func get_axis_value(negative_pressed: bool, positive_pressed: bool) -> float:
	if negative_pressed == positive_pressed:
		return _unactive_value
	if negative_pressed:
		return _negative_value
	return _positive_value



	
