#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

"""回溯算法：子集和 I"""
function _backtrack!(state::Vector{Int}, target::Int, choices::Vector{Int}, start::Int, res::Vector{Vector{Int}})::Nothing
	if target == 0  # 子集和等于 target 时，记录解
		push!(res, copy(state))
	else  # 遍历所有选择
		for i ∈ start:length(choices)  # 剪枝二：从 start 开始遍历，避免生成重复子集
			# 剪枝一：若子集和超过 target ，则直接结束循环
			tmp = target - choices[i]
			if tmp < 0 break end  # 这是因为数组已排序，后边元素更大，子集和一定超过 target
			push!(state, choices[i])  # 尝试：做出选择，更新 target, start
			_backtrack!(state, tmp, choices, i, res)  # 进行下一轮选择
			pop!(state)  # 回退：撤销选择，恢复到之前的状态
		end
	end
	return nothing
end


"""求解子集和 I"""
function subset_sum_i(nums::Vector{Int}, target::Int)::Vector{Vector{Int}}
	state = Int[]  # 状态（子集）
	start = 1  # 遍历起始点
	res = Vector{Vector{Int}}()  # 结果列表（子集列表）
	_backtrack!(state, target, sort(nums), start, res)
	return res
end


if abspath(PROGRAM_FILE) == @__FILE__
	const nums = [3, 4, 5]
	const target = 9

	println("输入数组 nums = $nums, target = $target")
	println("所有和等于 $target 的子集 res = ", subset_sum_i(nums, target))
end
