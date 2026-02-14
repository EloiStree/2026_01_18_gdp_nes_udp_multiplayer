class_name NesMultiCharacterJumpDash
extends Node3D

@export var rigidbody_character: CharacterBody3D

# --- Jump Function ---
func jump() -> void:
	pass
	
# --- Dash Function ---
func dash() -> void:
	pass


# # --- Jump Parameters ---
# @export var jump_force: float = 6.5
# @export var gravity: float = 9.8

# # --- Dash Parameters ---
# @export var dash_speed: float = 20.0
# @export var dash_duration: float = 0.2
# @export var dash_cooldown: float = 1.0

# # --- Internal State ---
# var velocity: Vector3 = Vector3.ZERO
# var is_dashing: bool = false
# var dash_timer: float = 0.0
# var dash_cooldown_timer: float = 0.0

# func _physics_process(delta: float) -> void:
# 	if rigidbody_character == null:
# 		return

# 	# --- Dash timers ---
# 	if dash_cooldown_timer > 0:
# 		dash_cooldown_timer -= delta

# 	if is_dashing:
# 		dash_timer -= delta
# 		if dash_timer <= 0:
# 			is_dashing = false

# 	# --- Gravity ---
# 	if not rigidbody_character.is_on_floor():
# 		if not is_dashing:
# 			velocity.y -= gravity * delta
# 	else:
# 		if not is_dashing:
# 			velocity.y = 0  # Stop vertical velocity when grounded

# 	# --- Move Character ---
# 	rigidbody_character.velocity = velocity
# 	rigidbody_character.move_and_slide()  # Godot 4 version



# 	is_dashing = true
# 	dash_timer = dash_duration
# 	dash_cooldown_timer = dash_cooldown

# 	# Dash forward along local Z, keep vertical velocity
# 	var forward = -rigidbody_character.global_transform.basis.z
# 	forward.y = 0
# 	forward = forward.normalized()
# 	velocity.x = forward.x * dash_speed
# 	velocity.z = forward.z * dash_speed
