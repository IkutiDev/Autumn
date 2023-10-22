extends Node3D


var allKnownRecipies = [[0,4,4]]

func _ready():
	RecipeManager.connect("unlocked_recipe",add_recipie)
	re_fill_body()

func add_recipie(recipieArray):
	$Highlight.emitting = true
	print("adding: ", recipieArray)
	
	pass

func re_fill_body():
	var newTextBody = ""
	for rec in allKnownRecipies:
		var image = RecipeManager.itemToItemTypeMap[rec[0]].instantiate().item_image
		$TouchBox/CanvasLayer/ColorRectBackground/TextBody.add_image(image,64,64)
		$TouchBox/CanvasLayer/ColorRectBackground/TextBody.add_text("+")
		image = RecipeManager.itemToItemTypeMap[rec[1]].instantiate().item_image
		$TouchBox/CanvasLayer/ColorRectBackground/TextBody.add_image(image,64,64)
		$TouchBox/CanvasLayer/ColorRectBackground/TextBody.add_text("+")
		image = RecipeManager.itemToItemTypeMap[rec[2]].instantiate().item_image
		$TouchBox/CanvasLayer/ColorRectBackground/TextBody.add_image(image,64,64)
		$TouchBox/CanvasLayer/ColorRectBackground/TextBody.add_text("=")
		image = RecipeManager.itemToItemTypeMap[RecipeManager.allValidRecipies[rec]].instantiate().item_image
		$TouchBox/CanvasLayer/ColorRectBackground/TextBody.add_image(image,64,64)
		$TouchBox/CanvasLayer/ColorRectBackground/TextBody.newline()
	pass


func _on_touch_box_body_entered(body):
	$Highlight.emitting = false
	pass # Replace with function body.
