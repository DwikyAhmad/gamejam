extends Control

func _ready():
    # Dapatkan referensi ke node anak menggunakan get_node() atau $
    var start_button = $StartButton
    var exit_button = $ExitButton
    
    # Hubungkan sinyal
    start_button.pressed.connect(_on_start_button_pressed)
    exit_button.pressed.connect(_on_exit_button_pressed)

func _on_start_button_pressed():
    get_tree().change_scene_to_file("res://scenes/world.tscn")

func _on_exit_button_pressed():
    get_tree().quit()
