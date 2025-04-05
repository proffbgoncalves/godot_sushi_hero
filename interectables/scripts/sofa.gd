extends MeshInstance3D

class_name Sofa

var _offset: Vector3 = Vector3(0, 0.25, 0.02)
var _is_vailable: bool = true

func change_available_state(state: bool) -> void:
	self._is_vailable = state
	
func has_available_slot(entity) -> void:
	if self._is_vailable:
		entity.update_state("walking", self._offset, self.global_position)
		self.change_available_state(false)
		return
	
	entity.update_state("seek_sofa")
