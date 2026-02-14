class_name NesMultiListenUdpInIID extends Node

@export var allowed_ipv4_array=["127.0.0.1"]
@export var allowed_port=3615
@export var use_debug_print:bool
var udp_server: UDPServer

signal on_ii_data_received(index_int32: int, value_int32: int)
signal on_iid_data_received(index_int32: int, value_int32: int, date_ulong64: int)

func _ready() -> void:
	udp_server = UDPServer.new()
	var result = udp_server.listen(allowed_port)
	if result != OK:
		print("Failed to start UDP server on port ", allowed_port)
	else:
		print("UDP server listening on port ", allowed_port)

func _process(_delta) -> void:
	udp_server.poll()
	
	if udp_server.is_connection_available():
		var peer = udp_server.take_connection()
		var ip = peer.get_packet_ip()
		if allowed_ipv4_array.size() ==0:
			var packet = peer.get_packet()
			if packet.size() > 0:
				_handle_received_data(packet, ip)
		else:
			if ip in allowed_ipv4_array:
				var packet = peer.get_packet()
				if packet.size() > 0:
					_handle_received_data(packet, ip)
			else:
				print("Rejected connection from unauthorized IP: ", ip)

func _handle_received_data(data: PackedByteArray, from_ip: String) -> void:
	var size = data.size()
	
	if data.size() == 4:  
		var value = data.decode_s32(0)
		_notify_received_iid_data(0, value, 0)
	elif data.size() == 8:  
		var index = data.decode_s32(0)
		var value = data.decode_s32(4)
		_notify_received_iid_data(index, value, 0)
	elif data.size() == 12: 
		var value = data.decode_s32(4)
		var date = data.decode_u64(8)
		_notify_received_iid_data(0, value, date)
	elif data.size() == 16:  # 4 + 4 + 8 bytes for int, int, uint64
		var index = data.decode_s32(0)
		var value = data.decode_s32(4)
		var date = data.decode_u64(8)
		_notify_received_iid_data(index, value, date)
	elif data.size() >= 16:  
		# Cut it by pack of 16 bytes and process each pack
		var total_packs = data.size() / 16
		for i in range(total_packs):
			var offset = i * 16
			var index = data.decode_s32(offset)
			var value = data.decode_s32(offset + 4)
			var date = data.decode_u64(offset + 8)
			_notify_received_iid_data(index, value, date)
	

func _notify_received_iid_data(index: int, value: int, date: int) -> void:
	if use_debug_print:
		print("Received IID data - Index: ", index, ", Value: ", value, ", Date: ", date)
	on_ii_data_received.emit(index, value)
	on_iid_data_received.emit(index, value, date)
