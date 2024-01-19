#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

"""移动一个圆盘"""
function _move!(src::Vector{Int}, tar::Vector{Int})::Nothing
	pan = pop!(src)  # 从 src 顶部拿出一个圆盘
	push!(tar, pan)  # 将圆盘放入 tar 顶部
	return nothing
end


"""求解汉诺塔问题 f(i)"""
function _dfs!(i::Int, src::Vector{Int}, buf::Vector{Int}, tar::Vector{Int})::Nothing
	if i == 1  # 若 src 只剩下一个圆盘，则直接将其移到 tar
		_move!(src, tar)
	else
		_dfs!(i - 1, src, tar, buf)  # 子问题 f(i-1) ：将 src 顶部 i-1 个圆盘借助 tar 移到 buf
		_move!(src, tar)             # 子问题 f(1) ：将 src 剩余一个圆盘移到 tar
		_dfs!(i - 1, buf, src, tar)  # 子问题 f(i-1) ：将 buf 顶部 i-1 个圆盘借助 src 移到 tar
	end
	return nothing
end


"""求解汉诺塔问题"""
function solve_hanota!(A::Vector{Int}, B::Vector{Int}, C::Vector{Int})::Nothing
	_dfs!(length(A), A, B, C)  # 将 A 顶部 n 个圆盘借助 B 移到 C
	return nothing
end


if abspath(PROGRAM_FILE) == @__FILE__
	const A, B, C = [5, 4, 3, 2, 1], Int[], Int[]  # 列表尾部是柱子顶部
	println("初始状态下：")
	println("A = ", A); println("B = ", B); println("C = ", C)

	solve_hanota!(A, B, C)
	println("圆盘移动完成后：")
	println("A = ", A); println("B = ", B); println("C = ", C)
end
