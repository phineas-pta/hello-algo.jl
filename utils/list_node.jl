"""链表节点类"""
@kwdef mutable struct ListNode
	val::Int  # 节点值
	next::Union{ListNode, Nothing} = nothing  # 后继节点引用
end


"""将列表序列化为链表"""
function list_to_linked_list(arr::Vector{Int})::Union{ListNode, Nothing}
	dum = head = ListNode(val=0)
	for a ∈ arr
		node = ListNode(val=a)
		head.next = node
		head = head.next
	end
	return dum.next
end


"""将链表反序列化为列表"""
function linked_list_to_list(head::Union{ListNode, Nothing})::Vector{Int}
	arr = Int[]
	while !isnothing(head)
		push!(arr, head.val)
		head = head.next
	end
	return arr
end
