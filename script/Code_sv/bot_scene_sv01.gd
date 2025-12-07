extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var start_position: Vector2 = position
var speed: int = 100
var target: CharacterBody2D = null
var can_move: bool = true

var startHealth: int = 100
var health: int = startHealth

var target_position: Vector2 = Vector2.ZERO


# 
var wander_radius: float = 150.0  # Радиус блуждания
var wander_timer: float = 0.0     # Таймер для смены цели
# var wander_interval: float = 2.0  # Интервал смены цели (в секундах)
var wander_interval: float = randf_range(1.0, 4.0)  # Интервал сразу рандомный

# АКТИВАЦИЯ
var player: Node2D = null
var is_active: bool = false
@export var activation_distance: float = 500.0  # Радиус активации


func _ready():	
	add_to_group("enemy")
	# # Инициализируем случайную позицию для блуждания
	target_position = get_random_wander_target()

	# player = get_tree().get_first_node_in_group("player")
	# deactivate_bot()
	# set_process(true)  # Включаем _process для проверки расстояния

	# Тест смерти бота
	# # Смерть через 3 секунды для теста
	# await get_tree().create_timer(3.0).timeout
	# die()


# Функция для расчета рандомной позиции
func get_random_wander_target() -> Vector2:
	# Генерируем случайную точку в круге радиусом wander_radius
	var random_angle = randf_range(0, TAU)  # TAU = 2 * PI
	var random_distance = randf_range(0, wander_radius)
	
	# Вычисляем смещение от стартовой позиции
	var offset = Vector2(
		cos(random_angle) * random_distance,
		sin(random_angle) * random_distance
	)
	
	# Возвращаем конечную позицию
	return start_position + offset


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			set_target_to_mouse_click()


func set_target_to_mouse_click() -> void:
	# Получаем позицию мыши в глобальных координатах мира
	target_position = get_global_mouse_position()
	# print("Новая цель установлена: ", target_position)


func _physics_process(delta: float) -> void:
	if !can_move:		
		print("Не можем двигаться")
		return

	var move_direction = Vector2.ZERO

	# ДОБАВЛЯЕМ ПРОВЕРКУ ДОСТИЖЕНИЯ ЦЕЛИ
	var distance_to_target = position.distance_to(target_position)
	if distance_to_target < 5.0:  # Если близко к цели (5 пикселей)
		# Получаем новую случайную цель
		target_position = get_random_wander_target()
		wander_timer = 0.0  # Сбрасываем таймер
		# print("Цель достигнута, новая цель: ", target_position)

	# ДОБАВИТЬ обновление таймера и смену цели
	wander_timer += delta
	if wander_timer >= wander_interval:
		target_position = get_random_wander_target()
		wander_timer = 0.0
		# print("Случайная цель: ", target_position)

	# Двигаемся к цели (target_position)
	if target_position:
		move_direction = (target_position - position).normalized()
	
	if move_direction.length() > 0:
		velocity = move_direction * speed
		move_and_slide()
		
		# Проверяем все коллизии на текущем кадре
		for i in get_slide_collision_count():
			var collision = get_slide_collision(i)
			var collider = collision.get_collider()
			
			# print("Столкнулся с: ", collider.name)
			
			# Если уперлись в стену, меняем направление
			# if collider is TileMap or collider.name.contains("Wall"):
			target_position = get_random_wander_target()
			wander_timer = 0.0
			break
				
	# if move_direction.length() > 0:
	# 	velocity = move_direction * speed
	# 	move_and_slide()
	# 	anim.flip_h = move_direction.x < 0


func die() -> bool:
	print("who is die?")
	can_move = false
	velocity = Vector2.ZERO
	# Останавливаем все таймеры или процессы, если они есть
	set_physics_process(false)
	print("Бот умер (заморожен)")
	
	# Отключаем коллайдер
	# var collision_shape = $CollisionShape2D  # или другой нод с коллайдером
	# if collision_shape:
	# 	collision_shape.set_deferred("disabled", true)

	remove_from_group("enemy")
	add_to_group("dead_body")

	return true
	# # # Меняем спрайт
	# if anim:
	#     if anim.has_animation("dead"):
	#         anim.play("dead")
	#     else:
	#         anim.visible = false
