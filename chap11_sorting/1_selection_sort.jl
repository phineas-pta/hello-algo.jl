#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

"""选择排序"""
function selection_sort!(nums::Vector{Int})::Nothing
	n = length(nums)
	for i ∈ 1:(n-1)  # 外循环：未排序区间为 [i, n-1]
		k = i  # 内循环：找到未排序区间内的最小元素
		for j ∈ (i+1):n
			if nums[j] < nums[k]
				k = j  # 记录最小元素的索引
			end
		end
		nums[i], nums[k] = nums[k], nums[i]  # 将该最小元素与未排序区间的首个元素交换
	end
	return nothing
end


if abspath(PROGRAM_FILE) == @__FILE__
	const nums = [4, 1, 3, 1, 5, 2]
	selection_sort!(nums)
	println("选择排序完成后 nums = ", nums)
end
