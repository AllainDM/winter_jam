extends CanvasLayer

@onready var finish_words: Label = $PanelContainer/TextureRect/Panel/FinishWords
@onready var quantity_gift: Label = $PanelContainer/TextureRect/UiGift/QuantityGift

func _ready() -> void:
	pass

func victory(need_gifts, found_giftsfinish_words):
	print("Игра окнчена")
	visible = !visible
	if found_giftsfinish_words >= need_gifts:
		finish_words.text = "Дети довольны, все подарки собраны"
	else:
		finish_words.text = "Эльфы довольны, они унесли: " + (need_gifts - found_giftsfinish_words) + "подарков"
