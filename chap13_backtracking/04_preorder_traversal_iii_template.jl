#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

include("../utils/utils.jl")
import .utils: TreeNode, print_tree, list_to_tree


"""判断当前状态是否为解"""
function _is_solution(state::Vector{TreeNode})::Bool
	return length(state) > 0 && state[end].val == 7
end


"""记录解"""
function _record_solution!(state::Vector{TreeNode}, res::Vector{Vector{TreeNode}})::Nothing
	push!(res, copy(state))
	return nothing
end


"""判断在当前状态下，该选择是否合法"""
function _is_valid(choice::Union{TreeNode, Nothing})::Bool
	return !isnothing(choice) && choice.val ≠ 3
end


"""更新状态"""
function _make_choice!(state::Vector{TreeNode}, choice::TreeNode)::Nothing
	push!(state, choice)
	return nothing
end


"""恢复状态"""
function _undo_choice!(state::Vector{TreeNode})::Nothing
	pop!(state)
	return nothing
end


"""回溯算法：例题三"""
function backtrack!(state::Vector{TreeNode}, choices::Vector{Union{TreeNode, Nothing}}, res::Vector{Vector{TreeNode}})::Nothing
	if _is_solution(state)  # 检查是否为解
		_record_solution!(state, res)  # 记录解
	end
	for choice ∈ choices  # 遍历所有选择
		if _is_valid(choice)  # 剪枝：检查选择是否合法
			_make_choice!(state, choice)  # 尝试：做出选择，更新状态
			tmp = Vector{Union{TreeNode, Nothing}}([choice.left, choice.right])  # force type
			backtrack!(state, tmp, res)  # 进行下一轮选择
			_undo_choice!(state)  # 回退：撤销选择，恢复到之前的状态
		end
	end
	return nothing
end


if abspath(PROGRAM_FILE) == @__FILE__
	const arr = Vector{Union{Int, Nothing}}([1, 7, 3, 4, 5, 6, 7])  # force type
	const root = list_to_tree(arr)
	println("\n初始化二叉树")
	print_tree(root)

	res = Vector{Vector{TreeNode}}()  # 回溯算法
	backtrack!(TreeNode[], Vector{Union{TreeNode, Nothing}}([root]), res)

	println("\n输出所有根节点到节点 7 的路径，要求路径中不包含值为 3 的节点")
	for p ∈ res
		println([node.val for node ∈ p for p ∈ res])
	end
end
