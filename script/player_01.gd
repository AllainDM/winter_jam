extends CharacterBody2D

@onready var anim : AnimatedSprite2D = $AnimatedSprite2D
const SPEED : float = 200.0
var is_attacking : bool = false
var attack_cooldown_time : float = 0.5
var attack_cooldown : float = attack_cooldown_time

# Счетчик пойманных эльфов и найденных подарков
var frozen_elves = 0
var found_gifts = 0

# Необходимо найти подарков для победы.
var need_gifts = 5

@onready var hitSoundPlayer : AudioStreamPlayer2D = $"hit-box_Area2D/AudioStreamPlayer2D"
var hit_tracks = [
	"res://Assets/MusicSound/freeze.ogg"
	]

func _ready():
	add_to_group("player")

func _physics_process(delta: float) -> void:
	
	if attack_cooldown > 0:
		attack_cooldown -= delta
		if attack_cooldown <= 0:
			is_attacking = false

	var input_vector : Vector2 = Vector2.ZERO
	if !is_attacking:
		input_vector.x = Input.get_axis("ui_left", "ui_right")
		input_vector.y = Input.get_axis("ui_up", "ui_down")
		input_vector = input_vector.normalized()

	if is_attacking:
		velocity = Vector2.ZERO
	elif input_vector != Vector2.ZERO:
		anim.play("walk_down")
		velocity = input_vector * SPEED
	elif input_vector == Vector2.ZERO and velocity == Vector2.ZERO:
		anim.play("idle_down")
	else:
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)
	move_and_slide()

func _on_hitbox_area_2d_body_entered(body: Node2D) -> void:
	var enemy_is_die = false
	if body.is_in_group("enemy"):
		print("player toches enemy")
		enemy_is_die = body.die()
		
		is_attacking = true
		anim.play("attack_down")
		attack_cooldown = attack_cooldown_time
		
		playFreezSound ()
		if enemy_is_die:
			frozen_elves += 1
			found_gifts += 1
			if found_gifts >= need_gifts:
				victory()
	print("Заморожено эльфов: ", frozen_elves)
	print("Найдено подарков: ", found_gifts)

func playFreezSound () -> void:
	var random_track = load(hit_tracks[randi() % hit_tracks.size()])
	hitSoundPlayer.stream = random_track
	hitSoundPlayer.play()


func victory():
	print("Победа")
