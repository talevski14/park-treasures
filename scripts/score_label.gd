extends Label

var score = 0

func _on_treasure_collected():
	score += 1
	text = "Score: %s" % score
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
