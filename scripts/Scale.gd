class_name Scale
extends Node2D

@onready var left_plate: Plate = $LeftPlate/Plate
@onready var right_plate: Plate = $RightPlate/Plate

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.@onready var left_plate = $LeftPlate


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_difference() -> float:
	return right_plate.weight.get_total_weight() - left_plate.weight.get_total_weight()
