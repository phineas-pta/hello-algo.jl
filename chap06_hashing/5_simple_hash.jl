#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

"""加法哈希"""
function add_hash(key::String)::Int
	hash = sum([Int(c) for c ∈ key])
	modulus = 1000000007
	return hash % modulus
end

"""乘法哈希"""
function mul_hash(key::String)::Int
	hash = 0
	modulus = 1000000007
	for c ∈ key
		hash = 31 * hash + Int(c)
	end
	return hash % modulus
end

"""异或哈希"""
function xor_hash(key::String)::Int
	hash = 0
	modulus = 1000000007
	for c ∈ key
		hash ^= Int(c)
	end
	return hash % modulus
end

"""旋转哈希"""
function rot_hash(key::String)::Int
	hash = 0
	modulus = 1000000007
	for c ∈ key
		hash = (hash << 4) ^ (hash >> 28) ^ Int(c)
	end
	return hash % modulus
end


if abspath(PROGRAM_FILE) == @__FILE__
	const key = "Hello 算法"
	println("加法哈希值为 ", add_hash(key))
	println("乘法哈希值为 ", mul_hash(key))
	println("异或哈希值为 ", xor_hash(key))
	println("旋转哈希值为 ", rot_hash(key))
end
