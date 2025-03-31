extends ColorRect

class_name SettingsContainer

var _world_environment : WorldEnvironment = null

@export_category("Objects")
@export var _fps_container : ColorRect = null

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		self.visible = not self.visible
		self.get_tree().paused = not self.get_tree().paused
		
		if self.visible:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			return
			
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _ready() -> void:
	self._world_environment = self.get_tree().get_nodes_in_group("environment")[0]
	
	for btn in self.get_tree().get_nodes_in_group("options_group"):
		if btn is CheckBox:
			btn.pressed.connect(_on_button_pressed.bind(btn))
			
		if btn is OptionButton:
			btn.item_selected.connect(_on_button_selected.bind(btn))
			
func _on_button_pressed(button_pressed: CheckBox) -> void:
	var parent : HBoxContainer = button_pressed.get_parent().get_parent()
	var text_property : String = parent.name.to_snake_case()
	
	print(text_property)
	
	match text_property:
		
		"use_taa":
			self.get_viewport().use_taa = button_pressed.button_pressed
			
		"display_fps":
			self._fps_container.visible = button_pressed.button_pressed
		
		"ssr_enabled":
			self._world_environment.environment.ssr_enabled = button_pressed.button_pressed
			
		"sso_enabled":
			self._world_environment.environment.ssao_enabled = button_pressed.button_pressed
			
		"ssil_enabled":
			self._world_environment.environment.ssil_enabled = button_pressed.button_pressed
			
		"sdfgi_enabled":
			self._world_environment.environment.sdfgi_enabled = button_pressed.button_pressed
	
	button_pressed.release_focus()
		
	
func _on_button_selected(index: int, button_pressed: OptionButton) -> void:
	var parent : HBoxContainer = button_pressed.get_parent()
	var text_property : String = parent.name.to_snake_case()
	
	match text_property:
		
		"screen_space_aa":
			self._update_screen_space_aa(index)
			
		"msaa_3d":
			self._update_msaa_3d(index)
	
	button_pressed.release_focus()

func _update_screen_space_aa(index : int) -> void:
	var viewport = self.get_viewport()
	
	match index:
		0: 
			viewport.screen_space_aa = Viewport.SCREEN_SPACE_AA_DISABLED
		
		1:
			viewport.screen_space_aa = Viewport.SCREEN_SPACE_AA_FXAA
			

func _update_msaa_3d(index: int) -> void:
	var viewport = self.get_viewport()
	
	match index:
		0:
			viewport.msaa_3d = viewport.MSAA_DISABLED 
		
		1:
			viewport.msaa_3d = viewport.MSAA_2X 
			
		2:
			viewport.msaa_3d = viewport.MSAA_4X
			
		3:
			viewport.msaa_3d = viewport.MSAA_8X
			
