#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

"""爬楼梯：动态规划"""
function climbing_stairs_dp(n::Int)::Int
	if n ∈ [1, 2]  # 已知 dp[1] 和 dp[2] ，返回之
		return n
	else
		dp = fill(0, n)  # 初始化 dp 表，用于存储子问题的解
		dp[1], dp[2] = 1, 2  # 初始状态：预设最小子问题的解
		for i ∈ 3:n  # 状态转移：从较小子问题逐步求解较大子问题
			dp[i] = dp[i - 1] + dp[i - 2]
		end
		return dp[n]
	end
end


"""爬楼梯：空间优化后的动态规划"""
function climbing_stairs_dp_comp(n::Int)::Int
	if n ∈ [1, 2]  # 已知 dp[1] 和 dp[2] ，返回之
		return n
	else
		a, b = 1, 2
		for _ ∈ 3:n
			a, b = b, a + b
		end
		return b
	end
end


if abspath(PROGRAM_FILE) == @__FILE__
	const n = 9
	println("爬 $n 阶楼梯共有 ", climbing_stairs_dp(n), " 种方案")
	println("爬 $n 阶楼梯共有 ", climbing_stairs_dp_comp(n), " 种方案")
end
