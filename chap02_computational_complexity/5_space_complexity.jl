#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

include("../utils/utils.jl")
import .utils: ListNode, TreeNode, print_tree

"""函数"""
function const_func()::Int
	return 0  # 执行某些操作
end


"""常数阶"""
function constant(n::Int)::Nothing
	# 常量、变量、对象占用 𝒪(1) 空间
	a = 0
	nums = fill(0, 10000)
	node = ListNode(val=0)
	for _ ∈ 1:n  # 循环中的变量占用 𝒪(1) 空间
		c = 0
	end
	for _ ∈ 1:n  # 循环中的函数占用 𝒪(1) 空间
		const_func()
	end
	return nothing
end


"""线性阶"""
function linear(n::Int)::Nothing
	nums = fill(0, n)  # 长度为 n 的列表占用 𝒪(n) 空间
	hmap = Dict{Int, String}()  # 长度为 n 的哈希表占用 𝒪(n) 空间
	for i ∈ 1:n
		hmap[i] = string(i)
	end
	return nothing
end


"""线性阶（递归实现）"""
function linear_recur(n::Int)::Nothing
	println("递归 n = ", n)
	if n ≠ 1
		linear_recur(n - 1)
	end
	return nothing
end


"""平方阶"""
function quadratic(n::Int)::Nothing
	num_matrix = [fill(0, n) for _ ∈ 1:n]  # 二维列表占用 𝒪(n²) 空间
	return nothing
end


"""平方阶（递归实现）"""
function quadratic_recur(n::Int)::Int
	if n ≤ 0
		return 0
	else
		nums = fill(0, n)  # 数组 nums 长度为 n, n-1, …, 2, 1
		return quadratic_recur(n - 1)
	end
end


"""指数阶（建立满二叉树）"""
function build_tree(n::Int)::Union{TreeNode, Nothing}
	if n == 0
		return nothing
	else
		return TreeNode(
			val=0,
			left=build_tree(n - 1),
			right=build_tree(n - 1)
		)
	end
end


if abspath(PROGRAM_FILE) == @__FILE__
	const n = 5
	constant(n)  # 常数阶
	linear(n)  # 线性阶
	linear_recur(n)
	quadratic(n)  # 平方阶
	quadratic_recur(n)
	print_tree(build_tree(n))  # 指数阶
end
