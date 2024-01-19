#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

include("../utils/utils.jl")
import .utils: print_dict


if abspath(PROGRAM_FILE) == @__FILE__
	const hmap = Dict{Int, String}()  # 初始化哈希表

	# 添加操作
	hmap[12836] = "小哈"; hmap[15937] = "小啰"; hmap[16750] = "小算"; hmap[13276] = "小法"; hmap[10583] = "小鸭"  # 在哈希表中添加键值对
	println("\n添加完成后，哈希表为\nKey → Value")
	print_dict(hmap)

	# 查询操作
	name = hmap[15937]  # 向哈希表中输入键 key ，得到值 value
	println("\n输入学号 15937 ，查询到姓名 ", name)

	# 删除操作
	pop!(hmap, 10583)  # 在哈希表中删除键值对 (key, value)
	println("\n删除 10583 后，哈希表为\nKey → Value")
	print_dict(hmap)

	# 遍历哈希表
	println("\n遍历键值对 Key→Value")
	for (key, value) ∈ hmap
		println(key, " → ", value)
	end

	println("\n单独遍历键 Key")
	for key ∈ keys(hmap)
		println(key)
	end

	println("\n单独遍历值 Value")
	for value ∈ values(hmap)
		println(value)
	end
end
