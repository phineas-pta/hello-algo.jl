#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

if abspath(PROGRAM_FILE) == @__FILE__
	const stack = Int[]  # 初始化栈

	append!(stack, [1, 3, 2, 5, 4])  # 元素入栈
	println("栈 stack = ", stack)

	peek = stack[end]  # 访问栈顶元素
	println("栈顶元素 peek = ", peek)

	pop = pop!(stack)  # 元素出栈
	println("出栈元素 pop = ", pop)
	println("出栈后 stack = ", stack)

	size = length(stack)  # 获取栈的长度
	println("栈的长度 size = ", size)

	is_empty = size == 0  # 判断是否为空
	println("栈是否为空 = ", is_empty)
end
