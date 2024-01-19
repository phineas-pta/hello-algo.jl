#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

"""常数阶"""
function constant(n::Int)::Int
	count = 0
	size = 100000
	for _ ∈ 1:size
		count += 1
	end
	return count
end


"""线性阶"""
function linear(n::Int)::Int
	count = 0
	for _ ∈ 1:n
		count += 1
	end
	return count
end


"""线性阶（遍历数组）"""
function array_traversal(nums::Vector{Int})::Int
	count = 0
	for _ ∈ nums  # 循环次数与数组长度成正比
		count += 1
	end
	return count
end


"""平方阶"""
function quadratic(n::Int)::Int
	count = 0
	for i ∈ 1:n, j ∈ 1:n  # 循环次数与数组长度成平方关系
		count += 1
	end
	return count
end


"""平方阶（冒泡排序）"""
function bubble_sort(nums::Vector{Int})::Int
	count = 0  # 计数器
	for i ∈ length(nums):-1:1, j ∈ 1:i  # 外循环：未排序区间为 [1, i]
		if nums[j] > nums[j + 1]  # 交换 nums[j] 与 nums[j + 1]
			nums[j], nums[j + 1] = nums[j + 1], nums[j]
			count += 3  # 元素交换包含 3 个单元操作
		end
	end
	return count
end


"""指数阶（循环实现）"""
function exponential(n::Int)::Int
	count = 0
	base = 1
	for i ∈ 1:n  # 细胞每轮一分为二，形成数列 1, 2, 4, …, 2ⁿ⁻¹
		for j ∈ 1:base
			count += 1
		end
		base *= 2
	end
	return count  # = 1 + 2 + 4 + … + 2ⁿ⁻¹ = 2ⁿ - 1
end


"""指数阶（递归实现）"""
function exp_recur(n::Int)::Int
	if n == 1
		return 1
	else
		return exp_recur(n - 1) + exp_recur(n - 1) + 1
	end
end


"""对数阶（循环实现）"""
function logarithmic(n::Real)::Int
	count = 0
	while n > 1
		n /= 2
		count += 1
	end
	return count
end


"""对数阶（递归实现）"""
function log_recur(n::Real)::Int
	if n ≤ 1
		return 0
	else
		return log_recur(n / 2) + 1
	end
end


"""线性对数阶"""
function linear_log_recur(n::Real)::Int
	if n ≤ 1
		return 1
	else
		count = linear_log_recur(n / 2) + linear_log_recur(n / 2)
		for _ ∈ 1:n
			count += 1
		end
		return count
	end
end


"""阶乘阶（递归实现）"""
function factorial_recur(n::Int)::Int
	if n == 0
		return 1
	else
		count = 0
		for _ ∈ 1:n  # 从 1 个分裂出 n 个
			count += factorial_recur(n - 1)
		end
		return count
	end
end


if abspath(PROGRAM_FILE) == @__FILE__
	const n = 8  # 可以修改 n 运行，体会一下各种复杂度的操作数量变化趋势
	println("输入数据大小 n = ", n)

	println("常数阶的操作数量 = ", constant(n))

	println("线性阶的操作数量 = ", linear(n))
	println("线性阶（遍历数组）的操作数量 = ", array_traversal(fill(0, n)))

	println("平方阶的操作数量 = ", quadratic(n))
	println("平方阶（冒泡排序）的操作数量 = ", bubble_sort(collect(n:1)))

	println("指数阶（循环实现）的操作数量 = ", exponential(n))
	println("指数阶（递归实现）的操作数量 = ", exp_recur(n))

	println("对数阶（循环实现）的操作数量 = ", logarithmic(n))
	println("对数阶（递归实现）的操作数量 = ", log_recur(n))

	println("线性对数阶（递归实现）的操作数量 = ", linear_log_recur(n))

	println("阶乘阶（递归实现）的操作数量 = ", factorial_recur(n))
end
