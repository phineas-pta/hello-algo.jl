#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

"""零钱兑换：动态规划"""
function coin_change_dp(coins::Vector{Int}, amt::Int)::Int
	n = length(coins)
	MAX = amt + 1
	dp = fill(0, (n, amt))  # 初始化 dp 表
	for a ∈ 2:amt
		dp[begin, a] = MAX
	end
	for i ∈ 2:n, a ∈ 2:amt
		ibis = i - 1
		if coins[ibis] > a
			dp[i, a] = dp[ibis, a]  # 若超过目标金额，则不选硬币 i
		else
			dp[i, a] = min(dp[ibis, a], dp[i, a+1 - coins[ibis]] + 1)  # 不选和选硬币 i 这两种方案的较小值
		end
	end
	tmp = dp[n, amt]
	return tmp ≠ MAX ? tmp : -1
end


"""零钱兑换：空间优化后的动态规划"""
function coin_change_dp_comp(coins::Vector{Int}, amt::Int)::Int
	n = length(coins)
	MAX = amt + 1
	dp = fill(MAX, amt)  # 初始化 dp 表
	dp[begin] = 0
	for i ∈ 2:n, a ∈ 2:amt  # 状态转移  # 正序遍历
		ibis = i - 1
		if coins[ibis] > a
			dp[a] = dp[a]  # 若超过目标金额，则不选硬币 i
		else
			dp[a] = min(dp[a], dp[a+1 - coins[ibis]] + 1)  # 不选和选硬币 i 这两种方案的较小值
		end
	end
	tmp = dp[amt]
	return tmp ≠ MAX ? tmp : -1
end


if abspath(PROGRAM_FILE) == @__FILE__
	const coins = [1, 2, 5]
	const amt = 4
	println("凑到目标金额所需的最少硬币数量为 ", coin_change_dp(coins, amt))  # 动态规划
	println("凑到目标金额所需的最少硬币数量为 ", coin_change_dp_comp(coins, amt))  # 空间优化后的动态规划
end
