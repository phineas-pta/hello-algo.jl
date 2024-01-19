#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

"""递归"""
function recur(n::Int)::Int
	if n == 1  # 终止条件
		return 1
	else  # 递：递归调用
		return n + recur(n - 1)  # 归：返回结果
	end
end


"""使用迭代模拟递归"""
function for_loop_recur(n::Int)::Int
	stack = Int[]
	res = 0
	for i ∈ n:-1:1  # 递：递归调用
		push!(stack, i)  # 通过“入栈操作”模拟“递”
	end
	while length(stack) > 0  # 归：返回结果
		res += pop!(stack)  # 通过“出栈操作”模拟“归”
	end
	return res
end


"""尾递归"""
function tail_recur(n::Int, res::Int)::Int
	if n == 0  # 终止条件
		return res
	else  # 尾递归调用
		return tail_recur(n - 1, res + n)
	end
end


"""斐波那契数列：递归"""
function fib(n::Int)::Int
	if n ∈ 1:2  # 终止条件 f(1) = 0, f(2) = 1
		return n - 1
	else  # 递归调用 f(n) = f(n-1) + f(n-2)
		return fib(n - 1) + fib(n - 2)  # 返回结果 f(n)
	end
end


if abspath(PROGRAM_FILE) == @__FILE__
	const n = 5
	println("\n递归函数的求和结果 res = ", recur(n))
	println("\n使用迭代模拟递归求和结果 res = ", for_loop_recur(n))
	println("\n尾递归函数的求和结果 res = ", tail_recur(n, 0))
	println("\n斐波那契数列的第 $n 项为 ", fib(n))
end
