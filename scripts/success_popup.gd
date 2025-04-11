extends Control

signal continue_game
signal return_to_menu

func _ready():
    # Sembunyikan saat awal
    process_mode = PROCESS_MODE_ALWAYS

    visible = false
    
    # Hubungkan sinyal dari tombol
    $ContinueButton.pressed.connect(_on_continue_pressed)
    $MainMenuButton.pressed.connect(_on_main_menu_pressed)
    
    # Hubungkan sinyal dari goals
    Goals.goal_tracker.connect("all_goals_completed", _on_all_goals_completed)

func _on_all_goals_completed():
    # Tampilkan popup
    visible = true
    
    # Pause game
    get_tree().paused = true

func _on_continue_pressed():
    # Sembunyikan popup
    visible = false
    
    # Resume game
    get_tree().paused = false
    
    # Emit sinyal
    emit_signal("continue_game")

func _on_main_menu_pressed():
    # Resume game (untuk menghindari masalah saat kembali ke game)
    get_tree().paused = false
    
    # Emit sinyal
    emit_signal("return_to_menu")

    # Reset goals
    Goals.goal_tracker.reset_goals()

    # Reset player tool
    Player.current_tool = DataTypes.Tools.Axe
    
    # Kembali ke main menu
    get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
