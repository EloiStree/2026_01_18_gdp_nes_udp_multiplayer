


class_name NesMultiCharacterExample extends Node


signal on_power_a_requested()
signal on_power_b_requested()

@export var rigidbody_character: CharacterBody3D

@export var move_speed: float = 5.0
@export var rotation_speed: float = 90.0
@export var default_gravity: float = -9.8

@export var joystick_value := Vector2.ZERO

@export var power_a_state: bool = false
@export var power_b_state: bool = false

@export var link_jump_to_power_a: bool = true
@export var jump_strength: float = 5.0

@export var link_dash_to_power_b: bool = true
@export var dash_speed_multiplier: float = 2.0


func set_turn_left_right(value: float) -> void:
	joystick_value.x = value

func set_move_forward_backward(value: float) -> void:
	joystick_value.y = value

func set_turn_left() -> void:
	joystick_value.x = -1.0

func set_turn_right() -> void:
	joystick_value.x = 1.0

func set_move_forward() -> void:
	joystick_value.y = 1.0

func set_move_backward() -> void:
	joystick_value.y = -1.0

func set_turn_left_on_off(is_on: bool) -> void:
	joystick_value.x = -1.0 if is_on else 0.0

func set_turn_right_on_off(is_on: bool) -> void:
	joystick_value.x = 1.0 if is_on else 0.0

func set_move_forward_on_off(is_on: bool) -> void:
	joystick_value.y = 1.0 if is_on else 0.0

func set_move_backward_on_off(is_on: bool) -> void:
	joystick_value.y = -1.0 if is_on else 0.0   


func request_power_a() -> void:
	on_power_a_requested.emit()

func request_power_b() -> void:
	on_power_b_requested.emit()

func set_power_a_state(is_active: bool) -> void:

	var previous_state = power_a_state
	if is_active and not previous_state:
		request_power_a()
	power_a_state = is_active   
	

func set_power_b_state(is_active: bool) -> void:
	
	var previous_state = power_b_state
	if is_active and not previous_state:
		request_power_b()
	power_b_state = is_active


func _process(delta: float) -> void:
	if rigidbody_character == null:
		return

	# --- ROTATION ---
	if joystick_value.x != 0.0:
		var rotation_amount := deg_to_rad(rotation_speed) * -joystick_value.x * delta
		rigidbody_character.rotate_y(rotation_amount)

	# --- MOVEMENT ---
	var velocity := rigidbody_character.velocity

	# Forward direction is -Z in Godot
	var forward := -rigidbody_character.transform.basis.z
	var move_direction := forward * joystick_value.y

	velocity.x = move_direction.x * move_speed
	velocity.z = move_direction.z * move_speed

	# Apply gravity if needed
	if not rigidbody_character.is_on_floor():
		velocity.y += default_gravity * delta
	else:
		velocity.y = 0.0

	rigidbody_character.velocity = velocity
	rigidbody_character.move_and_slide()


func _ready() -> void:
	if link_dash_to_power_b:
		on_power_b_requested.connect(dash_forward)
	if link_jump_to_power_a:
		on_power_a_requested.connect(jump)

func jump() -> void:
	if rigidbody_character.is_on_floor():
		rigidbody_character.velocity.y = jump_strength
func dash_forward() -> void:
	if rigidbody_character.is_on_floor():
		var forward := -rigidbody_character.transform.basis.z
		rigidbody_character.velocity += forward * move_speed * dash_speed_multiplier
