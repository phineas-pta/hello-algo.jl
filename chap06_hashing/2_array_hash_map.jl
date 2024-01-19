#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

include("../utils/utils.jl")
import .utils: Pair


"""基于数组实现的哈希表"""
struct ArrayHashMap
	buckets::Vector{Union{Pair, Nothing}}
	ArrayHashMap() = new(fill(nothing, 100))   # 初始化数组，包含 100 个桶
end

"""哈希函数"""
_hash_func(hmap::ArrayHashMap, key::Int)::Int = key % 100 + 1  # 1-based index

"""查询操作"""
function get(hmap::ArrayHashMap, key::Int)::Union{String, Nothing}
	index = _hash_func(hmap, key)
	pair = hmap.buckets[index]
	if isnothing(pair)
		return nothing
	else
		return pair.val
	end
end

"""添加操作"""
function put!(hmap::ArrayHashMap, key::Int, val::String)::Nothing
	pair = Pair(key, val)
	index = _hash_func(hmap, key)
	hmap.buckets[index] = pair
	return nothing
end

"""删除操作"""
function remove!(hmap::ArrayHashMap, key::Int)::Nothing
	index = _hash_func(hmap, key)
	hmap.buckets[index] = nothing
	return nothing
end

"""获取所有键值对"""
function entry_set(hmap::ArrayHashMap)::Vector{Pair}
	result = Pair[]
	for pair ∈ hmap.buckets
		if !isnothing(pair)
			push!(result, pair)
		end
	end
	return result
end

"""获取所有键"""
function key_set(hmap::ArrayHashMap)::Vector{Int}
	result = Int[]
	for pair ∈ hmap.buckets
		if !isnothing(pair)
			push!(result, pair.key)
		end
	end
	return result
end

"""获取所有值"""
function value_set(hmap::ArrayHashMap)::Vector{String}
	result = String[]
	for pair ∈ hmap.buckets
		if !isnothing(pair)
			push!(result, pair.val)
		end
	end
	return result
end

"""打印哈希表"""
function print(hmap::ArrayHashMap)::Nothing
	for pair ∈ hmap.buckets
		if !isnothing(pair)
			println(pair.key, " → ", pair.val)
		end
	end
	return nothing
end


if abspath(PROGRAM_FILE) == @__FILE__
	const hmap = ArrayHashMap()  # 初始化哈希表

	# 添加操作
	put!(hmap, 12836, "小哈"); put!(hmap, 15937, "小啰"); put!(hmap, 16750, "小算"); put!(hmap, 13276, "小法"); put!(hmap, 10583, "小鸭");  # 在哈希表中添加键值对
	println("\n添加完成后，哈希表为\nKey → Value")
	print(hmap)

	# 查询操作
	name = get(hmap, 15937)  # 向哈希表中输入键 key ，得到值 value
	println("\n输入学号 15937 ，查询到姓名 ", name)

	# 删除操作
	remove!(hmap, 10583)
	println("\n删除 10583 后，哈希表为\nKey → Value")
	print(hmap)

	# 遍历哈希表
	println("\n遍历键值对 Key→Value")
	for pair ∈ entry_set(hmap)
		println(pair.key, " → ", pair.val)
	end

	println("\n单独遍历键 Key")
	for key ∈ key_set(hmap)
		println(key)
	end

	println("\n单独遍历值 Value")
	for value ∈ value_set(hmap)
		println(value)
	end
end
