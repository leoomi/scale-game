extends Control

const MUSIC_BUS = "Music"
const SFX_BUS = "SFX"

func _ready():
	pass
	
func FocusEntered():
	$Focus.play()

func _on_start_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://TestLevel.tscn")


func _on_options_btn_pressed():
	$MainMenu.hide()
	$Options.show()
	$Back.show()

func _on_quit_btn_pressed():
	get_tree().quit()


func _on_master_slider_value_changed(value):
	if value == -15:
		AudioServer.set_bus_mute(0,true)
	else:
		AudioServer.set_bus_mute(0,false)
	AudioServer.set_bus_volume_db(0,value)


func _on_back_pressed():
	$MainMenu.show()
	$Options.hide()
	$Back.hide()


func _on_music_slider_value_changed(value):
	var BusInt = AudioServer.get_bus_index(MUSIC_BUS)
	if value == -15:
		AudioServer.set_bus_mute(BusInt,true)
	else:
		AudioServer.set_bus_mute(BusInt,false)
	AudioServer.set_bus_volume_db(BusInt,value)


func _on_sfx_slider_value_changed(value):
	var BusInt = AudioServer.get_bus_index(SFX_BUS)
	if value == -15:
		AudioServer.set_bus_mute(BusInt,true)
	else:
		AudioServer.set_bus_mute(BusInt,false)
	AudioServer.set_bus_volume_db(BusInt,value)
