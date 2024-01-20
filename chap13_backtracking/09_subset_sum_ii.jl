#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

"""回溯算法：子集和 II"""
function _backtrack!(state::Vector{Int}, target::Int, choices::Vector{Int}, start::Int, res::Vector{Vector{Int}})::Nothing
	if target == 0  # 子集和等于 target 时，记录解
		push!(res, copy(state))
	else  # 遍历所有选择
		# 遍历所有选择
		# 剪枝二：从 start 开始遍历，避免生成重复子集
		# 剪枝三：从 start 开始遍历，避免重复选择同一元素
		for i ∈ start:length(choices)
			tmp = target - choices[i]
			# 剪枝一：若子集和超过 target ，则直接结束循环
			if tmp < 0 break end  # 这是因为数组已排序，后边元素更大，子集和一定超过 target
			if i ≤ start || choices[i] ≠ choices[i-1]  # 剪枝四：如果该元素与左边元素相等，说明该搜索分支重复，直接跳过
				push!(state, choices[i])  # 尝试：做出选择，更新 target, start
				_backtrack!(state, tmp, choices, i+1, res)  # 进行下一轮选择
				pop!(state)  # 回退：撤销选择，恢复到之前的状态
			end
		end
	end
	return nothing
end


"""求解子集和 II"""
function subset_sum_ii(nums::Vector{Int}, target::Int)::Vector{Vector{Int}}
	state = Int[]  # 状态（子集）
	start = 1  # 遍历起始点
	res = Vector{Vector{Int}}()  # 结果列表（子集列表）
	_backtrack!(state, target, sort(nums), start, res)
	return res
end


if abspath(PROGRAM_FILE) == @__FILE__
	const nums = [4, 4, 5]
	const target = 9

	println("输入数组 nums = $nums, target = $target")
	println("所有和等于 $target 的子集 res = ", subset_sum_ii(nums, target))
end
