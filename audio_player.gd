extends AudioStreamPlayer

const game_music = preload("res://assets/sounds/background_music.mp3")

func _play_music(music: AudioStream, volume = 0.0):
	if stream == music:
		return
	
	stream = music
	volume_db = volume
	play()

func play_music_game():
	_play_music(game_music)
	
