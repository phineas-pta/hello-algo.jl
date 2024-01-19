#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

include("../utils/utils.jl")
import .utils: ListNode, list_to_linked_list


"""线性查找（数组）"""
function linear_search_array(nums::Vector{Int}, target::Int)::Int
	for i ∈ eachindex(nums)  # 遍历数组
		if nums[i] == target return i end  # 找到目标元素，返回其索引
	end
	return 0  # 未找到目标元素，返回 0
end


"""线性查找（链表）"""
function linear_search_linkedlist(head::Union{ListNode, Nothing}, target::Int)::Union{ListNode, Nothing}
	while !isnothing(head)  # 遍历链表
		if head.val == target  # 找到目标节点，返回之
			return head
		else
			head = head.next
		end
	end
	return nothing  # 未找到目标节点，返回 None
end


if abspath(PROGRAM_FILE) == @__FILE__
	const nums = [1, 5, 3, 2, 4, 7, 5, 9, 10, 8]  # 在数组中执行线性查找
	const target = 3
	println("目标元素 3 的索引 = ", linear_search_array(nums, target))  # 在数组中执行线性查找

	const head = list_to_linked_list(nums)  # 在链表中执行线性查找
	println("目标节点值 3 的对应节点对象为 ", linear_search_linkedlist(head, target))
end
