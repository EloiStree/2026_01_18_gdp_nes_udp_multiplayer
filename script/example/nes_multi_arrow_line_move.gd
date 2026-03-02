class_name NesMultiArrowLineMove
extends Node2D

@export var speed: float = 800.0
@export var lifetime: float = 4.0

var direction: Vector2 = Vector2.ZERO

func _ready():
	await get_tree().create_timer(lifetime).timeout
	queue_free()

func _physics_process(delta):
	position += direction * speed * delta
