extends StaticItem

const BLOCK_PUZZLE = preload('res://scenes/subviews/block_puzzle.tscn')

func interact():
	owner.add_child(BLOCK_PUZZLE.instantiate())
