class_name NesMultiPlayerRelayIID extends Node


@export var player_index: int


func set_player_index(index: int) -> void:
    player_index = index

func get_player_index() -> int:
    return player_index


func is_index(index: int) -> bool:
    return index == player_index


signal on_index_value_date_received(index: int, value: int, date: int)
signal on_index_value_received(index: int, value: int)
signal on_value_received(value: int)


func push_command_iid_to_player(index: int, value: int, date: int) -> void:
    on_index_value_date_received.emit(index, value, date)
    on_index_value_received.emit(index, value)
    on_value_received.emit(value)