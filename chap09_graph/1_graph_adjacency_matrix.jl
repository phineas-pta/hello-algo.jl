#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

include("../utils/utils.jl")
import .utils: print_matrix


"""基于邻接矩阵实现的无向图类"""
struct GraphAdjMat
	vertices::Vector{Int}  # 顶点列表，元素代表“顶点值”，索引代表“顶点索引”
	adj_mat::Vector{Vector{Int}}  # 邻接矩阵，行列索引对应“顶点索引”
	# use vector of vectors instead of matrix
	# coz a lot of operations here are row-wise
	# meanwhile julia matrix is more efficient column-wise

	"""构造方法"""
	function GraphAdjMat(vertices::Vector{Int}, edges::Vector{Vector{Int}})
		graph = new(Int[], Vector{Vector{Int}}())
		for val ∈ vertices  # 添加顶点
			add_vertex!(graph, val)
		end
		for e ∈ edges  # 添加边
			add_edge!(graph, e[1], e[2])  # 请注意，edges 元素代表顶点索引，即对应 vertices 元素索引
		end
		return graph
	end
end

"""获取顶点数量"""
size(graph::GraphAdjMat)::Int = length(graph.vertices)

"""添加顶点"""
function add_vertex!(graph::GraphAdjMat, val::Int)::Nothing
	push!(graph.vertices, val)  # 向顶点列表中添加新顶点的值
	new_row = fill(0, size(graph))
	push!(graph.adj_mat, new_row)  # 在邻接矩阵中添加一行
	for row ∈ graph.adj_mat
		push!(row, 0)  # 在邻接矩阵中添加一列
	end
	return nothing
end

"""删除顶点"""
function remove_vertex!(graph::GraphAdjMat, index::Int)::Nothing
	if index > size(graph) error("索引越界") end
	popat!(graph.vertices, index)  # 在顶点列表中移除索引 index 的顶点
	popat!(graph.adj_mat,  index)  # 在邻接矩阵中删除索引 index 的行
	for row ∈ graph.adj_mat
		popat!(row, index)  # 在邻接矩阵中删除索引 index 的列
	end
	return nothing
end

"""添加边"""
function add_edge!(graph::GraphAdjMat, i::Int, j::Int)::Nothing
	n = size(graph)
	# 参数 i, j 对应 vertices 元素索引
	# 索引越界与相等处理
	if i < 1 || j < 1 || i > n || j > n || i == j error("索引越界") end
	# 在无向图中，邻接矩阵关于主对角线对称，即满足 (i, j) == (j, i)
	graph.adj_mat[i][j] = graph.adj_mat[j][i] = 1
	return nothing
end

"""删除边"""
function remove_edge!(graph::GraphAdjMat, i::Int, j::Int)::Nothing
	n = size(graph)
	if i < 1 || j < 1 || i > n || j > n || i == j error("索引越界") end
	graph.adj_mat[i][j] = graph.adj_mat[j][i] = 0
	return nothing
end

"""打印邻接矩阵"""
function print(graph::GraphAdjMat)::Nothing
	println("顶点列表 = ", graph.vertices)
	println("邻接矩阵 =")
	print_matrix(graph.adj_mat)
	return nothing
end


if abspath(PROGRAM_FILE) == @__FILE__
	# 初始化无向图
	# 请注意，edges 元素代表顶点索引，即对应 vertices 元素索引
	const graph = GraphAdjMat(
		[1, 3, 2, 5, 4],
		[[1, 2], [1, 4], [2, 3], [3, 4], [3, 5], [4, 5]]
	)
	println("\n初始化后，图为")
	print(graph)

	# 添加边
	# 顶点 1, 2 的索引分别为 0, 2
	add_edge!(graph, 1, 3)
	println("\n添加边 1-2 后，图为")
	print(graph)

	# 删除边
	# 顶点 1, 3 的索引分别为 0, 1
	remove_edge!(graph, 1, 2)
	println("\n删除边 1-3 后，图为")
	print(graph)

	# 添加顶点
	add_vertex!(graph, 6)
	println("\n添加顶点 6 后，图为")
	print(graph)

	# 删除顶点
	# 顶点 3 的索引为 1
	remove_vertex!(graph, 1)
	println("\n删除顶点 3 后，图为")
	print(graph)
end
