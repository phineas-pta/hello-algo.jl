#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

"""冒泡排序"""
function bubble_sort!(nums::Vector{Int})::Nothing
	n = length(nums)
	for i ∈ (n-1):-1:1, j ∈ 1:i
		# 外循环：未排序区间为 [1, i]
		# 内循环：将未排序区间 [1, i] 中的最大元素交换至该区间的最右端
		if nums[j] > nums[j + 1]  # 交换 nums[j] 与 nums[j + 1]
			nums[j], nums[j + 1] = nums[j + 1], nums[j]
		end
	end
	return nothing
end


"""冒泡排序（标志优化）"""
function bubble_sort_with_flag!(nums::Vector{Int})::Nothing
	n = length(nums)
	for i ∈ (n-1):-1:1  # 外循环：未排序区间为 [1, i]
		flag = false  # 初始化标志位
		for j ∈ 1:i  # 内循环：将未排序区间 [1, i] 中的最大元素交换至该区间的最右端
			if nums[j] > nums[j + 1]  # 交换 nums[j] 与 nums[j + 1]
				nums[j], nums[j + 1] = nums[j + 1], nums[j]
				flag = true  # 记录交换元素
			end
		end
		if !flag break end  # 此轮“冒泡”未交换任何元素，直接跳出
	end
	return nothing
end


if abspath(PROGRAM_FILE) == @__FILE__
	const nums0 = [4, 1, 3, 1, 5, 2]
	bubble_sort!(nums0)
	println("冒泡排序完成后 nums = ", nums0)

	const nums1 = [4, 1, 3, 1, 5, 2]
	bubble_sort_with_flag!(nums1)
	println("冒泡排序完成后 nums =", nums1)
end
