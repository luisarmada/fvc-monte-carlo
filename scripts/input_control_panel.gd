extends PanelContainer

## Script attached to the input panel - takes in data once 'run simulation' button is pressed.

# References to UI elements
@onready var steps_input = $VBoxContainer/Window/BasicVariables/Steps/LineEdit
@onready var walks_input = $VBoxContainer/Window/BasicVariables/Walks/LineEdit
@onready var starting_price_input = $VBoxContainer/Window/BasicVariables/StartingPrice/LineEdit
@onready var step_change_input = $VBoxContainer/Window/BasicVariables/StepChange/LineEdit

@onready var simulate_button = $VBoxContainer/Window/BasicVariables/SimulateButton
@onready var progress_bar = $VBoxContainer/Window/BasicVariables/ProgressBar
@onready var runtime_label = $VBoxContainer/Window/BasicVariables/RuntimeLabel
@onready var error_label = $VBoxContainer/Window/BasicVariables/ErrorLabel

var target_price = 100 # As required in the assignment

func _ready():
	simulate_button.pressed.connect(RunSimulation)

func RunSimulation():
	# Get and validate user inputs
	
	if not (steps_input.text.is_valid_int() and walks_input.text.is_valid_int()):
		error_label.text = "ERROR: Please enter valid integer values."
		return
	
	var num_steps = int(steps_input.text)
	var num_walks = int(walks_input.text)
	var starting_price = int(starting_price_input.text)
	
	if num_steps < 1 or num_walks < 1:
		error_label.text = "ERROR: Please enter values greater than 0."
		return
	
	# Get ready for simulation
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	# Use an array instead of dictionary for speed
	var min_price = 100 - num_steps
	var max_price = starting_price + num_steps
	var count_array = []
	count_array.resize(max_price - min_price + 1)
	count_array.fill(0)
	
	DataController.DataTableClear.emit()
	error_label.text = ""
	runtime_label.text = "Calculating runtime..."
	simulate_button.disabled = true
	progress_bar.max_value = num_walks
	progress_bar.value = 0
	var starting_time = Time.get_ticks_usec()
	
	# Perform Monte Carlo Simulation
	for walk in range(num_walks):
		# Simulate S steps
		var num_ups = 0
		for step in range(num_steps):
			if rng.randi() % 2 == 0: # The same as randf() < 0.5
				num_ups += 1
		
		# Calculate net change efficiently
		# Use num_steps = num_ups + num_downs
		# And net_change = (num_ups * 1) + (num_downs * -1) = num_ups - num_downs
		# We get net change = (2 * num_ups) - num_steps 
		var final_price = starting_price + (2 * num_ups - num_steps)
		
		var index = final_price - min_price
		count_array[index] += 1
		
		# REMOVED PROGRESS BAR FOR PERFORMANCE
		# if walk % 100 == 0:
		#	progress_bar.value = walk
		#	await get_tree().process_frame
	
	progress_bar.value = num_walks
	var end_time = Time.get_ticks_usec()
	
	# Calculate and display results
	
	for i in range(count_array.size()):
		var count = count_array[i]
		
		if count == 0:
			continue
		
		var price = i + min_price
		var prob = float(count) / num_walks
		
		DataController.DataTableAddEntry.emit(price, count, prob)
	
	# Reset Input UI
	var elapsed_time_microseconds = end_time - starting_time
	var elapsed_time_seconds = elapsed_time_microseconds / 1000000.0
	runtime_label.text = "Runtime: " + str(elapsed_time_seconds) + "s"
	
	simulate_button.disabled = false
