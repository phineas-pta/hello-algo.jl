#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

include("../utils/utils.jl")
import .utils: ListNode, list_to_linked_list


"""哈希查找（数组）"""
function hashing_search_array(hmap::Dict{Int, Int}, target::Int)::Int
	return get(hmap, target, 0)  # 若哈希表中无此 key ，返回 0
end


"""哈希查找（链表）"""
function hashing_search_linkedlist(hmap::Dict{Int, ListNode}, target::Int)::Union{ListNode, Nothing}
	return get(hmap, target, nothing)  # 若哈希表中无此 key ，返回 None
end


if abspath(PROGRAM_FILE) == @__FILE__
	const nums = [1, 5, 3, 2, 4, 7, 5, 9, 10, 8]  # 哈希查找（数组）
	const target = 3

	const map0 = Dict{Int, Int}()  # 初始化哈希表
	for i ∈ eachindex(nums)
		map0[nums[i]] = i  # key: 元素，value: 索引
	end
	println("目标元素 3 的索引 = ", hashing_search_array(map0, target))

	head = list_to_linked_list(nums)  # 哈希查找（链表）
	const map1 = Dict{Int, ListNode}()  # 初始化哈希表
	while !isnothing(head)
		map1[head.val] = head  # key: 节点值，value: 节点
		global head = head.next
	end
	println("目标节点值 3 的对应节点对象为 ", hashing_search_linkedlist(map1, target))
end
