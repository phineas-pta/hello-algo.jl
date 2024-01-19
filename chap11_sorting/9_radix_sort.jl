#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

"""获取元素 num 的第 k 位，其中 exp = 10^(k-1)"""
function _digit(num::Int, exp::Int)::Int
	return (num ÷ exp) % 10  # 传入 exp 而非 k 可以避免在此重复执行昂贵的次方计算
end


"""计数排序（根据 nums 第 k 位排序）"""
function _counting_sort_digit!(nums::Vector{Int}, exp::Int)::Nothing
	counter = fill(0, 10)  # 十进制的位范围为 0~9 ，因此需要长度为 10 的桶数组
	n = length(nums)
	for i ∈ 1:n  # 统计 0~9 各数字的出现次数
		d = _digit(nums[i], exp)  # 获取 nums[i] 第 k 位，记为 d
		counter[d+1] += 1  # 统计数字 d 的出现次数
	end
	for i ∈ 1:9  # 求前缀和，将“出现个数”转换为“数组索引”
		counter[i+1] += counter[i]
	end
	res = fill(0, n)  # 倒序遍历，根据桶内统计结果，将各元素填入 res
	for i ∈ n:-1:1
		d = _digit(nums[i], exp)
		j = counter[d+1]  # 获取 d 在数组中的索引 j
		res[j] = nums[i]  # 将当前元素填入索引 j
		counter[d+1] -= 1  # 将 d 的数量减 1
	end
	for i ∈ 1:n  # 使用结果覆盖原数组 nums
		nums[i] = res[i]
	end
	return nothing
end


"""基数排序"""
function radix_sort!(nums::Vector{Int})::Nothing
	m = maximum(nums)  # 获取数组的最大元素，用于判断最大位数
	exp = 1  # 按照从低位到高位的顺序遍历
	while exp ≤ m
		# 对数组元素的第 k 位执行计数排序
		# k = 1 -> exp = 1
		# k = 2 -> exp = 10
		# 即 exp = 10^(k-1)
		_counting_sort_digit!(nums, exp)
		exp *= 10
	end
	return nothing
end


if abspath(PROGRAM_FILE) == @__FILE__
	const nums = [
		10546151, 35663510, 42865989, 34862445, 81883077,
		88906420, 72429244, 30524779, 82060337, 63832996,
	]
	radix_sort!(nums)
	println("基数排序完成后 nums = ", nums)
end
