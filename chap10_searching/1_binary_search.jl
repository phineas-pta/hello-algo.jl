#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

"""二分查找（双闭区间）"""
function binary_search(nums::Vector{Int}, target::Int)::Int
	i, j = 1, length(nums)  # 初始化双闭区间 [1, n] ，即 i, j 分别指向数组首元素、尾元素
	while i ≤ j  # 循环，当搜索区间为空时跳出（当 i > j 时为空）
		m = (i + j) ÷ 2  # 计算中点索引 m
		if nums[m] < target
			i = m + 1  # 此情况说明 target 在区间 [m+1, j] 中
		elseif nums[m] > target
			j = m - 1  # 此情况说明 target 在区间 [i, m-1] 中
		else
			return m  # 找到目标元素，返回其索引
		end
	end
	return 0  # 未找到目标元素，返回 0
end


"""二分查找（左闭右开区间）"""
function binary_search_lcro(nums::Vector{Int}, target::Int)::Int
	i, j = 1, length(nums)+1  # 初始化左闭右开区间 [1, n+1) ，即 i, j 分别指向数组首元素、尾元素+1
	while i < j  # 循环，当搜索区间为空时跳出（当 i = j 时为空）
		m = (i + j) ÷ 2  # 计算中点索引 m
		if nums[m] < target
			i = m + 1  # 此情况说明 target 在区间 [m+1, j) 中
		elseif nums[m] > target
			j = m  # 此情况说明 target 在区间 [i, m) 中
		else
			return m  # 找到目标元素，返回其索引
		end
	end
	return 0  # 未找到目标元素，返回 0
end


if abspath(PROGRAM_FILE) == @__FILE__
	const nums = [1, 3, 6, 8, 12, 15, 23, 26, 31, 35]
	const target = 6
	println("目标元素 6 的索引 = ", binary_search(nums, target))  # 二分查找（双闭区间）
	println("目标元素 6 的索引 = ", binary_search_lcro(nums, target))  # 二分查找（左闭右开区间）
end
