#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

"""零钱兑换 II：动态规划"""
function coin_change_ii_dp(coins::Vector{Int}, amt::Int)::Int
	n = length(coins)
	dp = fill(0, (n, amt))  # 初始化 dp 表
	for i ∈ 1:n
		dp[i, begin] = 1
	end
	for i ∈ 2:n, a ∈ 2:amt  # 状态转移
		ibis = i - 1
		if coins[ibis] > a
			dp[i, a] = dp[ibis, a]  # 若超过目标金额，则不选硬币 i
		else
			dp[i, a] = dp[ibis, a] + dp[i, a+1 - coins[ibis]]  # 不选和选硬币 i 这两种方案的较小值
		end
	end
	return dp[n, amt]
end


"""零钱兑换 II：空间优化后的动态规划"""
function coin_change_ii_dp_comp(coins::Vector{Int}, amt::Int)::Int
	n = length(coins)
	dp = fill(0, amt)  # 初始化 dp 表
	dp[begin] = 1
	for i ∈ 2:n, a ∈ 2:amt  # 状态转移  # 正序遍历
		ibis = i - 1
		if coins[ibis] > a
			dp[a] = dp[a]  # 若超过目标金额，则不选硬币 i
		else
			dp[a] = dp[a] + dp[a+1 - coins[ibis]]  # 不选和选硬币 i 这两种方案的较小值
		end
	end
	return dp[amt]
end


if abspath(PROGRAM_FILE) == @__FILE__
	const coins = [1, 2, 5]
	const amt = 5
	println("凑出目标金额的硬币组合数量为 ", coin_change_ii_dp(coins, amt))  # 动态规划
	println("凑出目标金额的硬币组合数量为 ", coin_change_ii_dp_comp(coins, amt))  # 空间优化后的动态规划
end
