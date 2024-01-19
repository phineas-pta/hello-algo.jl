#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

include("../utils/utils.jl")
import .utils: ListNode


if abspath(PROGRAM_FILE) == @__FILE__
	const num = 3
	println("整数 $num 的哈希值为 ", hash(num))

	const bol = true
	println("布尔量 $bol 的哈希值为 ", hash(bol))

	const dec = 3.14159
	println("小数 $dec 的哈希值为 ", hash(dec))

	const str = "Hello 算法"
	println("字符串 $str 的哈希值为 ", hash(str))

	const tup = (12836, "小哈")
	println("元组 $tup 的哈希值为 ", hash(tup))

	const obj = ListNode(val=0)
	println("节点对象 $obj 的哈希值为 ", hash(obj))
end
