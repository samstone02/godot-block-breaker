extends Node

var red: Vector2i = Vector2i(0, 0)
var orange: Vector2i = Vector2i(1, 0)
var yellow: Vector2i = Vector2i(2, 0)
var green: Vector2i = Vector2i(0, 1)
var blue: Vector2i = Vector2i(1, 1)
var purple: Vector2i = Vector2i(2, 1)
var wall: Vector2i = Vector2i(0, 2)

func decrement(coords: Vector2i) -> Vector2i:
	match coords:
		Vector2i(0, 0):
			return Vector2i(-1, -1)
		Vector2i(1, 0):
			return Vector2i(0, 0)
		Vector2i(2, 0):
			return Vector2i(1, 0)
		Vector2i(0, 1):
			return Vector2i(2, 0)
		Vector2i(1, 1):
			return Vector2i(0, 1)
		Vector2i(2, 1):
			return Vector2i(1, 1)
		_:
			print(str(coords) + " is an invalid atlas coordinate to decrement.")
			return Vector2i(-1, -1) 
