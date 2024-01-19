#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

"""二分查找插入点（无重复元素）"""
function binary_search_insertion_simple(nums::Vector{Int}, target::Int)::Int
	i, j = 1, length(nums)  # 初始化双闭区间 [1, n]
	while i ≤ j
		m = (i + j) ÷ 2  # 计算中点索引 m
		if nums[m] < target
			i = m + 1  # target 在区间 [m+1, j] 中
		elseif nums[m] > target
			j = m - 1  # target 在区间 [i, m-1] 中
		else
			return m  # 找到 target ，返回插入点 m
		end
	end
	return i  # 未找到 target ，返回插入点 i
end


"""二分查找插入点（存在重复元素）"""
function binary_search_insertion(nums::Vector{Int}, target::Int)::Int
	i, j = 1, length(nums)  # 初始化双闭区间 [1, n]
	while i ≤ j
		m = (i + j) ÷ 2  # 计算中点索引 m
		if nums[m] < target
			i = m + 1  # target 在区间 [m+1, j] 中
		else
			j = m - 1  # target 在区间 [i, m-1] 中
		end  # 首个小于 target 的元素在区间 [i, m-1] 中
	end
	return i  # 返回插入点 i
end


if abspath(PROGRAM_FILE) == @__FILE__
	const nums1 = [1, 3, 6, 8, 12, 15, 23, 26, 31, 35]  # 无重复元素的数组
	println("\n数组 nums = ", nums1)
	for target ∈ [6, 9]  # 二分查找插入点
		println("元素 $target 的插入点的索引为 ", binary_search_insertion_simple(nums1, target))
	end

	const nums2 = [1, 3, 6, 6, 6, 6, 6, 10, 12, 15]  # 包含重复元素的数组
	println("\n数组 nums = ", nums2)
	for target ∈ [2, 6, 20]  # 二分查找插入点
		println("元素 $target 的插入点的索引为 ", binary_search_insertion(nums2, target))
	end
end
