extends HBoxContainer

## Script attached to each data table row, used for intialising

@export var is_header: bool = false

# References to UI labels
@onready var share_price_label = $FinalSharePrice/RichTextLabel
@onready var frequency_label = $Frequency/RichTextLabel
@onready var probability_label = $Probability/RichTextLabel

var share_price_value: int
var frequency_value: int
var probability_value: float

# Can be worked on to be more dynamic - for now we have parameters set in stone 
func SetCellContents(share_price: int, frequency: int, probability: float):
	share_price_value = share_price
	frequency_value = frequency
	probability_value = probability
	
# Called when added to the scene
func _ready():
	if is_header:
		return
	
	share_price_label.text = "£" + str(share_price_value)
	frequency_label.text = str(frequency_value)
	probability_label.text = str(probability_value)
