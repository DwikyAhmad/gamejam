class_name GameInputEvents

static var direction: Vector2

static func movement_input() -> Vector2:
    direction = Vector2.ZERO

    if Input.is_action_pressed("up"):
        direction.y = -1
    if Input.is_action_pressed("right"):
        direction.x = 1
    if Input.is_action_pressed("down"):
        direction.y = 1
    if Input.is_action_pressed("left"):
        direction.x = -1

    return direction
    
static func is_movement_input() -> bool:
    if direction == Vector2.ZERO:
        return false
    else:
        return true

static func tool_input() -> void:
    for i in range(1, 10):
        if Input.is_action_just_pressed("tool_" + str(i)):
            Player.current_tool = Inventory.items[i-1]
            break

static func use_tool() -> bool:
    return Input.is_action_just_pressed("hit")
