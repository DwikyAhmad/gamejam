class_name Player
extends CharacterBody2D

static var current_tool: DataTypes.Tools = DataTypes.Tools.Interact

var player_direction: Vector2

func _ready():
    # Tambahkan player ke group
    add_to_group("player")

# func _process(_delta):
#     # Tambahkan di fungsi yang sudah ada
    
#     # Tekan F5 untuk Save
#     if Input.is_action_just_pressed("ui_save"):
#         SaveSystem.save_game()
#         print("Game disimpan!")
        
#     # Tekan F6 untuk Load
#     if Input.is_action_just_pressed("ui_load"):
#         SaveSystem.load_game()
#         print("Game dimuat!")
