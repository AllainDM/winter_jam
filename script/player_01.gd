extends CharacterBody2D

@onready var anim : AnimatedSprite2D = $AnimatedSprite2D
const SPEED : float = 300.0
var is_attacking : bool = false

func _physics_process(_delta: float) -> void:
	var input_vector : Vector2 = Vector2.ZERO
	input_vector.x = Input.get_axis("ui_left", "ui_right")
	input_vector.y = Input.get_axis("ui_up", "ui_down")
	
	input_vector = input_vector.normalized()

	if is_attacking:
		pass
	elif input_vector != Vector2.ZERO:
		anim.play("walk_down")
		velocity = input_vector * SPEED
	elif input_vector == Vector2.ZERO and velocity == Vector2.ZERO:
		anim.play("idle_down")
	else:
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)
	move_and_slide()

func _on_hitbox_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		print("player toches enemy")
		body.die()
		is_attacking = true
		anim.play("attack_down")
		await get_tree().create_timer(2.0).timeout
		is_attacking = false
	pass
