extends Panda

class_name Body 

const  _LERP_VELOCITY: float = 0.15

@export_category("Objects")
@export var _character : CharacterBody3D = null


func apply_rotation(velocity : Vector3) -> void:
	self.rotation.y = lerp_angle(
		self.rotation.y,
		atan2(-velocity.x, -velocity.z),
		_LERP_VELOCITY
	)

func animate(velocity : Vector3) -> void:
	if velocity:
		if self._character.is_running():
			self.play_animation("Run")
			return
		
		self.play_animation("Walk")
		return
	
	self.play_animation("Idle")
		
			
			
