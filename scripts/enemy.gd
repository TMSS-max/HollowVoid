extends 'Node'

var patrol_points = []
var speed = 200
var detection_range = 300
var attack_range = 50
var attack_damage = 10
var current_target = null

func _ready():
    set_process(true)

func _process(delta):
    if current_target:
        chase_target(delta)
    else:
        patrol(delta)

func patrol(delta):
    # Patrolling behavior
    for point in patrol_points:
        var distance = position.distance_to(point)
        if distance < 10:
            # Move to the next patrol point
            move_to_next_patrol_point()
            break
        else:
            move_towards(point, delta)

func move_towards(target, delta):
    var direction = (target - position).normalized()
    position += direction * speed * delta

func move_to_next_patrol_point():
    # Logic to move to the next patrol point
    # Assuming patrol_points is a circular list
    pass

func chase_target(delta):
    var direction = (current_target.position - position).normalized()
    position += direction * speed * delta

    if position.distance_to(current_target.position) <= attack_range:
        attack()

func attack():
    if current_target:
        current_target.take_damage(attack_damage)

func detect_targets():
    # Logic to detect targets within detection_range
    pass

func notify_target(target):
    current_target = target
    # Possibly initiate chase or attack
