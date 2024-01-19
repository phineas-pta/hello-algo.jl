#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

include("../utils/utils.jl")
import .utils: Pair


"""开放寻址哈希表"""
mutable struct HashMapOpenAddressing
	size::Int  # 键值对数量
	capacity::Int  # 哈希表容量
	load_thres::Real  # 触发扩容的负载因子阈值
	extend_ratio::Int  # 扩容倍数
	buckets::Vector{Union{Pair, Nothing}}  # 桶数组
	const TOMBSTONE::Pair  # 删除标记
	HashMapOpenAddressing() = new(0, 4, 2. / 3., 2, fill(nothing, 4), Pair(-1, "-1"))  # 构造方法
end

"""哈希函数"""
_hash_func(hashmap::HashMapOpenAddressing, key::Int)::Int = key % hashmap.capacity + 1  # 1-based index

"""负载因子"""
_load_factor(hashmap::HashMapOpenAddressing)::Real = hashmap.size / hashmap.capacity

"""搜索 key 对应的桶索引"""
function _find_bucket!(hashmap::HashMapOpenAddressing, key::Int)::Int
	first_tombstone = 0
	index = _hash_func(hashmap, key)
	bucket = hashmap.buckets[index]
	while !isnothing(bucket)  # 线性探测，当遇到空桶时跳出
		if bucket.key == key  # 若遇到 key ，返回对应的桶索引
			if first_tombstone ≠ 0  # 若之前遇到了删除标记，则将键值对移动至该索引处
				hashmap.buckets[first_tombstone] = bucket
				hashmap.buckets[index] = hashmap.TOMBSTONE
				return first_tombstone  # 返回移动后的桶索引
			else
				return index  # 返回桶索引
			end
		end
		if first_tombstone == 0 && bucket == hashmap.TOMBSTONE  # 记录遇到的首个删除标记
			first_tombstone = index
		end
		index = (index + 1) % hashmap.capacity + 1  # 计算桶索引，越过尾部则返回头部
		bucket = hashmap.buckets[index]
	end
	return first_tombstone == 0 ? index : first_tombstone  # 若 key 不存在，则返回添加点的索引
end

"""查询操作"""
function get(hashmap::HashMapOpenAddressing, key::Int)::Union{String, Nothing}
	index = _find_bucket!(hashmap, key)  # 搜索 key 对应的桶索引
	bucket = hashmap.buckets[index]
	if isnothing(bucket) || bucket == hashmap.TOMBSTONE
		return nothing  # 若键值对不存在，则返回 None
	else
		return bucket.val  # 若找到键值对，则返回对应 val
	end
end

"""添加操作"""
function put!(hashmap::HashMapOpenAddressing, key::Int, val::String)::Nothing
	if _load_factor(hashmap) > hashmap.load_thres
		extend!(hashmap)  # 当负载因子超过阈值时，执行扩容
	end
	index = _find_bucket!(hashmap, key)  # 搜索 key 对应的桶索引
	bucket = hashmap.buckets[index]
	if !isnothing(bucket) && bucket ≠ hashmap.TOMBSTONE
		hashmap.buckets[index].val = val  # 若找到键值对，则覆盖 val 并返回
	else  # 若键值对不存在，则添加该键值对
		hashmap.buckets[index] = Pair(key, val)
		hashmap.size += 1
	end
	return nothing
end

"""删除操作"""
function remove!(hashmap::HashMapOpenAddressing, key::Int)::Nothing
	index = _find_bucket!(hashmap, key)  # 搜索 key 对应的桶索引
	bucket = hashmap.buckets[index]
	if !isnothing(bucket) && bucket ≠ hashmap.TOMBSTONE  # 若找到键值对，则用删除标记覆盖它
		hashmap.buckets[index] = hashmap.TOMBSTONE
		hashmap.size -= 1
	end
	return nothing
end

"""扩容哈希表"""
function extend!(hashmap::HashMapOpenAddressing)::Nothing
	buckets_tmp = hashmap.buckets  # 暂存原哈希表
	hashmap.capacity *= hashmap.extend_ratio  # 初始化扩容后的新哈希表
	hashmap.buckets = fill(nothing, hashmap.capacity)
	hashmap.size = 0
	for pair ∈ buckets_tmp  # 将键值对从原哈希表搬运至新哈希表
		if !isnothing(pair) && pair ≠ hashmap.TOMBSTONE
			put!(hashmap, pair.key, pair.val)
		end
	end
	return nothing
end

"""打印哈希表"""
function print(hashmap::HashMapOpenAddressing)::Nothing
	for pair ∈ hashmap.buckets
		if isnothing(pair)
			println("None")
		elseif pair == hashmap.TOMBSTONE
			println("TOMBSTONE")
		else
			println(pair.key, " → ", pair.val)
		end
	end
	return nothing
end


if abspath(PROGRAM_FILE) == @__FILE__
	const hashmap = HashMapOpenAddressing()  # 初始化哈希表

	# 添加操作
	put!(hashmap, 12836, "小哈"); put!(hashmap, 15937, "小啰"); put!(hashmap, 16750, "小算"); put!(hashmap, 13276, "小法"); put!(hashmap, 10583, "小鸭");  # 在哈希表中添加键值对
	println("\n添加完成后，哈希表为\nKey → Value")
	print(hashmap)

	# 查询操作
	name = get(hashmap, 13276)  # 向哈希表中输入键 key ，得到值 val
	println("\n输入学号 13276 ，查询到姓名 ", name)

	# 删除操作
	remove!(hashmap, 16750)  # 在哈希表中删除键值对 (key, val)
	println("\n删除 16750 后，哈希表为\nKey → Value")
	print(hashmap)
end
