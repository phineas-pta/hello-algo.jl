#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

include("../utils/utils.jl")
import .utils: ListNode, print_linked_list


"""在链表的节点 n0 之后插入节点 P"""
function insert!(n0::ListNode, P::ListNode)::Nothing
	n1 = n0.next
	P.next = n1
	n0.next = P
	return nothing
end


"""删除链表的节点 n0 之后的首个节点"""
function remove!(n0::ListNode)::Nothing
	if isnothing(n0.next)  # n0 → P → n1
		P = n0.next
		n1 = P.next
		n0.next = n1
	end
	return nothing
end


"""访问链表中索引为 index 的节点"""
function access(head::Union{ListNode, Nothing}, index::Int)::Union{ListNode, Nothing}
	for i ∈ 2:index
		if isnothing(head)
			return nothing
		else
			head = head.next
		end
	end
	return head
end


"""在链表中查找值为 target 的首个节点"""
function find(head::Union{ListNode, Nothing}, target::Int)::Int
	index = 1
	while !isnothing(head)
		if head.val == target
			return index
		else
			head = head.next
			index += 1
		end
	end
	return 0
end


if abspath(PROGRAM_FILE) == @__FILE__
	# 初始化链表
	# 初始化各个节点
	const n0 = ListNode(val=1)
	const n1 = ListNode(val=3)
	const n2 = ListNode(val=2)
	const n3 = ListNode(val=5)
	const n4 = ListNode(val=4)

	# 构建节点之间的引用
	n0.next = n1
	n1.next = n2
	n2.next = n3
	n3.next = n4
	println("初始化的链表为")
	print_linked_list(n0)

	const p = ListNode(val=0)  # 插入节点
	insert!(n0, p)
	println("插入节点后的链表为")
	print_linked_list(n0)

	remove!(n0)  # 删除节点
	println("删除节点后的链表为")
	print_linked_list(n0)

	const node = access(n0, 4)  # 访问节点
	println("链表中索引 4 处的节点的值 = ", node.val)

	const index = find(n0, 2)  # 查找节点
	println("链表中值为 2 的节点的索引 = ", index)
end
