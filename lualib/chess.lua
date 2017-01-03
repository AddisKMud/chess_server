local M = {}

-- 每种子力的类型编号
M.TYPE ={
	KING = 1,	-- 帅
	ADVISOR = 2,-- 士
	BISHOP = 3,	-- 象
	KNIGHT = 4,	-- 马
	ROOK = 5,	-- 车
	CANNON = 6,	-- 炮
	PAWN = 7	-- 兵
}

-- 移动检查表
local oblique_move_table = {
	[2] = {
		{-1, -1},
		{-1,  1},
		{ 1, -1},
		{ 1,  1}
	},
	[3] = {
		{-2, -2, -1, -1},
		{-2,  2, -1,  1},
		{ 2, -2, },
		{ 2,  2}
	 },
	[4] = {
		{-2, -1, -1,  0},
		{-2,  1, -1,  0},
		{-1, -2,  0, -1},
		{-1,  2,  0, -1},
		{ 1, -2,  0, -1},
		{ 1,  2,  0,  1},
		{ 2, -1,  1,  1},
		{ 2,  1,  1,  0}
	}
}

local function get_type(n)
	if n > 10 then
		return n - 10
	end

	return n
end

local function oblique_move_check(board, move_table, src_row, src_col, dest_row, dest_col)	
	local d_row = dest_row - src_row
	local d_col = dest_col - src_col

	for _,v in ipairs(move_table) do
		if v[1] == d_row and v[2] == d_col then
			-- 没有别腿判断
			if not v[3] then
				return true
			end
			-- 别腿的地方没有子
			if board[ (src_row + v[3] - 1)*10 + (src_col + v[4]) ] == 0 then
				return true
			end
		end
	end

	return false
end

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

	-- 红方棋子值加10
	for i=46,90 do
		if data.board[i] > 0 then
			data.board[i] = data.board[i] + 10
		end
	end

	return data
end

local function get_cm(board, row, col)
	if row < 1 or row > 10 then
		return nil
	end

	if col < 1 or col > 9 then
		return nil
	end

	local index = (row - 1) * 10 + col

	return board[index]
end

local function get_color(cm)
	if cm == 0 then
		return 0
	end

	if cm > 10 then
		return 1
	end

	return -1
end

function M.can_move(data, is_red, src_row, src_col, dest_row, dest_col)
	-- 不是自己的回合
	if data.red_turn ~= is_red then
		return false
	end

	-- 源是否在棋盘内
	local src_cm = get_cm(data.board, src_row, src_col)
	if src_cm == nil or src_cm == 0 then
		return false
	end

	-- 目标是否在棋盘内, 目标有已方子
	local dest_cm = get_cm(data.board, dest_row, dest_col)
	if dest_cm == nil or get_color(src_cm) == get_color(dest_cm) then
		return false
	end

	local true_type = get_type(src_cm)
	if true_type == then

	end
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

mt = {
	[1] = {
		{-1, -1},
		{-1,  1},
		{ 1, -1},
		{ 1,  1}
	},
	[2] = {
		{-2, -2},
		{-2,  2},
		{ 2, -2},
		{ 2,  2}
	 },
	[3] = {
		{-2, -1, -1,  0},
		{-2,  1, -1,  0},
		{-1, -2,  0, -1},
		{-1,  2,  0, -1},
		{ 1, -2,  0, -1},
		{ 1,  2,  0,  1},
		{ 2, -1,  1,  1},
		{ 2,  1,  1,  0}
	}
}
return M
