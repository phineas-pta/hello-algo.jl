#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

if abspath(PROGRAM_FILE) == @__FILE__
	const deq = Int[]  # 初始化双向队列

	# 元素入队
	push!(deq, 2); push!(deq, 5); push!(deq, 4)  # 添加至队尾
	pushfirst!(deq, 3); pushfirst!(deq, 1)  # 添加至队首
	println("双向队列 deque = ", deq)

	# 访问元素
	println("队首元素 front = ", deq[begin])  # 队首元素
	println("队首元素 rear = ", deq[end])  # 队尾元素

	# 元素出队
	println("队首出队元素 pop_front = ", popfirst!(deq))  # 队首元素出队
	println("队首出队后 deque = ", deq)
	println("队尾出队元素 pop_rear = ", pop!(deq))  # 队尾元素出队
	println("队首出队后 deque = ", deq)

	size = length(deq)  # 获取双向队列的长度
	println("双向队列长度 size = ", size)

	is_empty = size == 0  # 判断双向队列是否为空
	println("双向队列是否为空 = ", is_empty)
end
