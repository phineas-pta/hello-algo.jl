#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

"""双向链表节点"""
@kwdef mutable struct ListNode  # 构造方法
	val::Int
	next::Union{ListNode, Nothing} = nothing  # 后继节点引用
	prev::Union{ListNode, Nothing} = nothing  # 前驱节点引用
end

"""基于双向链表实现的双向队列"""
@kwdef mutable struct LinkedListDeque  # 构造方法
	front::Union{ListNode, Nothing} = nothing  # 头节点 front
	 rear::Union{ListNode, Nothing} = nothing  # 尾节点 rear
	size::Int = 0  # 双向队列的长度
end

"""获取双向队列的长度"""
size(deque::LinkedListDeque)::Int = deque.size

"""判断双向队列是否为空"""
is_empty(deque::LinkedListDeque)::Bool = deque.size == 0

"""入队操作"""
function _push!(deque::LinkedListDeque, num::Int, is_front::Bool)::Nothing
	node = ListNode(val=num)
	if is_empty(deque)  # 若链表为空，则令 front 和 rear 都指向 node
		deque.front = deque.rear = node
	elseif is_front  # 队首入队操作
		deque.front.prev = node  # 将 node 添加至链表头部
		node.next = deque.front
		deque.front = node  # 更新头节点
	else  # 队尾入队操作
		deque.rear.next = node  # 将 node 添加至链表尾部
		node.prev = deque.rear
		deque.rear = node  # 更新尾节点
	end
	deque.size += 1  # 更新队列长度
	return nothing
end

"""队首入队"""
push_first!(deque::LinkedListDeque, num::Int)::Nothing = _push!(deque, num, true)

"""队尾入队"""
push_last!(deque::LinkedListDeque, num::Int)::Nothing = _push!(deque, num, false)

"""出队操作"""
function _pop!(deque::LinkedListDeque, is_front::Bool)::Int
	if is_empty(deque) error("双向队列为空") end
	if is_front  # 队首出队操作
		val = deque.front.val  # 暂存头节点值
		fnext = deque.front.next  # 删除头节点
		if !isnothing(fnext)
			fnext.prev = deque.front.next = nothing
		end
		deque.front = fnext  # 更新头节点
	else  # 队尾出队操作
		val = deque.rear.val  # 暂存尾节点值
		rprev = deque.rear.prev  # 删除尾节点
		if !isnothing(rprev)
			rprev.next = deque.rear.prev = nothing
		end
		deque.rear = rprev  # 更新尾节点
	end
	deque.size -= 1  # 更新队列长度
	return val
end

"""队首出队"""
pop_first!(deque::LinkedListDeque)::Int = _pop!(deque, true)

"""队尾出队"""
pop_last!(deque::LinkedListDeque)::Int = _pop!(deque, false)

"""访问队首元素"""
function peek_first(deque::LinkedListDeque)::Int
	if is_empty(deque)
		error("双向队列为空")
	else
		return deque.front.val
	end
end

"""访问队尾元素"""
function peek_last(deque::LinkedListDeque)::Int
	if is_empty(deque)
		error("双向队列为空")
	else
		return deque.rear.val
	end
end

"""返回数组用于打印"""
function to_array(deque::LinkedListDeque)::Vector{Int}
	res = fill(0, deque.size)
	node = deque.front
	for i ∈ 1:deque.size
		res[i] = node.val
		node = node.next
	end
	return res
end


if abspath(PROGRAM_FILE) == @__FILE__
	const deque = LinkedListDeque()  # 初始化双向队列

	push_last!(deque, 3); push_last!(deque, 2); push_last!(deque, 5)
	println("双向队列 deque = ", to_array(deque))

	# 访问元素
	println("队首元素 peek_first = ", peek_first(deque))
	println("队尾元素 peek_last = ", peek_last(deque))

	# 元素入队
	push_last!(deque, 4)
	println("元素 4 队尾入队后 deque = ", to_array(deque))
	push_first!(deque, 1)
	println("元素 1 队首入队后 deque = ", to_array(deque))

	# 元素出队
	println("队尾出队元素 = ", pop_last!(deque),  " ，队尾出队后 deque = ", to_array(deque))
	println("队首出队元素 = ", pop_first!(deque), " ，队首出队后 deque = ", to_array(deque))

	println("双向队列长度 size = ", size(deque))  # 获取双向队列的长度
	println("双向队列是否为空 = ", is_empty(deque))  # 判断双向队列是否为空
end
