extends CharacterBody3D

class_name Character

const _NORMAL_SPEED: float = 5.0
const _SPRINT_SPEED: float = 9.0

var _current_speed: float

@export_category("Objects")
@export var _body: Node3D = null
@export var _spring_arm_offset: Node3D = null

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta: float) -> void:
	self._move()
	self.move_and_slide()
	self._body.animate(self.velocity)
	
func _move() -> void:
	var _input_direction: Vector2 = Input.get_vector(
		"move_left", 
		"move_right", 
		"move_forward", 
		"move_backward"
	)
	
	var _direction: Vector3 = transform.basis * Vector3(
		_input_direction.x,
		0,
		_input_direction.y
	).normalized()
	
	is_running()
	
	_direction = _direction.rotated(Vector3.UP, self._spring_arm_offset.rotation.y)
	
	if _direction:
		self.velocity.x = _direction.x * _current_speed
		self.velocity.z = _direction.z * _current_speed
		return
		
	self.velocity.x = move_toward(self.velocity.x, 0, self._current_speed)
	self.velocity.z = move_toward(self.velocity.z, 0, self._current_speed)
	
	
func is_running() -> bool:
	if (Input.is_action_pressed("shift")):
		self._current_speed = _SPRINT_SPEED
		return true
	
	self._current_speed = _NORMAL_SPEED
	return false


	
	
