extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var start_position: Vector2 = position
var speed: int = 50
var target: CharacterBody2D = null
var can_move: bool = true

var startHealth: int = 100
var health: int = startHealth

var target_position: Vector2 = Vector2.ZERO


func _ready():	
	add_to_group("enemy")
	# Устанавливаем начальную цель в координаты (500, 500)
	target_position = Vector2(500, 500)



func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			set_target_to_mouse_click()


func set_target_to_mouse_click() -> void:
	# Получаем позицию мыши в глобальных координатах мира
	target_position = get_global_mouse_position()
	print("Новая цель установлена: ", target_position)


func _physics_process(_delta: float) -> void:
	if !can_move:		
		print("Не можем двигаться")
		return

	var move_direction = Vector2.ZERO


	# Двигаемся к цели (target_position)
	if target_position:
		move_direction = (target_position - position).normalized()
	
	if move_direction.length() > 0:
		velocity = move_direction * speed
		move_and_slide()
		anim.flip_h = move_direction.x < 0


	# ВРЕМЕННО: всегда двигаться вправо для теста
	# move_direction = Vector2.RIGHT
	
	# if move_direction.length() > 0:
	# 	velocity = move_direction * speed
	# 	move_and_slide()
	# 	anim.flip_h = move_direction.x < 0


func die():
	pass

	# if target and target.name == "player":
	# 	move_direction = (target.position - position).normalized()
	# elif position.distance_to(start_position) > 5.0:
	# 	move_direction = (start_position - position).normalized()
  
	# if move_direction.length() > 0:
	# 	velocity = move_direction * speed
	# 	move_and_slide()
	# 	# anim.play("Walk")
	# 	anim.flip_h = move_direction.x < 0
	# else:
	# 	velocity = Vector2.ZERO
	# 	# anim.play("Idle")

# # Функция для установки цели
# func set_target(new_target: Vector2) -> void:
#   target = new_target
