extends Node3D
class_name CharacterSpringArm

const _MOUSE_SENSIBILITY: float = 0.003

@export_category("Objects")
@export var _spring_arm: SpringArm3D = null

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		self.rotate_y(-event.relative.x * _MOUSE_SENSIBILITY)
		self._spring_arm.rotate_x(-event.relative.y * _MOUSE_SENSIBILITY)
		self._spring_arm.rotation.x = clamp(self._spring_arm.rotation.x, -PI/4, PI/24)
