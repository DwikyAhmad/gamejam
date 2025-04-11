extends NodeState

@export var player: Player
@export var animated_sprite_2d: AnimatedSprite2D

@onready var ground_tilemap: TileMapLayer = get_tree().get_root().get_node("World/DiggedGrounds")
@onready var plant_tilemap: TileMapLayer = get_tree().get_root().get_node("World/Plants")
var plant_tile_coords = []

func _on_process(_delta : float) -> void:
    pass


func _on_physics_process(_delta : float) -> void:
    pass


func _on_next_transitions() -> void:
    GameInputEvents.tool_input()
        
    var plant_position = player.global_position

    # Offset berdasarkan arah player
    if !animated_sprite_2d.flip_h:
        plant_position.x += 16 # Gali ke kanan
    else:
        plant_position.x -= 16 # Gali ke kiri
        
    # Konversi posisi global ke posisi lokal tilemap
    var local_pos = ground_tilemap.to_local(plant_position)
    # Konversi posisi lokal ke koordinat tile
    var tile_pos = ground_tilemap.local_to_map(local_pos)
    
    print("Global pos: ", plant_position)
    print("Local pos: ", local_pos)
    print("Tile pos: ", tile_pos)
    
    if tile_pos not in plant_tile_coords:
        var tile_data = ground_tilemap.get_cell_tile_data(tile_pos)
        if tile_data and ((ground_tilemap.get_cell_atlas_coords(tile_pos) == Vector2i(50, 12) or ground_tilemap.get_cell_atlas_coords(tile_pos) == Vector2i(50, 13))):
            plant_tile_coords.append(tile_pos)
            plant_tilemap.set_cell(tile_pos, 2, Vector2i(53, 12))  
            Goals.goal_tracker.increment_seed()

    transition.emit("Idle")

    pass


func _on_enter() -> void:
    pass


func _on_exit() -> void:

    pass
