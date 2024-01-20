#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

"""回溯"""
function _backtrack!(choices::Vector{Int}, state::Int, n::Int, res::Vector{Int})::Nothing
	if state == n  # 当爬到第 n 阶时，方案数量加 1
		res[begin] += 1
	end
	for choice ∈ choices  # 遍历所有选择
		tmp = state + choice  # 剪枝：不允许越过第 n 阶
		if tmp ≤ n
			_backtrack!(choices, tmp, n, res)  # 尝试：做出选择，更新状态
		end  # 回退
	end
	return nothing
end


"""爬楼梯：回溯"""
function climbing_stairs_backtrack(n::Int)::Int
	choices = [1, 2]  # 可选择向上爬 1 阶或 2 阶
	state = 0  # 从第 0 阶开始爬
	res = [0]  # 使用 res[0] 记录方案数量
	_backtrack!(choices, state, n, res)
	return res[begin]
end


if abspath(PROGRAM_FILE) == @__FILE__
	const n = 9
	println("爬 $n 阶楼梯共有 ", climbing_stairs_backtrack(n), " 种方案")
end
