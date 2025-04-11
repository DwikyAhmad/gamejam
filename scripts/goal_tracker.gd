extends Node

signal goal_updated(goal_type, current, target)
signal all_goals_completed

var wood_goal = {"current": 0, "target": 3}
var stone_goal = {"current": 0, "target": 3}
var seed_goal = {"current": 0, "target": 3}
var goals_completed = false

func increment_wood():
    wood_goal.current = min(wood_goal.current + 1, wood_goal.target)
    emit_signal("goal_updated", "wood", wood_goal.current, wood_goal.target)
    _check_all_goals_completed()
    
func increment_stone():
    stone_goal.current = min(stone_goal.current + 1, stone_goal.target)
    emit_signal("goal_updated", "stone", stone_goal.current, stone_goal.target)
    _check_all_goals_completed()

func increment_seed():
    seed_goal.current = min(seed_goal.current + 1, seed_goal.target)
    emit_signal("goal_updated", "seed", seed_goal.current, seed_goal.target)
    _check_all_goals_completed()
    
func get_progress(goal_type):
    match goal_type:
        "wood": return wood_goal
        "stone": return stone_goal
        "seed": return seed_goal
        _: return null

func _check_all_goals_completed():
    if not goals_completed and \
       wood_goal.current >= wood_goal.target and \
       stone_goal.current >= stone_goal.target and \
       seed_goal.current >= seed_goal.target:
        print("All goals completed")
        goals_completed = true
        emit_signal("all_goals_completed")

func reset_goals():
    wood_goal.current = 0
    stone_goal.current = 0
    seed_goal.current = 0
    goals_completed = false  # Reset flag
    emit_signal("goal_updated", "wood", wood_goal.current, wood_goal.target)
    emit_signal("goal_updated", "stone", stone_goal.current, stone_goal.target)
    emit_signal("goal_updated", "seed", seed_goal.current, seed_goal.target)
