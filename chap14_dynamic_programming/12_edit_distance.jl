#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

"""编辑距离：暴力搜索"""
function edit_distance_dfs(s::String, t::String, i::Int, j::Int)::Int
	ibis, jbis = i - 1, j - 1
	if i == 1 && j == 1  # 若 s 和 t 都为空，则返回 0
		return 0
	elseif i == 1  # 若 s 为空，则返回 t 长度
		return j
	elseif j == 1  # 若 t 为空，则返回 s 长度
		return i
	elseif s[ibis] == t[jbis]  # 若两字符相等，则直接跳过此两字符
		return edit_distance_dfs(s, t, ibis, jbis)
	else  # 最少编辑步数 = 插入、删除、替换这三种操作的最少编辑步数 + 1
		insert = edit_distance_dfs(s, t, i, jbis)
		delete = edit_distance_dfs(s, t, ibis, j)
		replace = edit_distance_dfs(s, t, ibis, jbis)
		return min(insert, delete, replace) + 1  # 返回最少编辑步数
	end
end


"""编辑距离：记忆化搜索"""
function edit_distance_dfs_mem(s::String, t::String, mem::Matrix{Int}, i::Int, j::Int)::Int
	ibis, jbis = i - 1, j - 1
	if i == 1 && j == 1  # 若 s 和 t 都为空，则返回 0
		return 0
	elseif i == 1  # 若 s 为空，则返回 t 长度
		return j
	elseif j == 1  # 若 t 为空，则返回 s 长度
		return i
	elseif mem[i, j] ≠ -1  # 若已有记录，则直接返回之
		return mem[i, j]
	elseif s[ibis] == t[jbis]  # 若两字符相等，则直接跳过此两字符
		return edit_distance_dfs_mem(s, t, mem, ibis, jbis)
	else  # 最少编辑步数 = 插入、删除、替换这三种操作的最少编辑步数 + 1
		insert = edit_distance_dfs_mem(s, t, mem, i, jbis)
		delete = edit_distance_dfs_mem(s, t, mem, ibis, j)
		replace = edit_distance_dfs_mem(s, t, mem, ibis, jbis)
		mem[i, j] = min(insert, delete, replace) + 1  # 记录并返回最少编辑步数
		return mem[i, j]
	end
end


"""编辑距离：动态规划"""
function edit_distance_dp(s::String, t::String)::Int
	n, m = length(s), length(t)
	dp = fill(0, (n, m))
	for i ∈ 2:n  # 状态转移：首行首列
		dp[i, begin] = i
	end
	for j ∈ 2:m  # 状态转移：首行首列
		dp[begin, j] = j
	end
	for i ∈ 2:n, j ∈ 2:m  # 状态转移：其余行和列
		ibis, jbis = i - 1, j - 1
		if s[ibis] == t[jbis]
			dp[i, j] = dp[ibis, jbis]  # 若两字符相等，则直接跳过此两字符
		else
			dp[i, j] = min(dp[i, jbis], dp[ibis, j], dp[ibis, jbis]) + 1  # 最少编辑步数 = 插入、删除、替换这三种操作的最少编辑步数 + 1
		end
	end
	return dp[n, m]
end


"""编辑距离：空间优化后的动态规划"""
function edit_distance_dp_comp(s::String, t::String)::Int
	n, m = length(s), length(t)
	dp = fill(0, m)
	for j ∈ 2:m  # 状态转移：首行
		dp[j] = j
	end
	for i ∈ 2:n  # 状态转移：其余行
		leftup = dp[begin]  # 状态转移：首列
		dp[begin] += 1
		ibis = i - 1
		for j ∈ 2:m  # 状态转移：其余列
			jbis = j - 1
			if s[ibis] == t[jbis]
				dp[j] = dp[j]  # 若两字符相等，则直接跳过此两字符
			else
				dp[j] = min(dp[jbis], dp[j], leftup) + 1  # 最少编辑步数 = 插入、删除、替换这三种操作的最少编辑步数 + 1
			end
			leftup = dp[j]  # 更新为下一轮的 dp[i-1, j-1]
		end
	end
	return dp[m]
end


if abspath(PROGRAM_FILE) == @__FILE__
	const s, t = "bag", "pack"
	const n, m = length(s), length(t)

	res = edit_distance_dfs(s, t, n, m)  # 暴力搜索
	println("将 $s 更改为 $t 最少需要编辑 $res 步")

	res = edit_distance_dfs_mem(s, t, fill(-1, (n, m)), n, m)  # 记忆化搜索
	println("将 $s 更改为 $t 最少需要编辑 $res 步")

	res = edit_distance_dp(s, t)  # 动态规划
	println("将 $s 更改为 $t 最少需要编辑 $res 步")

	res = edit_distance_dp_comp(s, t)  # 空间优化后的动态规划
	println("将 $s 更改为 $t 最少需要编辑 $res 步")
end
