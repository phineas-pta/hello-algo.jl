#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

"""完全背包：动态规划"""
function unbounded_knapsack_dp(wgt::Vector{Int}, val::Vector{Int}, cap::Int)::Int
	n = length(wgt)
	dp = fill(0, (n, cap))  # 初始化 dp 表
	for i ∈ 2:n, c ∈ 2:cap  # 状态转移
		ibis = i - 1
		if wgt[ibis] > c
			dp[i, c] = dp[ibis, c]  # 若超过背包容量，则不选物品 i
		else
			dp[i, c] = max(dp[ibis, c], dp[ibis, c+1 - wgt[ibis]] + val[ibis])  # 不选和选物品 i 这两种方案的较大值
		end
	end
	return dp[n, cap]
end


"""完全背包：空间优化后的动态规划"""
function unbounded_knapsack_dp_comp(wgt::Vector{Int}, val::Vector{Int}, cap::Int)::Int
	n = length(wgt)
	dp = fill(0, cap)  # 初始化 dp 表
	for i ∈ 2:n, c ∈ 2:cap  # 状态转移  # 正序遍历
		ibis = i - 1
		if wgt[ibis] > c
			dp[c] = dp[c]  # 若超过背包容量，则不选物品 i
		else
			dp[c] = max(dp[c], dp[c+1 - wgt[ibis]] + val[ibis])  # 不选和选物品 i 这两种方案的较大值
		end
	end
	return dp[cap]
end


if abspath(PROGRAM_FILE) == @__FILE__
	const wgt = [1, 2, 3]
	const val = [5, 11, 15]
	const cap = 4

	println("不超过背包容量的最大物品价值为 ", unbounded_knapsack_dp(wgt, val, cap))  # 动态规划
	println("不超过背包容量的最大物品价值为 ", unbounded_knapsack_dp_comp(wgt, val, cap))  # 空间优化后的动态规划
end
