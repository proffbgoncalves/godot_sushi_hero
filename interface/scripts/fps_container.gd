extends ColorRect
class_name FPSContainer

@export_category("Objects")
@export var _fps: Label = null

func _physics_process(delta: float) -> void:
	self._fps.text = str(Engine.get_frames_per_second())
