class_name NesMultiSplitIidToSignal extends Node

signal  on_integer_received(value: int)
signal  on_index_integer_received(index: int, value: int)
signal  on_index_integer_date_received(index: int, value: int, date: int)

func push_in_iid_data(index: int, value: int, date: int) -> void:
    on_integer_received.emit(value)
    on_index_integer_received.emit(index, value)
    on_index_integer_date_received.emit(index, value, date)
