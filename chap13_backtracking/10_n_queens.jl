#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

"""回溯算法：n 皇后"""
function _backtrack!(
	row::Int, n::Int, state::Matrix{Char}, res::Vector{Matrix{Char}},
	cols::Vector{Bool}, diags1::Vector{Bool}, diags2::Vector{Bool},
)::Nothing
	if row == n  # 当放置完所有行时，记录解
		push!(res, copy(state))
	else
		for col ∈ 1:n  # 遍历所有列
			diag1 = row - col + n  # 计算该格子对应的主对角线和次对角线
			diag2 = row + col
			if !cols[col] && !diags1[diag1] && !diags2[diag2]  # 剪枝：不允许该格子所在列、主对角线、次对角线上存在皇后
				state[row, col] = 'Q'  # 尝试：将皇后放置在该格子
				cols[col] = diags1[diag1] = diags2[diag2] = true
				_backtrack!(row + 1, n, state, res, cols, diags1, diags2)  # 放置下一行
				state[row, col] = '#'  # 回退：将该格子恢复为空位
				cols[col] = diags1[diag1] = diags2[diag2] = false
			end
		end
	end
	return nothing
end


"""求解 n 皇后"""
function n_queens(n::Int)::Vector{Matrix{Char}}
	state = fill('#', (n, n))  # 初始化 n*n 大小的棋盘，其中 'Q' 代表皇后，'#' 代表空位
	cols = fill(false, n)  # 记录列是否有皇后
	diags1 = fill(false, 2n - 1)  # 记录主对角线上是否有皇后
	diags2 = copy(diags1)         # 记录次对角线上是否有皇后
	res = Vector{Matrix{Char}}()
	_backtrack!(1, n, state, res, cols, diags1, diags2)
	return res
end


if abspath(PROGRAM_FILE) == @__FILE__
	const n = 4
	const res = n_queens(n)
	println("输入棋盘长宽为 $n")
	println("皇后放置方案共有 $(length(res)) 种")
	for state ∈ res
		println('-'^21)
		display(state)  # pretty print a matrix
	end
end
