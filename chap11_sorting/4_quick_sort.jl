#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

"""哨兵划分"""
function _partition!(nums::Vector{Int}, left::Int, right::Int)::Int
	i, j = left, right  # 以 nums[left] 为基准数
	while i < j
		while i < j && nums[j] ≥ nums[left]
			j -= 1  # 从右向左找首个小于基准数的元素
		end
		while i < j && nums[i] ≤ nums[left]
			i += 1  # 从左向右找首个大于基准数的元素
		end
		nums[i], nums[j] = nums[j], nums[i]  # 元素交换
	end
	nums[i], nums[left] = nums[left], nums[i]  # 将基准数交换至两子数组的分界线
	return i  # 返回基准数的索引
end


"""选取三个候选元素的中位数"""
function _median_3(nums::Vector{Int}, left::Int, mid::Int, right::Int)::Int
	a = Int(nums[left] < nums[mid])
	b = Int(nums[left] < nums[right])
	c = Int(nums[mid]  < nums[left])
	d = Int(nums[mid]  < nums[right])
	# 此处使用异或运算来简化代码
	# 异或规则为 0 ^ 0 = 1 ^ 1 = 0, 0 ^ 1 = 1 ^ 0 = 1
	if Bool(a^b)
		return left
	elseif Bool(c^d)
		return mid
	else
		return right
	end
end


"""哨兵划分（三数取中值）"""
function _partition_3!(nums::Vector{Int}, left::Int, right::Int)::Int
	med = _median_3(nums, left, (left + right) ÷ 2, right)  # 以 nums[left] 为基准数
	nums[left], nums[med] = nums[med], nums[left]  # 将中位数交换至数组最左端
	i, j = left, right  # 以 nums[left] 为基准数
	while i < j
		while i < j && nums[j] ≥ nums[left]
			j -= 1  # 从右向左找首个小于基准数的元素
		end
		while i < j && nums[i] ≤ nums[left]
			i += 1  # 从左向右找首个大于基准数的元素
		end
		nums[i], nums[j] = nums[j], nums[i]  # 元素交换
	end
	nums[i], nums[left] = nums[left], nums[i]  # 将基准数交换至两子数组的分界线
	return i  # 返回基准数的索引
end


"""快速排序类"""
function quick_sort!(nums::Vector{Int}, left::Int=1, right::Int=length(nums))::Nothing
	if left < right  # 子数组长度为 1 时终止递归
		pivot = _partition!(nums, left, right)  # 哨兵划分
		quick_sort!(nums, left, pivot - 1)  # 递归左子数组、右子数组
		quick_sort!(nums, pivot + 1, right)
	end
	return nothing
end


"""快速排序类（中位基准数优化）"""
function quick_sort_median!(nums::Vector{Int}, left::Int=1, right::Int=length(nums))::Nothing
	if left < right  # 子数组长度为 1 时终止递归
		pivot = _partition_3!(nums, left, right)  # 哨兵划分
		quick_sort_median!(nums, left, pivot - 1)  # 递归左子数组、右子数组
		quick_sort_median!(nums, pivot + 1, right)
	end
	return nothing
end


"""快速排序（尾递归优化）"""
function quick_sort_tail_call!(nums::Vector{Int}, left::Int=1, right::Int=length(nums))::Nothing
	while left < right  # 子数组长度为 1 时终止
		pivot = _partition!(nums, left, right)  # 哨兵划分操作
		if pivot - left < right - pivot  # 对两个子数组中较短的那个执行快速排序
			quick_sort_tail_call!(nums, left, pivot - 1)  # 递归排序左子数组
			left = pivot + 1  # 剩余未排序区间为 [pivot + 1, right]
		else
			quick_sort_tail_call!(nums, pivot + 1, right)  # 递归排序右子数组
			right = pivot - 1  # 剩余未排序区间为 [left, pivot - 1]
		end
	end
	return nothing
end


if abspath(PROGRAM_FILE) == @__FILE__
	const nums = [2, 4, 1, 0, 3, 5]

	nums1 = copy(nums)  # 快速排序
	quick_sort!(nums1)
	println("快速排序完成后 nums = ", nums1)

	nums2 = copy(nums)  # 快速排序（中位基准数优化）
	quick_sort_median!(nums2)
	println("快速排序（中位基准数优化）完成后 nums = ", nums2)

	nums3 = copy(nums)  # 快速排序（尾递归优化）
	quick_sort_tail_call!(nums3)
	println("快速排序（尾递归优化）完成后 nums = ", nums3)
end
