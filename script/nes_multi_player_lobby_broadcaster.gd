class_name NesMultiPlayerLobbyBroadcaster
extends Node


@export var parent_to_overwatch: Node
@export var refresh_list_at_start: bool = true
@export var override_player_index_with_order_at_start: bool = true

@export_group("For Debugging")
@export var players_found: Array[NesMultiPlayerRelayIID] = []

func _ready() -> void:
	if refresh_list_at_start:
		refresh_list_of_players()

	if override_player_index_with_order_at_start:
		override_index_of_player_with_found_order()

func push_command_iid_to_player(index: int, value: int,date:int) -> void:
	
	for player in players_found:
		if player !=null:
			if player.is_index(index):
				player.push_command_iid_to_player(index, value , date)

func push_command_ii_to_player(index: int, value: int) -> void:
	for player in players_found:
		if player !=null:
			if player.is_index(index):
				player.push_command_iid_to_player(index, value,0)


func override_index_of_player_with_found_order() -> void:
	for i in range(players_found.size()):
		players_found[i].set_player_index(i + 1)


func refresh_list_of_players() -> void:
	if parent_to_overwatch == null:
		push_warning("Parent to overwatch is null. Nothing to scan.")
		return

	players_found.clear()
	scan_recursive(parent_to_overwatch)


func scan_recursive(current: Node) -> void:
	if current is NesMultiPlayerRelayIID:
		players_found.append(current)
	for child in current.get_children():
		if child is Node:
			scan_recursive(child)
	
