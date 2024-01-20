#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

"""0-1 背包：暴力搜索"""
function knapsack_dfs(wgt::Vector{Int}, val::Vector{Int}, i::Int, c::Int)::Int
	ibis = i - 1
	if i == 1 || c == 0  # 若已选完所有物品或背包无剩余容量，则返回价值 0
		return 0
	elseif wgt[ibis] > c  # 若超过背包容量，则只能选择不放入背包
		return knapsack_dfs(wgt, val, ibis, c)
	else
		no = knapsack_dfs(wgt, val, ibis, c)  # 计算不放入和放入物品 i 的最大价值
		yes = knapsack_dfs(wgt, val, ibis, c - wgt[ibis]) + val[ibis]
		return max(no, yes)  # 返回两种方案中价值更大的那一个
	end
end


"""0-1 背包：记忆化搜索"""
function knapsack_dfs_mem(wgt::Vector{Int}, val::Vector{Int}, mem::Matrix{Int}, i::Int, c::Int)::Int
	ibis = i - 1
	if i == 1 || c == 0  # 若已选完所有物品或背包无剩余容量，则返回价值 0
		return 0
	elseif mem[i, c] ≠ -1  # 若已有记录，则直接返回
		return mem[i, c]
	elseif wgt[ibis] > c  # 若超过背包容量，则只能选择不放入背包
		return knapsack_dfs_mem(wgt, val, mem, ibis, c)
	else
		no = knapsack_dfs_mem(wgt, val, mem, ibis, c)  # 计算不放入和放入物品 i 的最大价值
		yes = knapsack_dfs_mem(wgt, val, mem, ibis, c - wgt[ibis]) + val[ibis]
		mem[i, c] = max(no, yes)  # 记录并返回两种方案中价值更大的那一个
		return mem[i, c]
	end
end


"""0-1 背包：动态规划"""
function knapsack_dp(wgt::Vector{Int}, val::Vector{Int}, cap::Int)::Int
	n = length(wgt)
	dp = fill(0, (n, cap))  # 初始化 dp 表
	for i ∈ 2:n, c ∈ 2:cap
		ibis = i - 1
		if wgt[ibis] > c
			dp[i, c] = dp[ibis, c]  # 若超过背包容量，则不选物品 i
		else
			dp[i, c] = max(dp[ibis, c], dp[ibis, c+1 - wgt[ibis]] + val[ibis])  # 不选和选物品 i 这两种方案的较大值
		end
	end
	return dp[n, cap]
end


"""0-1 背包：空间优化后的动态规划"""
function knapsack_dp_comp(wgt::Vector{Int}, val::Vector{Int}, cap::Int)::Int
	n = length(wgt)
	dp = fill(0, cap)  # 初始化 dp 表
	for i ∈ 2:n, c ∈ cap:-1:2  # 状态转移  # 倒序遍历
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
	const wgt = [10, 20, 30, 40, 50]
	const val = [50, 120, 150, 210, 240]
	const cap = 50
	const n = length(wgt)

	println("不超过背包容量的最大物品价值为 ", knapsack_dfs(wgt, val, n, cap))  # 暴力搜索
	println("不超过背包容量的最大物品价值为 ", knapsack_dfs_mem(wgt, val, fill(-1, (n, cap)), n, cap))  # 记忆化搜索
	println("不超过背包容量的最大物品价值为 ", knapsack_dp(wgt, val, cap))  # 动态规划
	println("不超过背包容量的最大物品价值为 ", knapsack_dp_comp(wgt, val, cap))  # 空间优化后的动态规划
end
