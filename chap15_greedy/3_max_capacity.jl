#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

"""最大容量：贪心"""
function max_capacity(ht::Vector{Int})::Int
	i, j = 1, length(ht)  # 初始化 i, j，使其分列数组两端
	res = 0  # 初始最大容量为 0
	while i < j  # 循环贪心选择，直至两板相遇
		cap = min(ht[i], ht[j]) * (j - i)  # 更新最大容量
		res = max(res, cap)
		if ht[i] < ht[j]  # 向内移动短板
			i += 1
		else
			j -= 1
		end
	end
	return res
end


if abspath(PROGRAM_FILE) == @__FILE__
	const ht = [3, 8, 5, 2, 7, 7, 3, 4]
	println("最大容量为 ", max_capacity(ht))  # 贪心算法
end
