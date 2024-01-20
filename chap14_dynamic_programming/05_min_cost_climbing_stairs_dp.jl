#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

"""爬楼梯最小代价：动态规划"""
function min_cost_climbing_stairs_dp(cost::Vector{Int})::Int
	n = length(cost) - 1
	if n ∈ [1, 2]
		return n
	else
		dp = fill(0, n)  # 初始化 dp 表，用于存储子问题的解
		dp[1], dp[2] = cost[1], cost[2]  # 初始状态：预设最小子问题的解
		for i ∈ 3:n  # 状态转移：从较小子问题逐步求解较大子问题
			dp[i] = min(dp[i - 1], dp[i - 2]) + cost[i]
		end
		return dp[n]
	end
end


"""爬楼梯最小代价：空间优化后的动态规划"""
function min_cost_climbing_stairs_dp_comp(cost::Vector{Int})::Int
	n = length(cost) - 1
	if n ∈ [1, 2]
		return n
	else
		a, b = cost[1], cost[2]
		for i ∈ 3:n
			a, b = b, min(a, b) + cost[i]
		end
		return b
	end
end


if abspath(PROGRAM_FILE) == @__FILE__
	const cost = [0, 1, 10, 1, 1, 1, 10, 1, 1, 10, 1]
	println("输入楼梯的代价列表为 ", cost)
	println("爬完楼梯的最低代价为 ", min_cost_climbing_stairs_dp(cost))
	println("爬完楼梯的最低代价为 ", min_cost_climbing_stairs_dp_comp(cost))
end
