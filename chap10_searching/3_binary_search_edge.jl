#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

include("2_binary_search_insertion.jl")


"""二分查找最左一个 target"""
function binary_search_left_edge(nums::Vector{Int}, target::Int)::Int
	i = binary_search_insertion(nums, target)  # 等价于查找 target 的插入点
	if i > length(nums) || nums[i] ≠ target
		return 0  # 未找到 target ，返回 0
	else
		return i  # 找到 target ，返回索引 i
	end
end


"""二分查找最右一个 target"""
function binary_search_right_edge(nums::Vector{Int}, target::Int)::Int
	i = binary_search_insertion(nums, target + 1)  # 转化为查找最左一个 target + 1
	j = i - 1  # j 指向最右一个 target ，i 指向首个大于 target 的元素
	if j == 0 || nums[i] ≠ target
		return 0  # 未找到 target ，返回 0
	else
		return j  # 找到 target ，返回索引 j
	end
end


if abspath(PROGRAM_FILE) == @__FILE__
	const nums = [1, 3, 6, 6, 6, 6, 6, 10, 12, 15]  # 包含重复元素的数组
	println("\n数组 nums = ", nums)
	for target ∈ [6, 7]  # 二分查找左边界和右边界
		index = binary_search_left_edge(nums, target)
		print("最左一个元素 $target 的索引为 $index")
		index = binary_search_right_edge(nums, target)
		print("最右一个元素 $target 的索引为 $index")
	end
end
