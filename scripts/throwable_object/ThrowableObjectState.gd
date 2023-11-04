class_name ThrowableObjectState
extends State

var t_object: ThrowableObject

func _ready():
	await owner.ready
	t_object = owner as ThrowableObject
	assert(t_object != null)
