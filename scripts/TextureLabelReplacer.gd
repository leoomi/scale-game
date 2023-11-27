extends RichTextLabel

@export var input_prompt_texture_path: String

# Called when the node enters the scene tree for the first time.
func _ready():
	var regex = RegEx.new()
	regex.compile("\\%([a-z]*|[A-Z]*|[0-9]*)\\%") # this should be static but meh
	var result = regex.sub(text, "[img]%s$1.png[/img]" % input_prompt_texture_path, true)
	text = result

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
