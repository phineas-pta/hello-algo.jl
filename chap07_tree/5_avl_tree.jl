#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

include("../utils/utils.jl")
import .utils: TreeNode, print_tree


#=
"""AVL 树"""
struct AVLTree
	root::Union{TreeNode, Nothing}
end
=#


"""获取节点高度"""
function _height(node::Union{TreeNode, Nothing})::Int
	if !isnothing(node)  # 空节点高度为 -1 ，叶节点高度为 0
		return node.height
	else
		return -1
	end
end


"""更新节点高度"""
function _update_height!(node::Union{TreeNode, Nothing})::Nothing
	# 节点高度等于最高子树高度 + 1
	node.height = max(_height(node.left), _height(node.right)) + 1
	return nothing
end


"""获取平衡因子"""
function balance_factor(node::Union{TreeNode, Nothing})::Int
	if isnothing(node)  # 空节点平衡因子为 0
		return 0
	else  # 节点平衡因子 = 左子树高度 - 右子树高度
		return _height(node.left) - _height(node.right)
	end
end


"""右旋操作"""
function _right_rotate(node::Union{TreeNode, Nothing})::Union{TreeNode, Nothing}
	child = node.left
	grand_child = child.right
	child.right = node  # 以 child 为原点，将 node 向右旋转
	node.left = grand_child
	_update_height!(node)  # 更新节点高度
	_update_height!(child)
	return child  # 返回旋转后子树的根节点
end


"""左旋操作"""
function _left_rotate(node::Union{TreeNode, Nothing})::Union{TreeNode, Nothing}
	child = node.right
	grand_child = child.left
	child.left = node  # 以 child 为原点，将 node 向左旋转
	node.right = grand_child
	_update_height!(node)  # 更新节点高度
	_update_height!(child)
	return child  # 返回旋转后子树的根节点
end


"""执行旋转操作，使该子树重新恢复平衡"""
function _rotate(node::Union{TreeNode, Nothing})::Union{TreeNode, Nothing}
	bala_fact = balance_factor(node)  # 获取节点 node 的平衡因子
	if bala_fact > 1  # 左偏树
		if balance_factor(node.left) < 0
			node.left = _left_rotate(node.left)  # 先左旋后右旋
		end
		return _right_rotate(node)  # 右旋
	elseif bala_fact < -1  # 右偏树
		if balance_factor(node.right) > 0
			node.right = _right_rotate(node.right)  # 先右旋后左旋
		end
		return _left_rotate(node)  # 左旋
	else  # 平衡树，无须旋转，直接返回
		return node
	end
end


"""插入节点 🙵 递归插入节点（辅助方法）"""  # TODO: in-place mutate
function insert(node::Union{TreeNode, Nothing}, val::Int)::TreeNode
	if isnothing(node) return TreeNode(val=val) end
	# 1. 查找插入位置并插入节点
	if val < node.val
		node.left = insert(node.left, val)
	elseif val > node.val
		node.right = insert(node.right, val)
	else
		return node  # 重复节点不插入，直接返回
	end
	_update_height!(node)  # 更新节点高度
	return _rotate(node)  # 2. 执行旋转操作，使该子树重新恢复平衡
end


"""删除节点 🙵 递归删除节点（辅助方法）"""  # TODO: in-place mutate
function remove(node::Union{TreeNode, Nothing}, val::Int)::Union{TreeNode, Nothing}
	if isnothing(node) return nothing end
	# 1. 查找节点并删除
	if val < node.val
		node.left = remove(node.left, val)
	elseif val > node.val
		node.right = remove(node.right, val)
	else
		if isnothing(node.left) || isnothing(node.right)
			child = !isnothing(node.left) ? node.left : node.right
			if isnothing(child)  # 子节点数量 = 0 ，直接删除 node 并返回
				return nothing
			else  # 子节点数量 = 1 ，直接删除 node
				node = child
			end
		else
			temp = node.right  # 子节点数量 = 2 ，则将中序遍历的下个节点删除，并用该节点替换当前节点
			while !isnothing(temp.left)
				temp = temp.left
			end
			node.right = remove(node.right, temp.val)
			node.val = temp.val
		end
	end
	_update_height!(node)  # 更新节点高度
	return _rotate(node)  # 2. 执行旋转操作，使该子树重新恢复平衡
end


"""查找节点"""
function search(tree::Union{TreeNode, Nothing}, val::Int)::Union{TreeNode, Nothing}
	cur = tree
	while !isnothing(cur)  # 循环查找，越过叶节点后跳出
		if cur.val < val  # 目标节点在 cur 的右子树中
			cur = cur.right
		elseif cur.val > val  # 目标节点在 cur 的左子树中
			cur = cur.left
		else  # 找到目标节点，跳出循环
			break
		end
	end
	return cur  # 返回目标节点
end


if abspath(PROGRAM_FILE) == @__FILE__
	avl_tree = TreeNode(val=1)  # 初始化空 AVL 树

	# 插入节点
	# 请关注插入节点后，AVL 树是如何保持平衡的
	for val ∈ [2, 3, 4, 5, 8, 7, 9, 10, 6, 7]
		global avl_tree = insert(avl_tree, val)
		println("\n插入节点 $val 后，AVL 树为")
		print_tree(avl_tree)
	end

	# 删除节点
	# 请关注删除节点后，AVL 树是如何保持平衡的
	for val ∈ [8, 5, 4]
		global avl_tree = remove(avl_tree, val)
		println("\n删除节点 $val 后，AVL 树为")
		print_tree(avl_tree)
	end

	result_node = search(avl_tree, 7)
	println("\n查找到的节点对象为 ", result_node, " ，节点值 = ", result_node.val)
end
