class_name NesMultiChangeColor
extends Node

@export var target_node_mesh: MeshInstance3D
@export var to_use_color: Color = Color(1, 0, 0, 1)

# Helper to ensure we have a StandardMaterial3D to modify
func _ensure_material():
	if target_node_mesh == null:
		return null
	if target_node_mesh.material_override == null:
		target_node_mesh.material_override = StandardMaterial3D.new()
	return target_node_mesh.material_override

func set_color_with_inspector_value():
	var mat = _ensure_material()
	if mat:
		mat.albedo_color = to_use_color

func set_color_with_random_color():
	var mat = _ensure_material()
	if mat:
		var random_color = Color(randf(), randf(), randf(), 1)
		mat.albedo_color = random_color
