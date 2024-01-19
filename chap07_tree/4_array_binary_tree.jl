#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

include("../utils/utils.jl")
import .utils: list_to_tree, print_tree


"""数组表示下的二叉树类"""
struct ArrayBinaryTree
	tree::Vector{Union{Integer, Nothing}}
end

"""列表容量"""
size(abt::ArrayBinaryTree)::Integer = length(abt.tree)

"""获取索引为 i 节点的值"""
function val(abt::ArrayBinaryTree, i::Integer)::Union{Integer, Nothing}
	if i < 1 || i > size(abt)
		return nothing
	else
		return abt.tree[i]
	end
end

"""获取索引为 i 节点的左子节点的索引"""
_left(i::Integer)::Integer = 2i + 1

"""获取索引为 i 节点的右子节点的索引"""
_right(i::Integer)::Integer = 2i + 2

"""获取索引为 i 节点的父节点的索引"""
_parent(i::Integer)::Integer = (i - 1) ÷ 2

"""层序遍历"""
function level_order(abt::ArrayBinaryTree)::Vector{Int}
	res = Int[]
	for i ∈ 1:size(abt)
		val_tmp = val(abt, i)
		if !isnothing(val_tmp)
			push!(res, val_tmp)
		end
	end
	return res
end

"""深度优先遍历"""
function _dfs!(res::Vector{Int}, abt::ArrayBinaryTree, i::Int; order::String)::Nothing
	val_tmp = val(abt, i)
	if !isnothing(val_tmp)
		if order == "pre"; push!(res, val_tmp) end  # 前序遍历
		_dfs!(res, abt, _left(i); order=order)
		if order == "in"; push!(res, val_tmp) end  # 中序遍历
		_dfs!(res, abt, _right(i); order=order)
		if order == "post"; push!(res, val_tmp) end  # 后序遍历
	end
	return nothing
end

"""前序遍历"""
function pre_order(abt::ArrayBinaryTree)::Vector{Int}
	res = Int[]
	_dfs!(res, abt, 1; order="pre")
	return res
end

"""中序遍历"""
function in_order(abt::ArrayBinaryTree)::Vector{Int}
	res = Int[]
	_dfs!(res, abt, 1; order="in")
	return res
end

"""后序遍历"""
function post_order(abt::ArrayBinaryTree)::Vector{Int}
	res = Int[]
	_dfs!(res, abt, 1; order="post")
	return res
end


if abspath(PROGRAM_FILE) == @__FILE__
	# 初始化二叉树
	const arr = [1, 2, 3, 4, nothing, 6, 7, 8, 9, nothing, nothing, 12, nothing, nothing, 15]
	# 这里借助了一个从数组直接生成二叉树的函数
	const root = list_to_tree(arr)
	println("\n初始化二叉树\n\n二叉树的数组表示：\n", arr)
	println("二叉树的链表表示：")
	print_tree(root)

	const abt = ArrayBinaryTree(arr)  # 数组表示下的二叉树类
	const i = 1  # 访问节点
	const l, r, p = _left(i), _right(i), _parent(i)
	println("\n当前节点的索引为 $i ，值为 ", val(abt, i))
	println("其左子节点的索引为 $l ，值为 ", val(abt, l))
	println("其右子节点的索引为 $r ，值为 ", val(abt, r))
	println("其父节点的索引为 $p ，值为 ", val(abt, p))

	# 遍历树
	println("\n层序遍历为：", level_order(abt))
	println("前序遍历为：", pre_order(abt))
	println("中序遍历为：", in_order(abt))
	println("后序遍历为：", post_order(abt))
end
