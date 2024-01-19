#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

import Random: shuffle


"""生成一个数组，元素为: 1, 2, ..., n ，顺序被打乱"""
function random_numbers(n::Int)::Vector{Int}
	return shuffle(collect(1:n))  # 随机打乱数组元素
end


"""查找数组 nums 中数字 1 所在索引"""
function find_one(nums::Vector{Int})::Int
	for i ∈ eachindex(nums)
		if nums[i] == 1
			return i
		end
	end
	return -1
end


if abspath(PROGRAM_FILE) == @__FILE__
	const n = 100
	for i ∈ 1:10
		nums = random_numbers(n)
		index = find_one(nums)
		println("\n数组 [1, 2, …, n] 被打乱后 = ", nums)
		println("数字 1 的索引为 ", index)
	end
end
