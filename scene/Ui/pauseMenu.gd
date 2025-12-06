extends CanvasLayer

func _input(event):
	if event.is_action_pressed("Pause"):
		print("Кнопка паузы нажата!")
		visible = !visible
		#get_tree().paused = true
		
