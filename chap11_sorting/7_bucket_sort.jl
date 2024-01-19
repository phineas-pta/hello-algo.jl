#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

"""桶排序"""
function bucket_sort!(nums::Vector{T})::Nothing where {T<:AbstractFloat}
	k = length(nums) ÷ 2  # 初始化 k = n/2 个桶，预期向每个桶分配 2 个元素
	buckets = fill(T[], k)
	for num ∈ nums  # 1. 将数组元素分配到各个桶中
		i = round(Int, num * k)  # 输入数据范围为 [0, 1)，使用 num * k 映射到索引范围 [1, k]
		push!(buckets[clamp(i, 1, k)], num)  # 将 num 添加进桶 i  # julia problem
	end
	for bucket ∈ buckets  # 2. 对各个桶执行排序
		sort!(bucket)  # 使用内置排序函数，也可以替换成其他排序算法
	end
	i = 1  # 3. 遍历桶合并结果
	for bucket ∈ buckets, num ∈ bucket
		if i > length(nums) break end  # julia problem
		nums[i] = num
		i += 1
	end
	return nothing
end


if abspath(PROGRAM_FILE) == @__FILE__  # 设输入数据为浮点数，范围为 [0, 1)
	const nums = [.49, .96, .82, .09, .57, .43, .91, .75, .15, .37]
	bucket_sort!(nums)
	println("桶排序完成后 nums = ", nums)
end
