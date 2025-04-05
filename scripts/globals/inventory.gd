extends Node

var items = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    items.resize(9)
    items[0] = DataTypes.Tools.Axe
    items[1] = DataTypes.Tools.Water
    items[2] = DataTypes.Tools.Pickaxe
    items[3] = DataTypes.Tools.Shovel
    items[4] = DataTypes.Tools.Corn
    items[5] = DataTypes.Tools.None
    items[6] = DataTypes.Tools.None
    items[7] = DataTypes.Tools.None
    items[8] = DataTypes.Tools.None
    
    pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass
