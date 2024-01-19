#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

"""物品"""
struct Item
	w::Int  # 物品重量
	v::Int  # 物品价值
end


"""分数背包：贪心"""
function fractional_knapsack(wgt::Vector{Int}, val::Vector{Int}, cap::Int)::Real
	items = [Item(w, v) for (w, v) ∈ zip(wgt, val)]  # 创建物品列表，包含两个属性：重量、价值
	sort!(items; rev=true, by=item -> item.v / item.w)
	res = 0.  # 循环贪心选择
	for item ∈ items
		if item.w ≤ cap
			res += item.v  # 若剩余容量充足，则将当前物品整个装进背包
			cap -= item.w
		else
			res += (item.v / item.w) * cap  # 若剩余容量不足，则将当前物品的一部分装进背包
			break  # 已无剩余容量，因此跳出循环
		end
	end
	return res
end


if abspath(PROGRAM_FILE) == @__FILE__
	const wgt = [10, 20, 30, 40, 50]
	const val = [50, 120, 150, 210, 240]
	const cap = 50
	println("不超过背包容量的最大物品价值为 ", fractional_knapsack(wgt, val, cap))  # 贪心算法
end
