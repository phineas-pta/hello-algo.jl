#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

"""基于环形数组实现的双向队列"""
mutable struct ArrayDeque
	nums::Vector{Int}
	front::Int
	size::Int
	ArrayDeque(capacity::Int) = new(fill(0, capacity), 0, 0)  # 构造方法
end

"""获取双向队列的容量"""
capacity(deque::ArrayDeque)::Int = length(deque.nums)

"""获取双向队列的长度"""
size(deque::ArrayDeque)::Int = deque.size

"""判断双向队列是否为空"""
is_empty(deque::ArrayDeque)::Bool = deque.size == 0

"""计算环形数组索引"""
_index(deque::ArrayDeque, i::Int)::Int = (i + capacity(deque)) % capacity(deque)

"""队首入队"""
function push_first!(deque::ArrayDeque, num::Int)::Nothing
	if deque.size == capacity(deque)
		println("双向队列已满")
	else  # 队首指针向左移动一位
		deque.front = _index(deque, deque.front - 1)  # 通过取余操作实现 front 越过数组头部后回到尾部
		deque.nums[deque.front + 1] = num  # 将 num 添加至队首
		deque.size += 1
	end
	return nothing
end

"""队尾入队"""
function push_last!(deque::ArrayDeque, num::Int)::Nothing
	if deque.size == capacity(deque)
		println("双向队列已满")
	else  # 计算队尾指针，指向队尾索引 + 1
		rear = _index(deque, deque.front + deque.size)
		deque.nums[rear + 1] = num  # 将 num 添加至队尾
		deque.size += 1
	end
	return nothing
end

"""队首出队"""
function pop_first!(deque::ArrayDeque)::Int
	num = peek_first(deque)
	deque.front = _index(deque, deque.front + 1)  # 队首指针向后移动一位
	deque.size -= 1
	return num
end

"""队尾出队"""
function pop_last!(deque::ArrayDeque)::Int
	num = peek_last(deque)
	deque.size -= 1
	return num
end

"""访问队首元素"""
function peek_first(deque::ArrayDeque)::Int
	if is_empty(deque)
		error("双向队列为空")
	else
		return deque.nums[deque.front + 1]
	end
end

"""访问队尾元素"""
function peek_last(deque::ArrayDeque)::Int
	if is_empty(deque)
		error("双向队列为空")
	else  # 计算尾元素索引
		last = _index(deque, deque.front + deque.size - 1)
		return deque.nums[last + 1]
	end
end

"""返回数组用于打印"""
function to_array(deque::ArrayDeque)::Vector{Int}
	res = Int[]  # 仅转换有效长度范围内的列表元素
	for i ∈ 1:deque.size
		tmp = _index(deque, deque.front + i)
		push!(res, deque.nums[tmp + 1])
	end
	return res
end


if abspath(PROGRAM_FILE) == @__FILE__
	const deque = ArrayDeque(10)  # 初始化双向队列

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
