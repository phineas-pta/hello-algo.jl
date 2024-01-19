#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

include("../utils/utils.jl")
import .utils: TreeNode, print_tree


if abspath(PROGRAM_FILE) == @__FILE__
	# 初始化二叉树
	# 初始化节点
	const n1 = TreeNode(val=1)
	const n2 = TreeNode(val=2)
	const n3 = TreeNode(val=3)
	const n4 = TreeNode(val=4)
	const n5 = TreeNode(val=5)

	# 构建节点之间的引用（指针）
	n1.left = n2
	n1.right = n3
	n2.left = n4
	n2.right = n5
	println("\n初始化二叉树\n")
	print_tree(n1)

	# 插入与删除节点
	const P = TreeNode(val=0)
	# 在 n1 -> n2 中间插入节点 P
	n1.left = P
	P.left = n2
	println("\n插入节点 P 后\n")
	print_tree(n1)

	# 删除节点
	n1.left = n2
	println("\n删除节点 P 后\n")
	print_tree(n1)
end
