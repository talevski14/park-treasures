extends Label

var score = 0

func _on_treasure_collected():
	score += 1
	text = "%s" % score
