class_name MusicManager
extends AudioStreamPlayer

func on_scene_changed(music_path: String):
	if stream.resource_path != music_path:
		stream = load(music_path)
		self.play(0)
