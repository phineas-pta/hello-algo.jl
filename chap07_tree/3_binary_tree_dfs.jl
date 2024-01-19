#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

include("../utils/utils.jl")
import .utils: TreeNode, list_to_tree, print_tree


"""前序遍历"""
function pre_order!(res::Vector{Int}, root::Union{TreeNode, Nothing})::Nothing
	if !isnothing(root)
		push!(res, root.val)  # 访问优先级：根节点 → 左子树 → 右子树
		pre_order!(res, root.left)
		pre_order!(res, root.right)
	end
	return nothing
end


"""中序遍历"""
function in_order!(res::Vector{Int}, root::Union{TreeNode, Nothing})::Nothing
	if !isnothing(root)
		in_order!(res, root.left)
		push!(res, root.val)  # 访问优先级：左子树 -> 根节点 -> 右子树
		in_order!(res, root.right)
	end
	return nothing
end


"""后序遍历"""
function post_order!(res::Vector{Int}, root::Union{TreeNode, Nothing})::Nothing
	if !isnothing(root)
		post_order!(res, root.left)
		post_order!(res, root.right)
		push!(res, root.val)  # 访问优先级：左子树 -> 右子树 -> 根节点
	end
	return nothing
end


if abspath(PROGRAM_FILE) == @__FILE__
	# 初始化二叉树
	const arr = Vector{Union{Int, Nothing}}([1, 2, 3, 4, 5, 6, 7])  # force type
	# 这里借助了一个从数组直接生成二叉树的函数
	const root = list_to_tree(arr)
	println("\n初始化二叉树\n")
	print_tree(root)

	# 前序遍历
	const res = Int[]
	pre_order!(res, root)
	println("\n前序遍历的节点打印序列 = ", res)

	# 中序遍历
	empty!(res)
	in_order!(res, root)
	println("\n中序遍历的节点打印序列 = ", res)

	# 后序遍历
	empty!(res)
	post_order!(res, root)
	println("\n后序遍历的节点打印序列 = ", res)
end
