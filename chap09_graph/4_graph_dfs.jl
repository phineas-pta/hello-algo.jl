#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

include("2_graph_adjacency_list.jl")


"""深度优先遍历辅助函数"""
function _dfs!(graph::GraphAdjList, visited::Set{Vertex}, res::Vector{Vertex}, vet::Vertex)::Nothing
	push!(res, vet)  # 记录访问顶点
	push!(visited, vet)  # 标记该顶点已被访问
	for adjVet ∈ graph.adj_list[vet]
		if adjVet ∉ visited  # 跳过已被访问的顶点
			_dfs!(graph, visited, res, adjVet)  # 递归访问邻接顶点
		end
	end
	return nothing
end


"""深度优先遍历"""
function graph_dfs(graph::GraphAdjList, start_vet::Vertex)::Vector{Vertex}
	# 使用邻接表来表示图，以便获取指定顶点的所有邻接顶点
	res = Vertex[]  # 顶点遍历序列
	visited = Set{Vertex}()  # 哈希表，用于记录已被访问过的顶点
	_dfs!(graph, visited, res, start_vet)
	return res
end


if abspath(PROGRAM_FILE) == @__FILE__
	const v = vals_to_vets([0, 1, 2, 3, 4, 5, 6])  # 初始化无向图
	const graph = GraphAdjList([
		[v[1], v[2]],
		[v[1], v[4]],
		[v[2], v[3]],
		[v[3], v[6]],
		[v[5], v[6]],
		[v[6], v[7]],
	])
	println("\n初始化后，图为")
	print(graph)

	const res = graph_dfs(graph, v[1])  # 深度优先遍历
	println("\n深度优先遍历（DFS）顶点序列为")
	println(vets_to_vals(res))
end
