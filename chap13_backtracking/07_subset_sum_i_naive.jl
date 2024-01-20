#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

"""回溯算法：子集和 I"""
function _backtrack!(state::Vector{Int}, target::Int, total::Int, choices::Vector{Int}, res::Vector{Vector{Int}})::Nothing
	if total == target  # 子集和等于 target 时，记录解
		push!(res, copy(state))
	else
		for choice ∈ choices  # 遍历所有选择
			tmp = total + choice
			if tmp ≤ target  # 剪枝：若子集和超过 target ，则跳过该选择
				push!(state, choice)  # 尝试：做出选择，更新元素和 total
				_backtrack!(state, target, tmp, choices, res)  # 进行下一轮选择
				pop!(state)  # 回退：撤销选择，恢复到之前的状态
			end
		end
	end
	return nothing
end


"""求解子集和 I（包含重复子集）"""
function subset_sum_i_naive(nums::Vector{Int}, target::Int)::Vector{Vector{Int}}
	state = Int[]  # 状态（子集）
	total = 0  # 子集和
	res = Vector{Vector{Int}}()  # 结果列表（子集列表）
	_backtrack!(state, target, total, nums, res)
	return res
end


if abspath(PROGRAM_FILE) == @__FILE__
	const nums = [3, 4, 5]
	const target = 9

	println("输入数组 nums = $nums, target = $target")
	println("所有和等于 $target 的子集 res = ", subset_sum_i_naive(nums, target))
	println("请注意，该方法输出的结果包含重复集合")
end
