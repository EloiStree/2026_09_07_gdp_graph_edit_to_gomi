class_name GraphNodeSampleHelloWorld
extends GraphNode


func _ready():
	self.title = "Hello World"

	var input_a := Label.new()
	input_a.text = "Input A"
	add_child(input_a)

	var input_b := Label.new()
	input_b.text = "Input B"
	add_child(input_b)

	var output := Label.new()
	output.text = "Output"
	add_child(output)

	set_slot(0, true, 0, Color.WHITE , false, 0, Color.WHITE)
	set_slot(1, true, 0, Color.WHITE , false, 0, Color.WHITE)
	set_slot(2, false, 0, Color.WHITE , true, 0, Color.WHITE)
