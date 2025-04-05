extends Area3D
class_name Table

const _STOOL: PackedScene = preload("res://furniture/environment/stool.tscn")

var _chair_positions : Array = [
	Vector3(0, 0, 2),
	Vector3(2, 0, 0),
	Vector3(-2, 0, 0),
	Vector3(0, 0, -2)
]

var _chair_offset_positions : Array = [
	Vector3(0, 0, 0.4),
	Vector3(0.4, 0, 0),
	Vector3(-0.4, 0, 0),
	Vector3(0, 0, -0.4)
]

var _angle_rotation : Array = [
	0,
	PI/2,
	-PI + PI/2,
	PI
]

var _offset: Vector3 = Vector3.ZERO

@export_category("Variables")
@export var _chais_amount: int = 1
@export var _is_available: bool = true

@export_category("Objects")
@export var _stools: Node3D = null

func _ready() -> void:
	for chair in self._chais_amount:
		var new_chair = _STOOL.instantiate()
		new_chair.transform.origin = self._chair_positions[chair]
		
		self._stools.add_child(new_chair)
		
func is_available(entity) -> void:
	if not self._is_available:
		entity.update_state("seek_table")
		return
	
	var index : int = randi() % self._stools.get_child_count()
	var rotation : float = self._angle_rotation[index]
	
	self._offset = self._chair_positions[index] - self._chair_offset_positions[index]
	entity.update_state("walking", self._offset, self.global_position, rotation)
	
	self.change_available_state(false)
	
func change_available_state(state: bool) -> void:
	self._is_available = state
