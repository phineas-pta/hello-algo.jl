#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

"""合并左子数组和右子数组"""
function _merge!(nums::Vector{Int}, left::Int, mid::Int, right::Int)::Nothing
	# 左子数组区间为 [left, mid], 右子数组区间为 [mid+1, right]
	tmp = fill(0, right - left + 1)  # 创建一个临时数组 tmp ，用于存放合并后的结果
	i, j, k = left, mid + 1, 1  # 初始化左子数组和右子数组的起始索引
	while i ≤ mid && j ≤ right  # 当左右子数组都还有元素时，进行比较并将较小的元素复制到临时数组中
		if nums[i] ≤ nums[j]
			tmp[k] = nums[i]
			i += 1
		else
			tmp[k] = nums[j]
			j += 1
		end
		k += 1
	end
	while i ≤ mid  # 将左子数组和右子数组的剩余元素复制到临时数组中
		tmp[k] = nums[i]
		i += 1
		k += 1
	end
	while j ≤ right
		tmp[k] = nums[j]
		j += 1
		k += 1
	end
	for l ∈ eachindex(tmp)  # 将临时数组 tmp 中的元素复制回原数组 nums 的对应区间
		nums[left + l - 1] = tmp[l]
	end
	return nothing
end


"""归并排序"""
function merge_sort!(nums::Vector{Int}, left::Int=1, right::Int=length(nums))::Nothing
	if left < right  # 划分阶段
		mid = (left + right) ÷ 2  # 计算中点
		merge_sort!(nums, left, mid)  # 递归左子数组
		merge_sort!(nums, mid + 1, right)  # 递归右子数组
		_merge!(nums, left, mid, right)  # 合并阶段
	end
	return nothing  # 当子数组长度为 1 时终止递归
end


if abspath(PROGRAM_FILE) == @__FILE__
	const nums = [7, 3, 2, 6, 0, 1, 5, 4]
	merge_sort!(nums)
	println("归并排序完成后 nums = ", nums)
end
