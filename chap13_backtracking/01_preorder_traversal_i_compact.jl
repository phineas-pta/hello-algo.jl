#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

include("../utils/utils.jl")
import .utils: TreeNode, print_tree, list_to_tree


"""前序遍历：例题一"""
function pre_order!(res::Vector{TreeNode}, root::Union{TreeNode, Nothing})::Nothing
	if !isnothing(root)
		if root.val == 7
			push!(res, root)  # 记录解
		end
		pre_order!(res, root.left)
		pre_order!(res, root.right)
	end
	return nothing
end


if abspath(PROGRAM_FILE) == @__FILE__
	const arr = Vector{Union{Int, Nothing}}([1, 7, 3, 4, 5, 6, 7])  # force type
	const root = list_to_tree(arr)
	println("\n初始化二叉树")
	print_tree(root)

	res = TreeNode[]  # 前序遍历
	pre_order!(res, root)
	println("\n输出所有值为 7 的节点")
	println([node.val for node ∈ res])
end
