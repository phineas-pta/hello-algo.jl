#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

"""带约束爬楼梯：动态规划"""
function climbing_stairs_constraint_dp(n::Int)::Int
	if n ∈ [1, 2]
		return 1
	else
		dp = fill(0, (n, 2))  # 初始化 dp 表，用于存储子问题的解
		dp[1, 1], dp[1, 2] = 1, 0 # 初始状态：预设最小子问题的解
		dp[2, 1], dp[2, 2] = 0, 1
		for i ∈ 3:n  # 状态转移：从较小子问题逐步求解较大子问题
			dp[i, 1] = dp[i-1, 2]
			dp[i, 2] = dp[i-2, 1] + dp[i-2, 2]
		end
		return dp[n, 1] + dp[n, 2]
	end
end


if abspath(PROGRAM_FILE) == @__FILE__
	const n = 9
	println("爬 $n 阶楼梯共有 ", climbing_stairs_constraint_dp(n), " 种方案")
end
