extends TextureRect

var base_position = 228

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    for i in range(1, 10):
        if Input.is_action_just_pressed("tool_" + str(i)):
            position.x = base_position + ((i-1) * 22)
    pass
