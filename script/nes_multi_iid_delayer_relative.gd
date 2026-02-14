class_name NesMultiIidDelayerRelative extends Node


signal on_ready_to_be_executed(index: int, value: int, date: int)
signal on_ready_to_be_executed_with_relative(index: int, value: int, date: int,to_execute_time: int, relative_time_in_milliseconds: int)

@export_group("For Debuggging")
@export var waiting_iid_count: int

const IS_UNDER_ONE_DAY_MS: int = 1000 * 3600 * 24

var delayed_iid_list: Array = []


class DelayedII:
	var index: int
	var value: int
	var date: int
	var execute_time_milliseconds: int
	var relative_time_milliseconds: int

	func _init(_index: int, _value: int, _date: int, _execute_time_ms: int, _relative_time_ms: int) -> void:
		index = _index
		value = _value
		date = _date
		execute_time_milliseconds = _execute_time_ms
		relative_time_milliseconds = _relative_time_ms


func _process(delta: float) -> void:
	var current_time_ms = get_current_time_ms()
	for i in range(delayed_iid_list.size() - 1, -1, -1):
		if current_time_ms >= delayed_iid_list[i].execute_time_milliseconds:
			var delayed_ii = delayed_iid_list[i]
			delayed_iid_list.remove_at(i)
			on_ready_to_be_executed.emit(delayed_ii.index, delayed_ii.value, delayed_ii.date)
			on_ready_to_be_executed_with_relative.emit(delayed_ii.index, delayed_ii.value, delayed_ii.date, delayed_ii.execute_time_milliseconds, delayed_ii.relative_time_milliseconds)
	waiting_iid_count = delayed_iid_list.size()


func get_current_time_ms() -> int:
	return Time.get_ticks_msec()


func append_delay_iid_data(index: int, value: int, date: int) -> void:
	var time = get_current_time_ms()
	if date > IS_UNDER_ONE_DAY_MS or date == 0:
		on_ready_to_be_executed.emit(index, value, date)
		on_ready_to_be_executed_with_relative.emit(index, value, date, time, 0)
		return 
	var relative_time_ms = date
	var time_and_relative = time + relative_time_ms
	var delayed_ii = DelayedII.new(index, value, date, time_and_relative, relative_time_ms)
	delayed_iid_list.append(delayed_ii)
	waiting_iid_count = delayed_iid_list.size()
