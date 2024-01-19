#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

include("../utils/utils.jl")
import .utils: TreeNode, list_to_tree, print_tree


"""层序遍历"""
function level_order(root::Union{TreeNode, Nothing})::Vector{Int}
	queue = [root]  # 初始化队列，加入根节点
	res = Int[]  # 初始化一个列表，用于保存遍历序列
	while length(queue) > 0
		node = popfirst!(queue)  # 队列出队
		push!(res, node.val)  # 保存节点值
		if !isnothing(node.left)  push!(queue, node.left)  end  # 左子节点入队
		if !isnothing(node.right) push!(queue, node.right) end  # 右子节点入队
	end
	return res
end


if abspath(PROGRAM_FILE) == @__FILE__
	# 初始化二叉树
	const arr = Vector{Union{Int, Nothing}}([1, 2, 3, 4, 5, 6, 7])  # force type
	# 这里借助了一个从数组直接生成二叉树的函数
	const root = list_to_tree(arr)
	println("\n初始化二叉树\n")
	print_tree(root)
	println("\n层序遍历的节点打印序列 = ", level_order(root))  # 层序遍历
end
