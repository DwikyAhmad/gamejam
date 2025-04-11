extends Node

signal goal_updated(goal_type, current, target)

var wood_goal = {"current": 0, "target": 5}
var stone_goal = {"current": 0, "target": 5}
var seed_goal = {"current": 0, "target": 5}

func increment_wood():
    wood_goal.current = min(wood_goal.current + 1, wood_goal.target)
    emit_signal("goal_updated", "wood", wood_goal.current, wood_goal.target)
    
func increment_stone():
    stone_goal.current = min(stone_goal.current + 1, stone_goal.target)
    emit_signal("goal_updated", "stone", stone_goal.current, stone_goal.target)
    
func increment_seed():
    seed_goal.current = min(seed_goal.current + 1, seed_goal.target)
    emit_signal("goal_updated", "seed", seed_goal.current, seed_goal.target)
    
func get_progress(goal_type):
    match goal_type:
        "wood": return wood_goal
        "stone": return stone_goal
        "seed": return seed_goal
        _: return null