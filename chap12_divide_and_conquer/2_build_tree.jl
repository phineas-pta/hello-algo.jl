#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

include("../utils/utils.jl")
import .utils: TreeNode, print_tree


"""构建二叉树：分治"""
function _dfs(preorder::Vector{Int}, inorder_map::Dict{Int, Int}, i::Int, l::Int, r::Int)::Union{TreeNode, Nothing}
	if r - l < 0 return nothing end
	root = TreeNode(val=preorder[i])  # 初始化根节点
	m = inorder_map[preorder[i]]  # 查询 m ，从而划分左右子树
	root.left  = _dfs(preorder, inorder_map, i + 1,             l, m - 1)  # 子问题：构建左子树
	root.right = _dfs(preorder, inorder_map, i + 1 + m - l, m + 1, r)      # 子问题：构建右子树
	return root  # 返回根节点
end


"""构建二叉树"""
function build_tree(preorder::Vector{Int}, inorder::Vector{Int})::Union{TreeNode, Nothing}
	inorder_map = Dict(val => i for (i, val) ∈ enumerate(inorder))  # 初始化哈希表，存储 inorder 元素到索引的映射
	return _dfs(preorder, inorder_map, 1, 1, length(inorder))
end


if abspath(PROGRAM_FILE) == @__FILE__
	const preorder = [3, 9, 2, 1, 7]
	const inorder = [9, 3, 1, 2, 7]
	println("前序遍历 = ", preorder)
	println("中序遍历 = ", inorder)

	root = build_tree(preorder, inorder)
	println("构建的二叉树为：")
	print_tree(root)
end
