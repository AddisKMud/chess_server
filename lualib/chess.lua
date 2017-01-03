local M = {}

-- 每种子力的类型编号
M.TYPE ={
	KING = 1,	-- 帅、将
	ADVISOR = 2,-- 士
	BISHOP = 3,	-- 象
	KNIGHT = 4,	-- 马
	ROOK = 5,	-- 车
	CANNON = 6,	-- 炮
	PAWN = 7	-- 兵、卒
}

function M.new()
	local data = {
		red_turn = true,
		finish = false
	}

	-- 10行9列的棋盘
	data.board = {
		{5, 4, 3, 2, 1, 2, 3, 4, 5},
		{0, 0, 0, 0, 0, 0, 0, 0, 0},
		{0, 6, 0, 0, 0, 0, 0, 6, 0},
		{7, 0, 7, 0, 7, 0, 7, 0, 7},
		{0, 0, 0, 0, 0, 0, 0, 0, 0},
		{0, 0, 0, 0, 0, 0, 0, 0, 0},
		{7, 0, 7, 0, 7, 0, 7, 0, 7},
		{0, 6, 0, 0, 0, 0, 0, 6, 0},
		{0, 0, 0, 0, 0, 0, 0, 0, 0},
		{5, 4, 3, 2, 1, 2, 3, 4, 5},
	}

	return data
end

function M.get_index(row, col)
	return (row - 1) * 10 + col
end

function M.can_move()
end

function M.move(data, src_row, src_col, dest_row, dest_col)
	local src = M.get_index(src_row, src_col)
	local dest = M.get_index(dest_row, dest_col)

	if data.board[dest] == M.TYPE.KING then
		data.finish = true
		return true
	end

	data.board[dest] = data.board[src]
	data.board[src] = 0

	data.red_turn = not data.red_true

	return false
end

return M
