#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

"""记忆化搜索"""
function _dfs!(i::Int, mem::Vector{Int})::Int
	if i ∈ [1, 2]  # 已知 dp[1] 和 dp[2] ，返回之
		return i
	else
		if mem[i] == -1  # 若存在记录 dp[i] ，则直接返回之
			mem[i] = _dfs!(i - 1, mem) + _dfs!(i - 2, mem)  # 记录 dp[i]
		end
		return mem[i]
	end
end


"""爬楼梯：记忆化搜索"""
function climbing_stairs_dfs_mem(n::Int)::Int
	mem = fill(-1, n + 1)  # mem[i] 记录爬到第 i 阶的方案总数，-1 代表无记录
	return _dfs!(n, mem)
end


if abspath(PROGRAM_FILE) == @__FILE__
	const n = 9
	println("爬 $n 阶楼梯共有 ", climbing_stairs_dfs_mem(n), " 种方案")
end
