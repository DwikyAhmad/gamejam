extends NodeState

@export var player: Player
@export var animated_sprite_2d: AnimatedSprite2D

@onready var crop_system: Node = get_tree().get_root().get_node("World/CropSystem")

func _on_process(_delta : float) -> void:
    pass

func _on_physics_process(_delta : float) -> void:
    pass

func _on_next_transitions() -> void:
    GameInputEvents.tool_input()
        
    var harvest_position = player.global_position

    # Offset based on player direction
    if !animated_sprite_2d.flip_h:
        harvest_position.x += 16
    else:
        harvest_position.x -= 16
        
    # Convert to tile coordinates
    var plant_tilemap: TileMapLayer = get_tree().get_root().get_node("World/Plants")
    var local_pos = plant_tilemap.to_local(harvest_position)
    var tile_pos = plant_tilemap.local_to_map(local_pos)
    
    # Try to harvest crop
    if crop_system.is_crop_harvestable(tile_pos):
        crop_system.harvest_crop(tile_pos)
    
    transition.emit("Idle")

func _on_enter() -> void:
    pass

func _on_exit() -> void:
    pass
