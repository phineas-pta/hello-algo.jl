module utils

export
	#= chap 6 hash =# Pair,
	#= list_node =# ListNode, list_to_linked_list, linked_list_to_list,
	#= tree_node =# TreeNode, list_to_tree, tree_to_list,
	#= vertex =# Vertex, vals_to_vets, vets_to_vals,
	#= print_util =# print_matrix, print_linked_list, print_tree, print_dict, print_heap

"""键值对"""
mutable struct Pair  # chap 6 hash
	key::Int
	val::String
end

include("list_node.jl")
include("tree_node.jl")
include("vertex.jl")
include("print_util.jl")

end
