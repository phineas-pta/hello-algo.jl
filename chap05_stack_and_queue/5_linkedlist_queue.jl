#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

include("../utils/utils.jl")
import .utils: ListNode


"""基于链表实现的队列"""
@kwdef mutable struct LinkedListQueue  # 构造方法
	front::Union{ListNode, Nothing} = nothing  # 头节点 front
	 rear::Union{ListNode, Nothing} = nothing  # 尾节点 rear
	size::Int = 0
end

"""获取队列的长度"""
size(queue::LinkedListQueue)::Int = queue.size

"""判断队列是否为空"""
is_empty(queue::LinkedListQueue)::Bool = isnothing(queue.front)

"""入队"""
function push!(queue::LinkedListQueue, num::Int)::Nothing
	node = ListNode(val=num)  # 在尾节点后添加 num
	if isnothing(queue.front)  # 如果队列为空，则令头、尾节点都指向该节点
		queue.front = queue.rear = node
	else  # 如果队列不为空，则将该节点添加到尾节点后
		queue.rear.next = node
		queue.rear = node
	end
	queue.size += 1
	return nothing
end

"""出队"""
function pop!(queue::LinkedListQueue)::Int
	num = peek(queue)
	queue.front = queue.front.next  # 删除头节点
	queue.size -= 1
	return num
end

"""访问队首元素"""
function peek(queue::LinkedListQueue)::Int
	if is_empty(queue)
		error("队列为空")
	else
		return queue.front.val
	end
end

"""转化为列表用于打印"""
function to_list(queue::LinkedListQueue)::Vector{Int}
	arr = Int[]
	node = queue.front
	while !isnothing(node)
		Base.push!(arr, node.val)  # full name coz overwritten above
		node = node.next
	end
	return arr
end


if abspath(PROGRAM_FILE) == @__FILE__
	const queue = LinkedListQueue()  # 初始化队列

	push!(queue, 1); push!(queue, 3); push!(queue, 2); push!(queue, 5); push!(queue, 4)  # 元素入栈
	println("队列 queue = ", to_list(queue))

	println("队首元素 front = ", peek(queue))  # 访问队首元素

	println("出队元素 pop = ", pop!(queue))  # 元素出队
	println("出队后 queue = ", to_list(queue))

	println("队列长度 size = ", size(queue))  # 获取队列的长度

	println("队列是否为空 = ", is_empty(queue))  # 判断队列是否为空
end
