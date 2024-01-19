#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

"""方法一：暴力枚举"""
function two_sum_brute_force(nums::Vector{Int}, target::Int)::Vector{Int}
	N = length(nums)
	for i ∈ 1:(N-1), j ∈ (i+1):N  # 两层循环，时间复杂度为 𝒪(n²)
		if nums[i] + nums[j] == target return [i, j] end
	end
	return Int[]
end


"""方法二：辅助哈希表"""
function two_sum_hash_table(nums::Vector{Int}, target::Int)::Vector{Int}
	dic = Dict{Int, Int}()  # 辅助哈希表，空间复杂度为 𝒪(n)
	for i ∈ eachindex(nums)  # 单层循环，时间复杂度为 𝒪(n)
		tmp = target - nums[i]
		if haskey(dic, tmp)
			return [dic[tmp], i]
		else
			dic[nums[i]] = i
		end
	end
	return Int[]
end


if abspath(PROGRAM_FILE) == @__FILE__
	const nums = [2, 7, 11, 15]
	const target = 13
	println("方法一 res = ", two_sum_brute_force(nums, target))
	println("方法二 res = ", two_sum_hash_table( nums, target))
end
