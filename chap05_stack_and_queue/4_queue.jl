#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

if abspath(PROGRAM_FILE) == @__FILE__
	const que = Int[]  # 初始化队列

	append!(que, [1, 3, 2, 5, 4])  # 元素入栈
	println("队列 que = ", que)

	println("队首元素 front = ", que[begin])  # 访问队首元素

	println("出队元素 pop = ", popfirst!(que))  # 元素出队
	println("出队后 que = ", que)

	size = length(que)  # 获取队列的长度
	println("队列长度 size = ", size)

	is_empty = size == 0  # 判断队列是否为空
	println("队列是否为空 = ", is_empty)
end
