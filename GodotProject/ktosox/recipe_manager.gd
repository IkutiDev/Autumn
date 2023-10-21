extends Node

# sending recipie unlock notification

signal unlocked_recipe(recipeArray) # connect recpe book to this

# tracks when player gets access to new resource type (seed, eye)

func item_type_unlocked(resourceType : ItemBase.ITEM_TYPE): # called when item type is given to player
	if unlockedIngrediants.has(resourceType):
		return
	unlockedIngrediants.push_back(resourceType)
	# matches reqsource type against list of recipies
	for R in recipiesToUnlock.keys():
		var recipieHolder = R.duplicate()
		
		for I in unlockedIngrediants:
			while recipieHolder.has(I):
				recipieHolder.erase(I)
			print(recipieHolder)
			if recipieHolder.size() == 0:
				print("unlocked recpie: ",R)
				emit_signal("unlocked_recipe",R)
				unlockedFoods.push_back(recipiesToUnlock[R])
				recipiesToUnlock.erase(R)
		
		pass
	pass



# level tracking stuff

var allValidRecipies = {
	[ItemBase.ITEM_TYPE.Apple,ItemBase.ITEM_TYPE.Water,ItemBase.ITEM_TYPE.Water] : ItemBase.ITEM_TYPE.BadApple,
	[ItemBase.ITEM_TYPE.Mushroom,ItemBase.ITEM_TYPE.Mushroom,ItemBase.ITEM_TYPE.Water] : ItemBase.ITEM_TYPE.MushroomJelly,
	[ItemBase.ITEM_TYPE.Bone,ItemBase.ITEM_TYPE.Water,ItemBase.ITEM_TYPE.Worm] : ItemBase.ITEM_TYPE.Muffin,
	[ItemBase.ITEM_TYPE.Worm,ItemBase.ITEM_TYPE.Worm,ItemBase.ITEM_TYPE.Eye] : ItemBase.ITEM_TYPE.Spaghetti,
	[ItemBase.ITEM_TYPE.Bone,ItemBase.ITEM_TYPE.Water,ItemBase.ITEM_TYPE.Apple] : ItemBase.ITEM_TYPE.Croissant,
	[ItemBase.ITEM_TYPE.Bone,ItemBase.ITEM_TYPE.Water,ItemBase.ITEM_TYPE.Pumpkin] : ItemBase.ITEM_TYPE.Croissant,
	[ItemBase.ITEM_TYPE.Bone,ItemBase.ITEM_TYPE.Water,ItemBase.ITEM_TYPE.Mandrake] : ItemBase.ITEM_TYPE.Croissant,
	[ItemBase.ITEM_TYPE.Bone,ItemBase.ITEM_TYPE.Bone,ItemBase.ITEM_TYPE.Pumpkin] : ItemBase.ITEM_TYPE.Eclair,
	[ItemBase.ITEM_TYPE.Bone,ItemBase.ITEM_TYPE.Bone,ItemBase.ITEM_TYPE.Eye] : ItemBase.ITEM_TYPE.EyePie,
	[ItemBase.ITEM_TYPE.Bone,ItemBase.ITEM_TYPE.Mushroom,ItemBase.ITEM_TYPE.Mandrake] : ItemBase.ITEM_TYPE.DevilPie,
}



@onready var recipiesToUnlock = allValidRecipies.duplicate() # each time a new resource is unlocked all copies of it are removed key

var unlockedIngrediants = [0,1,2] # put the stuff the player starts with here

var unlockedFoods = []


func _ready():

	pass # Replace with function body.

