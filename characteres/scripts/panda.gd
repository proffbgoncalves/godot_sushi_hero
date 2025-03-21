extends Node3D
class_name Panda

@export_category("Objects")
@export var _animation_player : AnimationPlayer = null

func play_animation(name : String) -> void:
	self._animation_player.play(name)
