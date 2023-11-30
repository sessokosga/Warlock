extends Node

enum Sfx{
	Click
}

enum VoiceOver{
	GameOver,
	FinalRound
}

var click = preload("res://assets/sfx/interface/click_003.ogg")

func play_sfx(id:Sfx)->void:
	var stream
	match id:
		Sfx.Click:
			stream = click
		_:
			print("Invalid sfx id")
			return
	var asp = AudioStreamPlayer.new()
	asp.stream = stream
	asp.name = "SFX "
	add_child(asp)
	asp.play()
	await asp.finished
	asp.queue_free()

func play_voice_over(id:VoiceOver)->void:
	match id:
		VoiceOver.GameOver:
			pass
		VoiceOver.FinalRound:
			pass