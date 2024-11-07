extends Area2D
class_name MusicArea

@export var track : AudioStream # the track that should be played in this area

func _on_body_entered(body):
	if body is Player: # when the player enteres the area
		if body.music_area_array.is_empty(): # No music is currently playing
			if track:
				AudioManager.fade_music_in(track)
		else: # some music is already playing
			if track:
				AudioManager.crossfade_music_to(track)
		body.music_area_array.append(self)

func _on_body_exited(body):
	if body is Player: # when the player exits the area
		body.music_area_array.erase(self)
		if !body.music_area_array.is_empty(): # music was stacked
			var last_track : AudioStream = body.music_area_array[-1].track
			if last_track:
				AudioManager.crossfade_music_to(last_track)
		else: # no music stacked
			AudioManager.fade_music_out()
