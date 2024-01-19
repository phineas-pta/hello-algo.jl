#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

"""零钱兑换：贪心"""
function coin_change_greedy(coins::Vector{Int}, amt::Int)::Int
	i = length(coins)  # 假设 coins 列表有序
	count = 0
	while amt > 0  # 循环进行贪心选择，直到无剩余金额
		while i > 1 && coins[i] > amt  # 找到小于且最接近剩余金额的硬币
			i -= 1
		end
		amt -= coins[i]  # 选择 coins[i]
		count += 1
	end
	return amt == 0 ? count : -1  # 若未找到可行方案，则返回 -1
end


if abspath(PROGRAM_FILE) == @__FILE__
	# 贪心：能够保证找到全局最优解
	coins = [1, 5, 10, 20, 50, 100]
	amt = 186
	println("\ncoins = ", coins, ", amt = ", amt)
	println("凑到 ", amt, " 所需的最少硬币数量为 ", coin_change_greedy(coins, amt))

	# 贪心：无法保证找到全局最优解
	coins = [1, 20, 50]
	amt = 60
	println("\ncoins = ", coins, ", amt = ", amt)
	println("凑到 ", amt, " 所需的最少硬币数量为 ", coin_change_greedy(coins, amt))
	println("实际上需要的最少数量为 3 ，即 20 + 20 + 20")

	# 贪心：无法保证找到全局最优解
	coins = [1, 49, 50]
	amt = 98
	println("\ncoins = ", coins, ", amt = ", amt)
	println("凑到 ", amt, " 所需的最少硬币数量为 ", coin_change_greedy(coins, amt))
	println("实际上需要的最少数量为 2 ，即 49 + 49")
end
