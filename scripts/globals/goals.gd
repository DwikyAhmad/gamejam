extends Node

var goal_tracker = preload("res://scripts/goal_tracker.gd").new()

func _ready():
    add_child(goal_tracker)
