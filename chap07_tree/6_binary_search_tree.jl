#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

include("../utils/utils.jl")
import .utils: TreeNode, print_tree


#=
"""二叉搜索树"""
struct BinarySearchTree
	root::Union{TreeNode, Nothing}
end
=#


"""查找节点"""
function search(bst::Union{TreeNode, Nothing}, num::Int)::Union{TreeNode, Nothing}
	cur = bst
	while !isnothing(cur)  # 循环查找，越过叶节点后跳出
		if cur.val < num  # 目标节点在 cur 的右子树中
			cur = cur.right
		elseif cur.val > num  # 目标节点在 cur 的左子树中
			cur = cur.left
		else  # 找到目标节点，跳出循环
			break
		end
	end
	return cur  # 返回目标节点
end


"""插入节点"""  # TODO: in-place mutate
function insert(bst::Union{TreeNode, Nothing}, num::Int)::Union{TreeNode, Nothing}
	node = TreeNode(val=num)
	if isnothing(bst) return node end  # 若树为空，则初始化根节点
	cur, pre = bst, nothing  # 循环查找，越过叶节点后跳出
	while !isnothing(cur)
		if cur.val == num return nothing end  # 找到重复节点，直接返回
		pre = cur
		if cur.val < num  # 插入位置在 cur 的右子树中
			cur = cur.right
		else  # 插入位置在 cur 的左子树中
			cur = cur.left
		end
	end
	# 插入节点
	if pre.val < num
		pre.right = node
	else
		pre.left = node
	end
	return bst
end


"""删除节点"""  # TODO: in-place mutate
function remove(bst::Union{TreeNode, Nothing}, num::Int)::Union{TreeNode, Nothing}
	if isnothing(bst) return nothing end  # 若树为空，直接提前返回
	cur, pre = bst, nothing  # 循环查找，越过叶节点后跳出
	while !isnothing(cur)
		if cur.val == num break end  # 找到重复节点，直接返回
		pre = cur
		if cur.val < num  # 插入位置在 cur 的右子树中
			cur = cur.right
		else  # 插入位置在 cur 的左子树中
			cur = cur.left
		end
	end
	if isnothing(cur) return nothing end  # 若无待删除节点，则直接返回

	if isnothing(cur.left) || isnothing(cur.right)  # 子节点数量 = 0 or 1
		child = !isnothing(cur.left) ? cur.left : cur.right  # 当子节点数量 = 0 / 1 时， child = null / 该子节点
		if cur ≠ bst  # 删除节点 cur
			if pre.left == cur
				pre.left = child
			else
				pre.right = child
			end
		else
			return child  # 若删除节点为根节点，则重新指定根节点
		end
	else  # 子节点数量 = 2
		tmp = cur.right  # 获取中序遍历中 cur 的下一个节点
		while !isnothing(tmp.left)
			tmp = tmp.left
		end
		bst = remove(bst, tmp.val)  # 递归删除节点 tmp
		cur.val = tmp.val  # 用 tmp 覆盖 cur
	end
	return bst
end


if abspath(PROGRAM_FILE) == @__FILE__
	bst = TreeNode(val=8)  # 初始化二叉搜索树
	for num ∈ [4, 12, 2, 6, 10, 14, 1, 3, 5, 7, 9, 11, 13, 15]
		global bst = insert(bst, num)
	end
	println("\n初始化的二叉树为\n")
	print_tree(bst)

	# 查找节点
	node = search(bst, 7)
	println("\n查找到的节点对象为: ", node, " ，节点值 = ", node.val)

	# 插入节点
	bst = insert(bst, 16)
	println("\n插入节点 16 后，二叉树为\n")
	print_tree(bst)

	# 删除节点
	for num ∈ [1, 2, 4]
		global bst = remove(bst, num)
		println("\n删除节点 $num 后，二叉树为\n")
		print_tree(bst)
	end
end
