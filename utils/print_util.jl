"""打印矩阵"""
function print_matrix(mat::Vector{Vector{Int}})::Nothing
	s = String[]
	for arr ∈ mat
		push!(s, "  " * string(arr))
	end
	println("[\n" * join(s, ",\n") * "\n]")
	return nothing
end


"""打印链表"""
function print_linked_list(head::Union{ListNode, Nothing})::Nothing
	arr = linked_list_to_list(head)
	println(join(arr, " → "))
	return nothing
end


@kwdef mutable struct _Trunk
	prev::Union{_Trunk, Nothing}
	str::Union{String, Nothing} = nothing
end


function _show_trunks(p::Union{_Trunk, Nothing})::Nothing
	if !isnothing(p)
		_show_trunks(p.prev)
		print(p.str)
	end
	return nothing
end


"""
打印二叉树
This tree printer is borrowed from TECHIE DELIGHT
https://www.techiedelight.com/c-program-print-binary-tree/
"""
function print_tree(root::Union{TreeNode, Nothing}, prev::Union{_Trunk, Nothing} = nothing, is_right::Bool = false)::Nothing
	if !isnothing(root)
		prev_str = "    "
		trunk = _Trunk(prev=prev, str=prev_str)
		print_tree(root.right, trunk, true)

		if isnothing(prev)
			trunk.str = "———"
		elseif is_right
			trunk.str = "/———"
			prev_str = "   |"
		else
			trunk.str = raw"\———"
			prev.str = prev_str
		end

		_show_trunks(trunk)
		println(" ", root.val)
		if !isnothing(prev)
			prev.str = prev_str
		end
		trunk.str = "   |"
		print_tree(root.left, trunk, false)
	end
	return nothing
end


"""打印字典"""
function print_dict(hmap::Dict)::Nothing
	for (key, value) ∈ hmap
		println(key, " → ", value)
	end
	return nothing
end


"""打印堆"""
function print_heap(heap::Vector{Int})::Nothing
	println("堆的数组表示：", heap)
	println("堆的树状表示")
	Vector{Union{Nothing, Int64}}(heap) |> list_to_tree |> print_tree  # force type
end
