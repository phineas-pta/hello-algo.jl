#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

"""二分查找：问题 f(i, j)"""
function _dfs(nums::Vector{Int}, target::Int, i::Int, j::Int)::Int
	if i > j return 0 end  # 若区间为空，代表无目标元素，则返回 0
	m = (i + j) ÷ 2  # 计算中点索引 m
	if nums[m] < target
		return _dfs(nums, target, m + 1, j)  # 递归子问题 f(m+1, j)
	elseif nums[m] > target
		return _dfs(nums, target, i, m - 1)  # 递归子问题 f(i, m-1)
	else
		return m  # 找到目标元素，返回其索引
	end
end


"""二分查找"""
function binary_search(nums::Vector{Int}, target::Int)::Int
	return _dfs(nums, target, 1, length(nums))  # 求解问题 f(1, n)
end


if abspath(PROGRAM_FILE) == @__FILE__
	const nums = [1, 3, 6, 8, 12, 15, 23, 26, 31, 35]
	const target = 6
	println("目标元素 6 的索引 = ", binary_search(nums, target))  # 二分查找（双闭区间）
end
