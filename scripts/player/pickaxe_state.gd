extends NodeState

@export var player: Player
@export var animated_sprite_2d: AnimatedSprite2D

@onready var ground_tilemap: TileMapLayer = get_tree().get_root().get_node("World/DiggedGrounds")

func _on_process(_delta: float) -> void:
    pass


func _on_physics_process(_delta: float) -> void:
    pass


func _on_next_transitions() -> void:
    GameInputEvents.tool_input()
    if !animated_sprite_2d.is_playing():
         # Coba gali batu di depan player
        var mine_position = player.global_position

        # Offset berdasarkan arah player
        if !animated_sprite_2d.flip_h:
            mine_position.x += 16 # Gali ke kanan
        else:
            mine_position.x -= 16 # Gali ke kiri
            
        # Konversi posisi global ke posisi lokal tilemap
        var local_pos = ground_tilemap.to_local(mine_position)
        # Konversi posisi lokal ke koordinat tile
        var tile_pos = ground_tilemap.local_to_map(local_pos)
        
        print("Global pos: ", mine_position)
        print("Local pos: ", local_pos)
        print("Tile pos: ", tile_pos)
        
        # Cek apakah tile adalah batu
        var tile_data = ground_tilemap.get_cell_tile_data(tile_pos)
        if tile_data and ground_tilemap.get_cell_atlas_coords(tile_pos) == Vector2i(31, 4):
            # Hapus tile
            ground_tilemap.set_cell(tile_pos, -1)  # -1 untuk menghapus tile
            Goals.goal_tracker.increment_stone()        

        transition.emit("Idle")
    pass


func _on_enter() -> void:
    animated_sprite_2d.play("pickaxe")
    pass


func _on_exit() -> void:
    animated_sprite_2d.stop()
    pass
