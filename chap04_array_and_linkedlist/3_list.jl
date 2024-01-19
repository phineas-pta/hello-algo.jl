#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

if abspath(PROGRAM_FILE) == @__FILE__
	const nums = [1, 3, 2, 5, 4]  # 初始化列表
	println("\n列表 nums = ", nums)

	const x = nums[2]  # 访问元素
	println("\n访问索引 2 处的元素，得到 x = ", x)

	nums[2] = 0  # 更新元素
	println("\n将索引 2 处的元素更新为 0 ，得到 nums = ", nums)

	empty!(nums)  # 清空列表
	println("\n清空列表后 nums = ", nums)

	append!(nums, [1, 3, 2, 5, 4])  # 在尾部添加元素
	println("\n添加元素后 nums = ", nums)

	insert!(nums, 4, 6)  # 在中间插入元素
	println("\n在索引 4 处插入数字 6 ，得到 nums = ", nums)

	popat!(nums, 4)  # 删除元素
	println("\n删除索引 3 处的元素，得到 nums = ", nums)

	append!(nums, [6, 8, 7, 10, 9])  # 拼接两个列表
	println("\n将列表 nums1 拼接到 nums 之后，得到 nums = ", nums)

	sort!(nums)  # 排序列表
	println("\n排序列表后 nums = ", nums)
end
