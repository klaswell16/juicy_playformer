extends CanvasLayer



func _ready() -> void:
	PlatformerGameController.coin_collected.connect(coin_collected)
	pass # Replace with function body.

func coin_collected():
	$txtCoins.text = "Coins: " + str(PlatformerGameController.coins_collected)
	


func _process(delta: float) -> void:
	pass
