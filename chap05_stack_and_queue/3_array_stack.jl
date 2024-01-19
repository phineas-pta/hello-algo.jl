#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

"""基于数组实现的栈"""
mutable struct ArrayStack
	stack::Vector{Int}
	ArrayStack() = new(Int[])  # 构造方法
end

"""获取栈的长度"""
size(stack::ArrayStack)::Int = length(stack.stack)

"""判断栈是否为空"""
is_empty(stack::ArrayStack)::Bool = isempty(stack.stack)

"""入栈"""
push!(stack::ArrayStack, item::Int) = Base.push!(stack.stack, item)  # full name coz overwritten itself

"""出栈"""
function pop!(stack::ArrayStack)::Int
	if is_empty(stack)
		error("栈为空")
	else
		return Base.pop!(stack.stack)  # full name coz overwritten itself
	end
end

"""访问栈顶元素"""
function peek(stack::ArrayStack)::Int
	if is_empty(stack)
		error("栈为空")
	else
		return stack.stack[end]
	end
end

"""返回列表用于打印"""
to_list(stack::ArrayStack)::Vector{Int} = stack.stack


if abspath(PROGRAM_FILE) == @__FILE__
	const stack = ArrayStack()  # 初始化栈

	push!(stack, 1); push!(stack, 3); push!(stack, 2); push!(stack, 5); push!(stack, 4)  # 元素入栈
	println("栈 stack = ", to_list(stack))

	println("栈顶元素 peek = ", peek(stack))  # 访问栈顶元素

	pop = pop!(stack)  # 元素出栈
	println("出栈元素 pop = ", pop)
	println("出栈后 stack = ", to_list(stack))

	println("栈的长度 size = ", size(stack))  # 获取栈的长度

	println("栈是否为空 = ", is_empty(stack))  # 判断是否为空
end
