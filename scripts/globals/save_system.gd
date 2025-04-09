extends Node

const SAVE_FILE_PATH = "user://game_save.dat"

# Data utama yang akan disimpan
var game_data = {
    "player_position": Vector2.ZERO,
    "player_direction": Vector2.ZERO,
    "current_tool": 0,
    "inventory": [],
    "digged_tiles": [] # Untuk menyimpan tiles yang sudah digali
}

# Simpan data ke file
func save_game():
    var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)
    if file:
        # Kumpulkan data yang perlu disimpan
        collect_game_data()
        
        # Konversi data menjadi JSON string
        var json_string = JSON.stringify(game_data)
        
        # Tulis ke file
        file.store_string(json_string)
        print("Game berhasil disimpan!")
    else:
        print("Gagal menyimpan game!")

# Memuat data dari file
func load_game():
    if FileAccess.file_exists(SAVE_FILE_PATH):
        var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)
        if file:
            var json_string = file.get_as_text()
            var json = JSON.new()
            var error = json.parse(json_string)
            
            if error == OK:
                var loaded_data = json.get_data()
                game_data = loaded_data
                print("Game berhasil dimuat!")
                
                # Terapkan data yang dimuat
                apply_loaded_data()
                return true
            else:
                print("Gagal mem-parse file save!")
    
    print("File save tidak ditemukan atau rusak!")
    return false

# Mengumpulkan data game untuk disimpan
func collect_game_data():
    # Dapatkan referensi player
    var player = get_tree().get_first_node_in_group("player")
    if player:
        game_data["player_position"] = {"x": player.global_position.x, "y": player.global_position.y}
        game_data["player_direction"] = {"x": player.player_direction.x, "y": player.player_direction.y}
        game_data["current_tool"] = Player.current_tool
    
    # Simpan inventory
    game_data["inventory"] = Inventory.items.duplicate()
    
    # Dapatkan data tiles yang sudah digali
    var dig_state = get_tree().get_first_node_in_group("player").get_node("StateMachine/Dig")
    if dig_state:
        # Konversi Vector2i menjadi array agar bisa diserialisasi
        var serialized_tiles = []
        for tile_pos in dig_state.digged_tile_coords:
            serialized_tiles.append({"x": tile_pos.x, "y": tile_pos.y})
        
        game_data["digged_tiles"] = serialized_tiles

# Menerapkan data yang telah dimuat
func apply_loaded_data():
    # Dapatkan referensi player
    var player = get_tree().get_first_node_in_group("player")
    if player:
        player.global_position = Vector2(game_data["player_position"]["x"], game_data["player_position"]["y"])
        player.player_direction = Vector2(game_data["player_direction"]["x"], game_data["player_direction"]["y"])
        Player.current_tool = game_data["current_tool"]
    
    # Terapkan inventory
    Inventory.items = game_data["inventory"].duplicate()
    
    # Terapkan tiles yang sudah digali
    var dig_state = get_tree().get_first_node_in_group("player").get_node("StateMachine/Dig")
    if dig_state:
        # Reset digged_tile_coords
        dig_state.digged_tile_coords.clear()

        # Hapus semua tile yang sudah digali
        dig_state.ground_tilemap.clear()
        
        # Tambahkan kembali semua tile yang sudah digali
        for tile_data in game_data["digged_tiles"]:
            var tile_pos = Vector2i(tile_data["x"], tile_data["y"])
            dig_state.digged_tile_coords.append(tile_pos)
            
            # Ganti tile pada tilemap
            dig_state.ground_tilemap.set_cell(tile_pos, 0, Vector2i(50, 12))
