# Tambahkan script ini ke node HUD
extends Control

# Referensi ke label-label goals
@onready var wood_label = $WoodGoal
@onready var stone_label = $StoneGoal
@onready var seed_label = $SeedGoal

func _ready():
    # Hubungkan sinyal dari goal tracker
    Goals.goal_tracker.connect("goal_updated", _on_goal_updated)
    
    # Inisialisasi label
    update_all_goals()

func _on_goal_updated(goal_type, current, target):
    # Update label yang sesuai
    match goal_type:
        "wood": wood_label.text = "Kayu: %d/%d" % [current, target]
        "stone": stone_label.text = "Batu: %d/%d" % [current, target]
        "seed": seed_label.text = "Tanam: %d/%d" % [current, target]

func update_all_goals():
    # Update semua label goals
    var wood_progress = Goals.goal_tracker.get_progress("wood")
    var stone_progress = Goals.goal_tracker.get_progress("stone")
    var seed_progress = Goals.goal_tracker.get_progress("seed")
    
    wood_label.text = "Kayu: %d/%d" % [wood_progress.current, wood_progress.target]
    stone_label.text = "Batu: %d/%d" % [stone_progress.current, stone_progress.target]
    seed_label.text = "Tanam: %d/%d" % [seed_progress.current, seed_progress.target]
