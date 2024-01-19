#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

include("2_graph_adjacency_list.jl")


"""广度优先遍历"""
function graph_bfs(graph::GraphAdjList, start_vet::Vertex)::Vector{Vertex}
	# 使用邻接表来表示图，以便获取指定顶点的所有邻接顶点
	res = Vertex[]  # 顶点遍历序列
	visited = Set([start_vet])  # 哈希表，用于记录已被访问过的顶点
	que = [start_vet]  # 队列用于实现 BFS
	while length(que) > 0  # 以顶点 vet 为起点，循环直至访问完所有顶点
		vet = popfirst!(que)  # 队首顶点出队
		push!(res, vet)  # 记录访问顶点
		for adj_vet ∈ graph.adj_list[vet]  # 遍历该顶点的所有邻接顶点
			if adj_vet ∉ visited  # 跳过已被访问的顶点
				push!(que, adj_vet)  # 只入队未访问的顶点
				push!(visited, adj_vet)  # 标记该顶点已被访问
			end
		end
	end
	return res  # 返回顶点遍历序列
end


if abspath(PROGRAM_FILE) == @__FILE__
	const v = vals_to_vets([0, 1, 2, 3, 4, 5, 6, 7, 8, 9])  # 初始化无向图
	const graph = GraphAdjList([
		[v[1], v[2]],
		[v[1], v[4]],
		[v[2], v[3]],
		[v[2], v[5]],
		[v[3], v[6]],
		[v[4], v[5]],
		[v[4], v[7]],
		[v[5], v[6]],
		[v[5], v[8]],
		[v[6], v[9]],
		[v[7], v[8]],
		[v[8], v[9]],
	])
	println("\n初始化后，图为")
	print(graph)

	const res = graph_bfs(graph, v[1])  # 广度优先遍历
	println("\n广度优先遍历（BFS）顶点序列为")
	println(vets_to_vals(res))
end
