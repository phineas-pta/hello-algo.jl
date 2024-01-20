#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

"""最小路径和：暴力搜索"""
function min_path_sum_dfs(grid::Matrix{Int}, i::Int, j::Int)::Int
	if i == 1 && j == 1  # 若为左上角单元格，则终止搜索
		return grid[begin, begin]
	elseif i < 1 || j < 1  # 若行列索引越界，则返回 +∞ 代价
		return typemax(Int)
	else  # 计算从左上角到 (i-1, j) 和 (i, j-1) 的最小路径代价
		up = min_path_sum_dfs(grid, i - 1, j)
		left = min_path_sum_dfs(grid, i, j - 1)
		return min(left, up) + grid[i, j]  # 返回从左上角到 (i, j) 的最小路径代价
	end
end


"""最小路径和：记忆化搜索"""
function min_path_sum_dfs_mem(grid::Matrix{Int}, mem::Matrix{Int}, i::Int, j::Int)::Int
	if i == 1 && j == 1  # 若为左上角单元格，则终止搜索
		return grid[begin, begin]
	elseif i < 1 || j < 1  # 若行列索引越界，则返回 +∞ 代价
		return typemax(Int)
	else
		if mem[i, j] == -1  # 左边和上边单元格的最小路径代价
			up = min_path_sum_dfs_mem(grid, mem, i - 1, j)
			left = min_path_sum_dfs_mem(grid, mem, i, j - 1)
			mem[i, j] = min(left, up) + grid[i, j]  # 记录并返回左上角到 (i, j) 的最小路径代价
		end
		return mem[i, j]
	end
	return nothing
end


"""最小路径和：动态规划"""
function min_path_sum_dp(grid::Matrix{Int})::Int
	n, m = size(grid)
	dp = fill(0, (n, m))  # 初始化 dp 表
	dp[begin, begin] = grid[begin, begin]
	for j ∈ 2:m  # 状态转移：首行
		dp[begin, j] = dp[begin, j-1] + grid[begin, j]
	end
	for i ∈ 2:n  # 状态转移：首列
		dp[i, begin] = dp[i-1, begin] + grid[i, begin]
	end
	for i ∈ 2:n, j ∈ 2:m
		dp[i, j] = min(dp[i, j-1], dp[i-1, j]) + grid[i, j]
	end
	return dp[n, m]
end


"""最小路径和：空间优化后的动态规划"""
function min_path_sum_dp_comp(grid::Matrix{Int})::Int
	n, m = size(grid)
	dp = fill(0, m)  # 初始化 dp 表
	dp[begin] = grid[begin, begin]  # 状态转移：首行
	for j ∈ 2:m
		dp[j] = dp[j-1] + grid[begin, j]
	end
	for i ∈ 2:n
		dp[begin] = dp[begin] + grid[i, begin]  # 状态转移：首列
		for j ∈ 2:m  # 状态转移：其余列
			dp[j] = min(dp[j-1], dp[j]) + grid[i, j]
		end
	end
	return dp[m]
end


if abspath(PROGRAM_FILE) == @__FILE__
	const grid = [1 3 1 5; 2 2 4 2; 5 3 2 1; 4 3 5 2]
	n, m = size(grid)
	println("从左上角到右下角的做小路径和为 ", min_path_sum_dfs(grid, n, m))  # 暴力搜索
	println("从左上角到右下角的做小路径和为 ", min_path_sum_dfs_mem(grid, fill(-1, (n, m)), n, m))  # 记忆化搜索
	println("从左上角到右下角的做小路径和为 ", min_path_sum_dp(grid))  # 动态规划
	println("从左上角到右下角的做小路径和为 ", min_path_sum_dp_comp(grid))  # 空间优化后的动态规划
end
