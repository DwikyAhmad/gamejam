extends NodeState

@export var player: Player
@export var animated_sprite_2d: AnimatedSprite2D

# Gunakan onready var untuk mendapatkan referensi ke tilemap
@onready var ground_tilemap: TileMapLayer = get_tree().get_root().get_node("World/DiggedGrounds") # Sesuaikan dengan path tilemap di scene world
var digged_tile_coords = []

func _on_process(_delta: float) -> void:
    pass


func _on_physics_process(_delta: float) -> void:
    pass


func _on_next_transitions() -> void:
    GameInputEvents.tool_input()
    if !animated_sprite_2d.is_playing():
         # Coba gali tanah di depan player
        var dig_position = player.global_position

        dig_position.y += 8  # Sesuaikan nilai ini dengan tinggi karakter/2

        # Offset berdasarkan arah player
        if !animated_sprite_2d.flip_h:
            dig_position.x += 16 # Gali ke kanan
        else:
            dig_position.x -= 16 # Gali ke kiri
            
        # Konversi posisi global ke posisi lokal tilemap
        var local_pos = ground_tilemap.to_local(dig_position)
        # Konversi posisi lokal ke koordinat tile
        var tile_pos = ground_tilemap.local_to_map(local_pos)
        
        print("Global pos: ", dig_position)
        print("Local pos: ", local_pos)
        print("Tile pos: ", tile_pos)
        
        # Cek apakah tile sudah digali
        if not tile_pos in digged_tile_coords:
            # Dapatkan layer dan atlas coords dari tile saat ini
            var tile_data = ground_tilemap.get_cell_tile_data(tile_pos)
            if !tile_data:
                # Ganti dengan tile yang sudah digali
                # Sesuaikan source_id dan atlas_coords dengan tile yang digali di tileset Anda
                ground_tilemap.set_cell(tile_pos, 0, Vector2i(50, 12)) # Sesuaikan koordinat atlas untuk tile yang digali
                digged_tile_coords.append(tile_pos)

        transition.emit("Idle")
    pass


func _on_enter() -> void:
    animated_sprite_2d.play("dig")
    pass


func _on_exit() -> void:
    animated_sprite_2d.stop()
    pass

# Fungsi tambahan untuk mendapatkan data galian untuk save
func get_save_data() -> Array:
    var serialized_tiles = []
    for tile_pos in digged_tile_coords:
        serialized_tiles.append({"x": tile_pos.x, "y": tile_pos.y})
    return serialized_tiles

# Fungsi untuk memuat ulang data galian dari save
func load_save_data(data: Array) -> void:
    digged_tile_coords.clear()
    for tile_data in data:
        var tile_pos = Vector2i(tile_data["x"], tile_data["y"])
        digged_tile_coords.append(tile_pos)
        ground_tilemap.set_cell(tile_pos, 0, Vector2i(50, 12))
