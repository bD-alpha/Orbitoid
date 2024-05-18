extends Label3D
class_name DebugLabel

@export var base : Node
@export_multiline var expression : String
@export var reparse : bool

var _expression : Expression

func _ready():
	_expression = Expression.new()
	_expression.parse(expression)

func _process(delta):
	if reparse: _expression.parse(expression)
	text = str(_expression.execute([], base))
