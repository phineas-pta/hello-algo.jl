#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

"""随机访问元素"""
function random_access(nums::Vector{Int})::Int
	random_index = rand(1:length(nums))  # 在区间 [1, len(nums)] 中随机抽取一个数字
	return nums[random_index]  # 获取并返回随机元素
end


# 请注意，Python 的 list 是动态数组，可以直接扩展
# 为了方便学习，本函数将 list 看作长度不可变的数组
"""扩展数组长度"""
function extend(nums::Vector{Int}, enlarge::Int)::Vector{Int}
	res = fill(0, length(nums) + enlarge)  # 初始化一个扩展长度后的数组
	for i ∈ eachindex(nums)  # 将原数组中的所有元素复制到新数组
		res[i] = nums[i]
	end
	return res  # 返回扩展后的新数组
end


"""在数组的索引 index 处插入元素 num"""
function insert!(nums::Vector{Int}, num::Int, index::Int)::Nothing
	for i ∈ length(nums):-1:index
		nums[i] = nums[i - 1]
	end
	nums[index] = num  # 将 num 赋给 index 处的元素
	return nothing
end


"""删除索引 index 处的元素"""
function remove!(nums::Vector{Int}, index::Int)::Nothing
	for i ∈ index:(length(nums)-1)  # 把索引 index 之后的所有元素向前移动一位
		nums[i] = nums[i + 1]
	end
	return nothing
end


"""遍历数组"""
function traverse(nums::Vector{Int})::Nothing
	count = 0
	for i ∈ eachindex(nums)  # 通过索引遍历数组
		count += nums[i]
	end
	for num ∈ nums  # 直接遍历数组元素
		count += num
	end
	for (i, num) ∈ enumerate(nums)  # 同时遍历数据索引和元素
		count += nums[i]
		count += num
	end
	return nothing
end


"""在数组中查找指定元素"""
function find(nums::Vector{Int}, target::Int)::Int
	for i ∈ eachindex(nums)
		if nums[i] == target return i end
	end
	return 0
end


if abspath(PROGRAM_FILE) == @__FILE__
	arr = fill(0, 5)  # 初始化数组
	println("数组 arr = ", arr)
	nums = [1, 3, 2, 5, 4]
	println("数组 nums = ", nums)

	random_num = random_access(nums)  # 随机访问
	println("在 nums 中获取随机元素 ", random_num)

	nums = extend(nums, 3)  # 长度扩展
	println("将数组长度扩展至 8 ，得到 nums = ", nums)

	insert!(nums, 6, 3)  # 插入元素
	println("在索引 3 处插入数字 6 ，得到 nums = ", nums)

	remove!(nums, 2)  # 删除元素
	println("删除索引 2 处的元素，得到 nums = ", nums)

	traverse(nums)  # 遍历数组
end
