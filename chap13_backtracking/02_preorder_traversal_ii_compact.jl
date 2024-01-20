#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

include("../utils/utils.jl")
import .utils: TreeNode, print_tree, list_to_tree


"""前序遍历：例题二"""
function pre_order!(res::Vector{Vector{TreeNode}}, path::Vector{TreeNode}, root::Union{TreeNode, Nothing})::Nothing
	if !isnothing(root)
		push!(path, root)  # 尝试
		if root.val == 7
			push!(res, path)  # 记录解
		end
		pre_order!(res, path, root.left)
		pre_order!(res, path, root.right)
		pop!(path)  # 回退
	end
	return nothing
end


if abspath(PROGRAM_FILE) == @__FILE__
	const arr = Vector{Union{Int, Nothing}}([1, 7, 3, 4, 5, 6, 7])  # force type
	const root = list_to_tree(arr)
	println("\n初始化二叉树")
	print_tree(root)

	path = TreeNode[]
	res = Vector{Vector{TreeNode}}()
	pre_order!(res, path, root)

	println("\n输出所有根节点到节点 7 的路径")
	for p ∈ res
		println([node.val for node ∈ p for p ∈ res])
	end
end
