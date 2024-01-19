#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

"""列表类"""
@kwdef mutable struct MyList  # 构造方法
	capacity::Int = 10  # 列表容量
	arr::Vector{Int} = fill(0, capacity)  # 数组（存储列表元素）
	size::Int = 0  # 列表长度（当前元素数量）
	extend_ratio::Int = 2  # 每次列表扩容的倍数
end

"""获取列表长度（当前元素数量）"""
size(nums::MyList)::Int = nums.size

"""获取列表容量"""
capacity(nums::MyList)::Int = nums.capacity

"""访问元素"""
function get(nums::MyList, index::Int)::Int
	if index < 1 || index > nums.size  # 索引如果越界，则抛出异常，下同
		error("索引越界")
	else
		return nums.arr[index]
	end
end

"""更新元素"""
function set!(nums::MyList, num::Int; index::Int)::Nothing
	if index < 1 || index > nums.size  # 索引如果越界，则抛出异常，下同
		error("索引越界")
	else
		nums.arr[index] = num
		return nothing
	end
end

"""在尾部添加元素"""
function add!(nums::MyList, num::Int)::Nothing
	if nums.size == nums.capacity  # 元素数量超出容量时，触发扩容机制
		extend_capacity!(nums)
	end
	nums.arr[nums.size+1] = num
	nums.size += 1  # 更新元素数量
	return nothing
end

"""在中间插入元素"""
function insert!(nums::MyList, num::Int; index::Int)::Nothing
	if index < 1 || index > nums.size
		error("索引越界")
	end
	if nums.size == nums.capacity
		extend_capacity!(nums)
	end
	for i ∈ (nums.size-1):-1:(index-1)  # 将索引 index 以及之后的元素都向后移动一位
		nums.arr[i + 1] = nums.arr[i]
	end
	nums.arr[index] = num
	nums.size += 1
	return nothing
end

"""删除元素"""
function remove!(nums::MyList, index::Int)::Int
	if index < 1 || index > nums.size error("索引越界") end
	num = nums.arr[index]
	for i ∈ index:(nums.size-1)
		nums.arr[i] = nums.arr[i + 1]
	end
	nums.size -= 1
	return num  # 返回被删除的元素
end

"""列表扩容"""
function extend_capacity!(nums::MyList)::Nothing
	tmp = fill(0, nums.capacity * (nums.extend_ratio - 1))
	nums.arr = append!(nums.arr, tmp)  # 新建一个长度为原数组 _extend_ratio 倍的新数组，并将原数组复制到新数组
	nums.capacity = length(nums.arr)  # 更新列表容量
	return nothing
end

"""返回有效长度的列表"""
to_array(nums::MyList)::Vector{Int} = nums.arr[begin:nums.size]


if abspath(PROGRAM_FILE) == @__FILE__
	const nums = MyList()  # 初始化列表

	add!(nums, 1); add!(nums, 3); add!(nums, 2); add!(nums, 5); add!(nums, 4)  # 在尾部添加元素
	println("列表 nums = ", to_array(nums), " ，容量 = ", capacity(nums), " ，长度 = ", size(nums))

	insert!(nums, 6; index=4)  # 在中间插入元素
	println("在索引 4处插入数字 6 ，得到 nums = ", to_array(nums))

	remove!(nums, 4)  # 删除元素
	println("删除索引 4 处的元素，得到 nums = ", to_array(nums))

	set!(nums, 1; index=1)  # 更新元素
	println("将索引 1 处的元素更新为 1 ，得到 nums = ", to_array(nums))

	for i ∈ 1:10  # 测试扩容机制
		add!(nums, i)  # 在 i = 5 时，列表长度将超出列表容量，此时触发扩容机制
	end
	println("扩容后的列表 ", to_array(nums), " ，容量 = ", capacity(nums), " ，长度 = ", size(nums))
end
