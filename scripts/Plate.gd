class_name Plate
extends CharacterBody2D

@export var weight_value: int = 1
@onready var weight: Weight = $Weight

func _ready():
	weight.weight = weight_value
