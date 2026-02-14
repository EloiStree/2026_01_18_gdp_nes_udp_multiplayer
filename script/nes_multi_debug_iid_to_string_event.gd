

class_name NesMultiDebugIidToStringEvent extends Node

@export var iid_string_format: String = "Index: {index}, Value: {value}, Date: {date}"
@export var ii_string_format: String = "Index: {index}, Value: {value}"

signal on_iid_string_received(formatted_string: String)
signal on_ii_string_received(formatted_string: String)
signal on_integer_received_as_int(value: int)
signal on_integer_received_as_string(value: String)



func push_in_iid_data(index: int, value: int, date: int) -> void:
	var formatted_string = iid_string_format
	formatted_string = formatted_string.replace("{index}", str(index))
	formatted_string = formatted_string.replace("{value}", str(value))
	formatted_string = formatted_string.replace("{date}", str(date))
	var ii_formatted_string = ii_string_format
	ii_formatted_string = ii_formatted_string.replace("{index}", str(index))
	ii_formatted_string = ii_formatted_string.replace("{value}", str(value))
	on_iid_string_received.emit(formatted_string)
	on_ii_string_received.emit(ii_formatted_string)
	on_integer_received_as_int.emit(value)
	on_integer_received_as_string.emit(str(value))
