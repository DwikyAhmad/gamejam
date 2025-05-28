extends Node

signal crop_ready_for_harvest(position: Vector2i)

@onready var plant_tilemap: TileMapLayer = get_tree().get_root().get_node("World/Plants")
@onready var ground_tilemap: TileMapLayer = get_tree().get_root().get_node("World/DiggedGrounds")

# Dictionary to track planted crops: {Vector2i: crop_data}
var planted_crops = {}

# Crop growth stages (tile coordinates for different growth phases)
var corn_growth_stages = [
    Vector2i(1, 4),  # Seed
    Vector2i(2, 4),  # Sprout
    Vector2i(3, 4),  # Small plant
    Vector2i(4, 4),  # Medium plant
    Vector2i(5, 4),  # Large plant
    Vector2i(6, 4),  # Fully grown (harvestable)
]

# Growth time per stage (in seconds)
var growth_time_per_stage = 5.0  # Adjust this for game balance

func _ready():
    # Connect to existing plant events if needed
    pass

func plant_crop(tile_pos: Vector2i, crop_type: String = "corn"):
    var crop_data = {
        "type": crop_type,
        "stage": 0,
        "planted_time": Time.get_time_dict_from_system(),
        "last_growth_time": Time.get_time_dict_from_system()
    }
    
    planted_crops[tile_pos] = crop_data
    update_crop_visual(tile_pos)
    
    print("Planted ", crop_type, " at ", tile_pos)

func _process(_delta):
    update_crop_growth()

func update_crop_growth():
    var current_time = Time.get_time_dict_from_system()
    
    for tile_pos in planted_crops.keys():
        var crop = planted_crops[tile_pos]
        
        # Calculate time since last growth
        var time_diff = get_time_difference(crop.last_growth_time, current_time)
        
        if time_diff >= growth_time_per_stage and crop.stage < corn_growth_stages.size() - 1:
            crop.stage += 1
            crop.last_growth_time = current_time
            update_crop_visual(tile_pos)
            
            # Check if crop is ready for harvest
            if crop.stage == corn_growth_stages.size() - 1:
                emit_signal("crop_ready_for_harvest", tile_pos)
                print("Crop at ", tile_pos, " is ready for harvest!")

func update_crop_visual(tile_pos: Vector2i):
    var crop = planted_crops[tile_pos]
    if crop.type == "corn" and crop.stage < corn_growth_stages.size():
        plant_tilemap.set_cell(tile_pos, 0, corn_growth_stages[crop.stage])

func harvest_crop(tile_pos: Vector2i) -> bool:
    if tile_pos in planted_crops:
        var crop = planted_crops[tile_pos]
        
        # Check if crop is fully grown
        if crop.stage == corn_growth_stages.size() - 1:
            # Remove crop from tilemap and tracking
            plant_tilemap.set_cell(tile_pos, -1)  # Remove plant tile
            planted_crops.erase(tile_pos)
            
            ground_tilemap.set_cell(tile_pos, 0, Vector2i(50, 12))
            
            # Remove from plant_tile_coords so it can be replanted
            var plant_state = get_tree().get_root().get_node("World/Player/StateMachine/Plant")  # Adjust path as needed
            if plant_state and plant_state.has_method("remove_planted_position"):
                plant_state.remove_planted_position(tile_pos)
                print("Removed position ", tile_pos, " from plant_tile_coords")
            else:
                print("Plant state not found")
            
            # Add harvested item to inventory or increment goal
            Goals.goal_tracker.increment_harvest()
            
            print("Harvested ", crop.type, " at ", tile_pos, " - Ground ready for replanting!")
            return true
    
    return false

func get_time_difference(time1: Dictionary, time2: Dictionary) -> float:
    # Simple time difference calculation (you might want to improve this)
    var seconds1 = time1.hour * 3600 + time1.minute * 60 + time1.second
    var seconds2 = time2.hour * 3600 + time2.minute * 60 + time2.second
    return abs(seconds2 - seconds1)

func is_crop_harvestable(tile_pos: Vector2i) -> bool:
    if tile_pos in planted_crops:
        var crop = planted_crops[tile_pos]
        return crop.stage == corn_growth_stages.size() - 1
    return false
