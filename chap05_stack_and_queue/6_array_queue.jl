#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

"""基于环形数组实现的队列"""
mutable struct ArrayQueue
	nums::Vector{Int}  # 用于存储队列元素的数组
	front::Int  # 队首指针，指向队首元素
	size::Int  # 队列长度
	ArrayQueue(size::Int) = new(fill(0, size), 0, 0)  # 构造方法
end

"""获取队列的容量"""
capacity(queue::ArrayQueue)::Int = length(queue.nums)

"""获取队列的长度"""
size(queue::ArrayQueue)::Int = queue.size

"""判断队列是否为空"""
is_empty(queue::ArrayQueue)::Bool = queue.size == 0

"""入队"""
function push!(queue::ArrayQueue, num::Int)::Nothing
	if queue.size == capacity(queue) error("队列已满") end
	# 计算队尾指针，指向队尾索引 + 1
	rear = (queue.front + queue.size) % capacity(queue)  # 通过取余操作实现 rear 越过数组尾部后回到头部
	queue.nums[rear + 1] = num  # 将 num 添加至队尾
	queue.size += 1
	return nothing
end

"""出队"""
function pop!(queue::ArrayQueue)::Int
	num = peek(queue)
	queue.front = (queue.front + 1) % capacity(queue)  # 队首指针向后移动一位，若越过尾部，则返回到数组头部
	queue.size -= 1
	return num
end

"""访问队首元素"""
function peek(queue::ArrayQueue)::Int
	if is_empty(queue)
		error("队列为空")
	else
		return queue.nums[queue.front + 1]
	end
end

"""返回列表用于打印"""
function to_list(queue::ArrayQueue)::Vector{Int}
	res = fill(0, queue.size)
	j = queue.front
	for i ∈ 1:queue.size
		res[i] = queue.nums[j % capacity(queue) + 1]
		j += 1
	end
	return res
end


if abspath(PROGRAM_FILE) == @__FILE__
	const queue = ArrayQueue(10)  # 初始化队列

	push!(queue, 1); push!(queue, 3); push!(queue, 2); push!(queue, 5); push!(queue, 4)  # 元素入栈
	println("队列 queue = ", to_list(queue))

	println("队首元素 peek = ", peek(queue))  # 访问队首元素

	println("出队元素 pop = ", pop!(queue))  # 元素出队
	println("出队后 queue = ", to_list(queue))

	println("队列长度 size = ", size(queue))  # 获取队列的长度

	println("队列是否为空 = ", is_empty(queue))  # 判断队列是否为空

	for i ∈ 1:10  # 测试环形数组
		push!(queue, i)
		pop!(queue)
		println("第 $i 轮入队 + 出队后 queue = ", to_list(queue))
	end
end
