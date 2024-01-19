#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

"""最大切分乘积：贪心"""
function max_product_cutting(n::Int)::Int
	if n <= 3 return 1 * (n - 1) end  # 当 n <= 3 时，必须切分出一个 1
	a, b = divrem(n, 3)  # 贪心地切分出 3 ，a 为 3 的个数，b 为余数
	if b == 1
		return 4 * 3^(a-1)  # 当余数为 1 时，将一对 1 * 3 转化为 2 * 2
	elseif b == 2
		return 2 * 3^a  # 当余数为 2 时，不做处理
	else
		return 3^a  # 当余数为 0 时，不做处理
	end
end


if abspath(PROGRAM_FILE) == @__FILE__
	println("最大切分乘积为 ", max_product_cutting(58))  # 贪心算法
end
