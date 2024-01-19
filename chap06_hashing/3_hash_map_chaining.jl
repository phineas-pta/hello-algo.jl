#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

include("../utils/utils.jl")
import .utils: Pair


"""链式地址哈希表"""
mutable struct HashMapChaining
	size::Int  # 键值对数量
	capacity::Int  # 哈希表容量
	load_thres::Real  # 触发扩容的负载因子阈值
	extend_ratio::Int  # 扩容倍数
	buckets::Vector{Vector{Union{Pair, Nothing}}}  # 桶数组
	HashMapChaining() = new(0, 4, 2. / 3., 2, fill(Vector{Union{Pair, Nothing}}(), 4))  # 构造方法
end

"""哈希函数"""
_hash_func(hashmap::HashMapChaining, key::Int)::Int = key % hashmap.capacity + 1  # 1-based index

"""负载因子"""
_load_factor(hashmap::HashMapChaining)::Real = hashmap.size / hashmap.capacity

"""查询操作"""
function get(hashmap::HashMapChaining, key::Int)::Union{String, Nothing}
	index = _hash_func(hashmap, key)
	bucket = hashmap.buckets[index]
	for pair ∈ bucket  # 遍历桶，若找到 key ，则返回对应 val
		if pair.key == key
			return pair.val
		end
	end
	return nothing  # 若未找到 key ，则返回 None
end

"""添加操作"""
function put!(hashmap::HashMapChaining, key::Int, val::String)::Nothing
	if _load_factor(hashmap) > hashmap.load_thres
		extend!(hashmap)
	end
	index = _hash_func(hashmap, key)
	bucket = hashmap.buckets[index]
	for pair ∈ bucket  # 遍历桶，若找到 key ，则返回对应 val
		if pair.key == key
			pair.val = val
			return nothing
		end
	end
	pair = Pair(key, val)  # 若无该 key ，则将键值对添加至尾部
	push!(bucket, pair)
	hashmap.size += 1
	return nothing
end

"""删除操作"""
function remove!(hashmap::HashMapChaining, key::Int)::Nothing
	index = _hash_func(hashmap, key)
	bucket = hashmap.buckets[index]
	for i ∈ eachindex(bucket)  # 遍历桶，从中删除键值对
		if bucket[i].key == key
			deleteat!(bucket, i)
			hashmap.size -= 1
			break
		end
	end
	return nothing
end

"""扩容哈希表"""
function extend!(hashmap::HashMapChaining)::Nothing
	buckets = hashmap.buckets  # 暂存原哈希表
	hashmap.capacity *= hashmap.extend_ratio  # 初始化扩容后的新哈希表
	hashmap.buckets = fill(Vector{Union{Pair, Nothing}}(), hashmap.capacity)
	hashmap.size = 0
	for bucket ∈ buckets, pair ∈ bucket
		put!(hashmap, pair.key, pair.val)
	end
	return nothing
end

"""打印哈希表"""
function print(hashmap::HashMapChaining)::Nothing
	for bucket ∈ hashmap.buckets
		res = String[]
		for pair ∈ bucket
			push!(res, "$(pair.key) → $(pair.val)")
		end
		println(res)
	end
	return nothing
end


if abspath(PROGRAM_FILE) == @__FILE__
	const hashmap = HashMapChaining()  # 初始化哈希表

	# 添加操作
	put!(hashmap, 12836, "小哈"); put!(hashmap, 15937, "小啰"); put!(hashmap, 16750, "小算"); put!(hashmap, 13276, "小法"); put!(hashmap, 10583, "小鸭");  # 在哈希表中添加键值对
	println("\n添加完成后，哈希表为\nKey → Value")
	print(hashmap)

	# 查询操作
	name = get(hashmap, 13276)  # 向哈希表中输入键 key ，得到值 value
	println("\n输入学号 13276 ，查询到姓名 ", name)

	# 删除操作
	remove!(hashmap, 12836)  # 在哈希表中删除键值对 (key, value)
	println("\n删除 12836 后，哈希表为\nKey → Value")
	print(hashmap)
end
