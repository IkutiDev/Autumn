extends Node3D


var allKnownRecipies = []

func _ready():
	RecipeManager.connect("unlocked_recipe",add_recipie)


func add_recipie(recipieArray):
	$Highlight.emitting = true
	allKnownRecipies.push_back(recipieArray)
	
	print("adding: ", recipieArray)
	re_fill_body()
	pass

func re_fill_body():
	$TouchBox/CanvasLayer/ColorRectBackground/TextBody.clear()
	for rec in allKnownRecipies:
		var image = RecipeManager.itemToItemTypeMap[rec[0]].instantiate().item_image
		$TouchBox/CanvasLayer/ColorRectBackground/TextBody.add_image(image,96,96)
		$TouchBox/CanvasLayer/ColorRectBackground/TextBody.add_text("+")
		image = RecipeManager.itemToItemTypeMap[rec[1]].instantiate().item_image
		$TouchBox/CanvasLayer/ColorRectBackground/TextBody.add_image(image,96,96)
		$TouchBox/CanvasLayer/ColorRectBackground/TextBody.add_text("+")
		image = RecipeManager.itemToItemTypeMap[rec[2]].instantiate().item_image
		$TouchBox/CanvasLayer/ColorRectBackground/TextBody.add_image(image,96,96)
		$TouchBox/CanvasLayer/ColorRectBackground/TextBody.add_text("=")
		image = RecipeManager.itemToItemTypeMap[RecipeManager.allValidRecipies[rec]].instantiate().item_image
		$TouchBox/CanvasLayer/ColorRectBackground/TextBody.add_image(image,96,96)
		$TouchBox/CanvasLayer/ColorRectBackground/TextBody.newline()
	pass


func _on_touch_box_body_entered(body):
	$Highlight.emitting = false
	pass # Replace with function body.
