#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

"""搜索"""
function _dfs(i::Int)::Int
	if i ∈ [1, 2]  # 已知 dp[1] 和 dp[2] ，返回之
		return i
	else
		return _dfs(i - 1) + _dfs(i - 2)  # dp[i] = dp[i-1] + dp[i-2]
	end
end


"""爬楼梯：搜索"""
function climbing_stairs_dfs(n::Int)::Int
	return _dfs(n)
end


if abspath(PROGRAM_FILE) == @__FILE__
	const n = 9
	println("爬 $n 阶楼梯共有 ", climbing_stairs_dfs(n), " 种方案")
end
