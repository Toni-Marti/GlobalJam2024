class_name Utils

static func arctan_inetrpolation(x : float, max_val : float, vel : float = 1) -> float:
	return (atan(x*vel)/PI)*max_val
