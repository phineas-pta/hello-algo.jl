#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

include("../utils/utils.jl")
import .utils: ListNode


"""基于链表实现的栈"""
@kwdef mutable struct LinkedListStack  # 构造方法
	peek::Union{ListNode, Nothing} = nothing
	size::Int = 0
end

"""获取栈的长度"""
size(stack::LinkedListStack)::Int = stack.size

"""判断栈是否为空"""
is_empty(stack::LinkedListStack)::Bool = isnothing(stack.peek)

"""入栈"""
function push!(stack::LinkedListStack, val::Int)::Nothing
	node = ListNode(val=val)
	node.next = stack.peek
	stack.peek = node
	stack.size += 1
	return nothing
end

"""出栈"""
function pop!(stack::LinkedListStack)::Int
	num = peek(stack)
	stack.peek = stack.peek.next
	stack.size -= 1
	return num
end

"""访问栈顶元素"""
function peek(stack::LinkedListStack)::Int
	if is_empty(stack)
		error("栈为空")
	else
		return stack.peek.val
	end
end

"""转化为列表用于打印"""
function to_list(stack::LinkedListStack)::Vector{Int}
	arr = Int[]
	node = stack.peek
	while !isnothing(node)
		pushfirst!(arr, node.val)
		node = node.next
	end
	return arr
end


if abspath(PROGRAM_FILE) == @__FILE__
	const stack = LinkedListStack()  # 初始化栈

	push!(stack, 1); push!(stack, 3); push!(stack, 2); push!(stack, 5); push!(stack, 4)  # 元素入栈
	println("栈 stack = ", to_list(stack))

	println("栈顶元素 peek = ", peek(stack))  # 访问栈顶元素

	println("出栈元素 pop = ", pop!(stack))  # 元素出栈
	println("出栈后 stack = ", to_list(stack))

	println("栈的长度 size = ", size(stack))  # 获取栈的长度

	println("栈是否为空 = ", is_empty(stack))  # 判断是否为空
end
