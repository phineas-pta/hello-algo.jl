#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

"""回溯算法：全排列 I"""
function _backtrack!(state::Vector{Int}, choices::Vector{Int}, selected::Vector{Bool}, res::Vector{Vector{Int}})::Nothing
	if length(state) == length(choices)  # 当状态长度等于元素数量时，记录解
		push!(res, copy(state))
	else
		for (i, choice) ∈ enumerate(choices)  # 遍历所有选择
			if !selected[i]  # 剪枝：不允许重复选择元素
				selected[i] = true  # 尝试：做出选择，更新状态
				push!(state, choice)
				_backtrack!(state, choices, selected, res)  # 进行下一轮选择
				selected[i] = false  # 回退：撤销选择，恢复到之前的状态
				pop!(state)
			end
		end
	end
	return nothing
end


"""全排列 I"""
function permutations_i(nums::Vector{Int})::Vector{Vector{Int}}
	res = Vector{Vector{Int}}()
	_backtrack!(Int[], nums, fill(false, length(nums)), res)
	return res
end


if abspath(PROGRAM_FILE) == @__FILE__
	const nums = [1, 2, 3]
	println("输入数组 nums = ", nums)
	println("所有排列 res = ", permutations_i(nums))
end
