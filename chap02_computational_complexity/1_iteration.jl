#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

"""for 循环"""
function for_loop(n::Int)::Int
	res = 0
	for i ∈ 1:n  # 循环求和 1, 2, …, n-1, n
		res += i
	end
	return res
end


"""while 循环"""
function while_loop(n::Int)::Int
	res = 0
	i = 1  # 初始化条件变量
	while i ≤ n
		res += i
		i += 1  # 更新条件变量
	end
	return res
end


"""while 循环（两次更新）"""
function while_loop_ii(n::Int)::Int
	res = 0
	i = 1
	while i ≤ n
		res += i
		i += 1
		i *= 2
	end
	return res
end


"""双层 for 循环"""
function nested_for_loop(n::Int)::String
	res = ""
	for i ∈ 1:n, j ∈ 1:n
		res *= "($i, $j), "
	end
	return res
end


if abspath(PROGRAM_FILE) == @__FILE__
	const n = 5
	println("\nfor 循环的求和结果 res = ", for_loop(n))
	println("\nwhile 循环的求和结果 res = ", while_loop(n))
	println("\nwhile 循环（两次更新）求和结果 res = ", while_loop_ii(n))
	println("\n双层 for 循环的遍历结果 ", nested_for_loop(n))
end
