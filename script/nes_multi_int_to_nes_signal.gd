

	

class_name NesMultiIntToNesSignal extends Node

# Signals
signal arrow_updated(arrow_state: Vector2)
signal arrow_left_pressed(pressed: bool)
signal arrow_right_pressed(pressed: bool)
signal arrow_up_pressed(pressed: bool)
signal arrow_down_pressed(pressed: bool)
signal menu_left_pressed(pressed: bool)
signal menu_right_pressed(pressed: bool)
signal button_a_pressed(pressed: bool)
signal button_b_pressed(pressed: bool)

signal button_a_down(pressed: bool)
signal button_b_down(pressed: bool)



# States
var arrow_state: Vector2 = Vector2.ZERO
var menu_left_state: bool = false
var menu_right_state: bool = false
var button_a_state: bool = false
var button_b_state: bool = false

# Key mappings
@export var key_arrow_up: Array[int] = [1331, 1311, 1341, 1352, 1356]
@export var key_arrow_right: Array[int] = [1333, 1313, 1343, 1350, 1354]
@export var key_arrow_left: Array[int] = [1337, 1317, 1347, 1351, 1355]
@export var key_arrow_down: Array[int] = [1335, 1315, 1345, 1353, 1357]
@export var key_menu_left: Array[int] = [1309]
@export var key_menu_right: Array[int] = [1308]
@export var key_button_a: Array[int] = [1300]
@export var key_button_b: Array[int] = [1302, 1301, 1303]


func is_in_command_press(value: int, array: Array[int]) -> bool:
	return value in array


func is_in_command_release(value: int, array: Array[int]) -> bool:
	for v in array:
		if value == v + 1000:
			return true
	return false


func push_integer_to_event(value: int) -> void:

	# --- Direction button events ---
	_process_button(value, key_arrow_left, arrow_left_pressed)
	_process_button(value, key_arrow_right, arrow_right_pressed)
	_process_button(value, key_arrow_up, arrow_up_pressed)
	_process_button(value, key_arrow_down, arrow_down_pressed)

	# --- Menu ---
	_process_button(value, key_menu_left, menu_left_pressed)
	_process_button(value, key_menu_right, menu_right_pressed)

	# --- Buttons ---
	_process_button(value, key_button_a, button_a_pressed)
	_process_button(value, key_button_b, button_b_pressed)

	# --- Arrow state updates ---
	if is_in_command_press(value, key_arrow_left):
		arrow_state.x = -1
		_notify_arrow_updated()
	elif is_in_command_press(value, key_arrow_right):
		arrow_state.x = 1
		_notify_arrow_updated()
	elif is_in_command_press(value, key_arrow_up):
		arrow_state.y = 1
		_notify_arrow_updated()
	elif is_in_command_press(value, key_arrow_down):
		arrow_state.y = -1
		_notify_arrow_updated()
	elif is_in_command_release(value, key_arrow_left) or is_in_command_release(value, key_arrow_right):
		arrow_state.x = 0
		_notify_arrow_updated()
	elif is_in_command_release(value, key_arrow_up) or is_in_command_release(value, key_arrow_down):
		arrow_state.y = 0
		_notify_arrow_updated()

	# --- State booleans ---
	_update_state(value, key_menu_left, "menu_left_state")
	_update_state(value, key_menu_right, "menu_right_state")
	_update_state(value, key_button_a, "button_a_state")
	_update_state(value, key_button_b, "button_b_state")


func _process_button(value: int, array: Array[int], sig: Signal) -> void:
	if is_in_command_press(value, array):
		sig.emit(true)
		if sig==button_a_pressed:
			button_a_down.emit()
		if sig==button_b_pressed:
			button_b_down.emit()
	elif is_in_command_release(value, array):
		sig.emit(false)
	
	


func _update_state(value: int, array: Array[int], state_name: String) -> void:
	if is_in_command_press(value, array):
		set(state_name, true)
	elif is_in_command_release(value, array):
		set(state_name, false)


func _notify_arrow_updated() -> void:
	arrow_updated.emit(arrow_state)
