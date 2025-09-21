extends VBoxContainer

## Script used to handle the displaying of the output data table

var table_row_obj = preload("res://scenes/data_table_row.tscn")
var data_table_content: Array[Node] = [] # Table Rows, does not include the header row

func _ready():
	# Connect functions to signals from 'data_controller.gd' script
	# Allows different scripts to communicate at runtime
	DataController.DataTableClear.connect(DataTableClear)
	DataController.DataTableAddEntry.connect(DataTableAddEntry)

func DataTableClear():
	for row in data_table_content:
		row.queue_free()
	
	data_table_content.clear()

func DataTableAddEntry(share_price: int, frequency: int, probability: float):
	var table_row_inst = table_row_obj.instantiate() # Instantiate 'data_table_row.tscn'
	data_table_content.push_back(table_row_inst)
	table_row_inst.SetCellContents(share_price, frequency, probability) # Call instantiation in 'data_table_row.gd'
	add_child(table_row_inst)
