extends Node2D

@onready var animPlayer : AnimationPlayer = $AnimationPlayer
@onready var playerSprite : AnimatedSprite2D = $Player/AnimatedSprite2D
@onready var lepriconSprite : AnimatedSprite2D = $Leprikon/AnimatedSprite2D
@onready var lepricon2Sprite : AnimatedSprite2D = $Leprikon2/AnimatedSprite2D
@onready var lepricon3Sprite : AnimatedSprite2D = $Leprikon3/AnimatedSprite2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $Leprikon/AudioStreamPlayer2D
@onready var audio_stream_player_2d_2: AudioStreamPlayer2D = $Leprikon2/AudioStreamPlayer2D
@onready var audio_stream_player_2d_3: AudioStreamPlayer2D = $Leprikon3/AudioStreamPlayer2D

func _ready() -> void:
	animPlayer.play("player_leprikon_move")
	audio_stream_player_2d.play()
	await animPlayer.animation_finished
	audio_stream_player_2d_2.play()
	playerSprite.play("idle")
	lepriconSprite.play("idle")
	lepricon2Sprite.play("idle")
	lepricon3Sprite.play("idle")
	await get_tree().create_timer(2.5).timeout
	audio_stream_player_2d_3.play()
	playerSprite.play("walk")
	lepriconSprite.play("walk")
	lepricon2Sprite.play("walk")
	lepricon3Sprite.play("walk")
	animPlayer.play("runAway")
	await animPlayer.animation_finished
	audio_stream_player_2d.play()
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://scene/sv_scenes_01/lvl_sv_02.tscn")
	
