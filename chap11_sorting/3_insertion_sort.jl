#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

"""插入排序"""
function insertion_sort!(nums::Vector{Int})::Nothing
	for i ∈ eachindex(nums)  # 外循环：已排序区间为 [1, i-1]
		base = nums[i]
		j = i - 1
		while j > 0 && nums[j] > base  # 内循环：将 base 插入到已排序区间 [0, i-1] 中的正确位置
			nums[j + 1] = nums[j]  # 将 nums[j] 向右移动一位
			j -= 1
		end
		nums[j + 1] = base  # 将 base 赋值到正确位置
	end
	return nothing
end


if abspath(PROGRAM_FILE) == @__FILE__
	const nums = [4, 1, 3, 1, 5, 2]
	insertion_sort!(nums)
	println("插入排序完成后 nums = ", nums)
end
