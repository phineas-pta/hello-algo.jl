#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

"""计数排序"""
function counting_sort_naive!(nums::Vector{Int})::Nothing
	# 简单实现，无法用于排序对象
	m = maximum(nums)  # 1. 统计数组最大元素 m
	counter = fill(0, m + 1)  # 2. 统计各数字的出现次数
	for num ∈ nums  # counter[num] 代表 num 的出现次数
		counter[num+1] += 1
	end
	i = 1  # 3. 遍历 counter ，将各元素填入原数组 nums
	for num ∈ 0:m, _ ∈ 1:counter[num+1]
		if i > length(nums) break end  # julia problem
		nums[i] = num
		i += 1
	end
	return nothing
end


"""计数排序"""
function counting_sort!(nums::Vector{Int})::Nothing
	# 完整实现，可排序对象，并且是稳定排序
	m = maximum(nums)  # 1. 统计数组最大元素 m
	counter = fill(0, m + 1)  # 2. 统计各数字的出现次数
	for num ∈ nums  # counter[num] 代表 num 的出现次数
		counter[num+1] += 1
	end
	for i ∈ 1:m  # 3. 求 counter 的前缀和，将“出现次数”转换为“尾索引”
		counter[i+1] += counter[i]  # 即 counter[num]-1 是 num 在 res 中最后一次出现的索引
	end
	n = length(nums)  # 4. 倒序遍历 nums ，将各元素填入结果数组 res
	res = fill(0, n)  # 初始化数组 res 用于记录结果
	for i ∈ n:-1:1
		num = nums[i]
		res[counter[num+1]] = num  # 将 num 放置到对应索引处
		counter[num+1] -= 1  # 令前缀和自减 1 ，得到下次放置 num 的索引
	end
	for i ∈ 1:n  # 使用结果数组 res 覆盖原数组 nums
		nums[i] = res[i]
	end
	return nothing
end


if abspath(PROGRAM_FILE) == @__FILE__
	const nums0 = [1, 0, 1, 2, 0, 4, 0, 2, 2, 4]
	counting_sort_naive!(nums0)
	println("计数排序（无法排序对象）完成后 nums = ", nums0)

	const nums1 = [1, 0, 1, 2, 0, 4, 0, 2, 2, 4]
	counting_sort!(nums1)
	println("计数排序完成后 nums = ", nums1)
end
