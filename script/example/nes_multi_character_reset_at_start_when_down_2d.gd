class_name NesMultiCharacterResetAtStartWhenDown2D extends Node

@export var repop_height:float
@export var to_move:Node2D
@export var position_when_ready:Vector2


func _ready() -> void:
	position_when_ready = to_move.global_transform.origin

func reset_to_start_position() -> void:
	to_move.global_transform.origin = position_when_ready

func _process(delta: float) -> void:
	
	if to_move.global_transform.origin.y < repop_height:
		reset_to_start_position()
