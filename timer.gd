extends CanvasLayer

#@onready var canvas_layer: CanvasLayer = $"."
@onready var label: Label = $Control/PanelContainer/VBoxContainer/Label
var time_left: float = 60.0

func _ready() -> void:
	time_left = 60.0  # 60 секунд = 1 минута = от 23:59:00
	_update_label()

func _process(delta: float) -> void:
	if time_left > 0:
		time_left -= delta
		_update_label()
		
		if time_left <= 0:
			time_left = 0
			_update_label()
			_on_new_year()
			set_process(false)

func _update_label() -> void:
	if time_left <= 0:
		label.text = "00:00:00"
		return
	
	# Вычисляем минуты и секунды
	var total_seconds = int(time_left)
	var minutes = total_seconds / 60
	var seconds = total_seconds % 60
	
	# Инвертируем для отображения от 23:59:00
	var display_minutes = 59 - minutes
	var display_seconds = 59 - seconds
	
	# Корректировка для правильного отображения
	if display_seconds < 0:
		display_seconds += 60
		display_minutes -= 1
	
	# Форматируем как 23:MM:SS
	var time_str = "23:%02d:%02d" % [display_minutes, display_seconds]
	
	label.text = time_str
	# print("Debug: ", time_str, " time_left: ", time_left)

func _on_new_year() -> void:
	label.text = "00:00:00\nС Новым Годом!"

# func _ready() -> void:
# 	_update_label()  # Показываем начальное время

# func _process(delta: float) -> void:
# 	if time_left > 0:
# 		time_left -= delta
# 		_update_label()
		
# 		if time_left <= 0:
# 			time_left = 0
# 			_update_label()
# 			_on_new_year()
# 			set_process(false)  # Останавливаем обновление

# func _update_label() -> void:
# 	var total_seconds = int(time_left)
# 	var seconds = total_seconds % 60
# 	var minutes = total_seconds / 60
# 	# var centiseconds = int((time_left - total_seconds) * 100)  # сотые доли
	
# 	# Вычисляем отображаемое время
# 	var display_minutes = 0
# 	var display_seconds = 59 - seconds
# 	# var display_cs = 99 - centiseconds
	
# 	# # Корректировка
# 	# if display_cs < 0:
# 	# 	# display_cs += 100
# 	# 	display_seconds -= 1
	
# 	if display_seconds < 0:
# 		display_seconds += 60
# 		display_minutes -= 1
	
# 	# Форматирование - ТРИ параметра должно быть
# 	var time_str = "23:%02d:%02d" % [display_minutes, display_seconds]
	
# 	if time_left <= 0:
# 		time_str = "00:00:00"
	
# 	label.text = time_str
# 	print("Debug: ", time_str, " time_left: ", time_left)  # Для отладки
# 	label.text = time_str

# func _on_new_year() -> void:
# 	label.text = "00:00:00\nС Новым Годом!"
# 	# Добавьте здесь эффекты, звуки и т.д.
