#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

"""堆的长度为 n ，从节点 i 开始，从顶至底堆化"""
function _shift_down!(nums::Vector{Int}, n::Int, i::Int)::Nothing
	while true
		l, r = 2i, 2i + 1  # 判断节点 i, l, r 中值最大的节点，记为 ma
		ma = i
		if l < n && nums[l] > nums[ma]; ma = l end
		if r < n && nums[r] > nums[ma]; ma = r end
		if ma == i break end  # 若节点 i 最大或索引 l, r 越界，则无须继续堆化，跳出
		nums[i], nums[ma] = nums[ma], nums[i]  # 交换两节点
		i = ma  # 循环向下堆化
	end
	return nothing
end


"""堆排序"""
function heap_sort!(nums::Vector{Int})::Nothing
	for i ∈ (length(nums)÷2):-1:1  # 建堆操作：堆化除叶节点以外的其他所有节点
		_shift_down!(nums, length(nums), i)
	end
	for i ∈ length(nums):-1:1  # 从堆中提取最大元素，循环 n-1 轮
		nums[1], nums[i] = nums[i], nums[1]
		_shift_down!(nums, i, 1)  # 以根节点为起点，从顶至底进行堆化
	end
	return nothing
end


if abspath(PROGRAM_FILE) == @__FILE__
	const nums = [4, 1, 3, 1, 5, 2]
	heap_sort!(nums)
	println("堆排序完成后 nums = ", nums)
end
