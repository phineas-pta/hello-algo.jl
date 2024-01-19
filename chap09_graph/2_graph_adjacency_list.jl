#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

include("../utils/utils.jl")
import .utils: Vertex, vals_to_vets, vets_to_vals  # don’t remove `vets_to_vals`: used in other scripts


"""基于邻接表实现的无向图类"""
struct GraphAdjList
	adj_list::Dict{Vertex, Vector{Vertex}}  # 邻接表，key：顶点，value：该顶点的所有邻接顶点

	"""构造方法"""
	function GraphAdjList(edges::Vector{Vector{Vertex}})
		graph = new(Dict{Vertex, Vector{Vertex}}())
		for e ∈ edges  # 添加所有顶点和边
			add_vertex!(graph, e[1])
			add_vertex!(graph, e[2])
			add_edge!(graph, e[1], e[2])
		end
		return graph
	end
end

"""获取顶点数量"""
size(graph::GraphAdjList)::Int = length(graph.adj_list)

"""添加边"""
function add_edge!(graph::GraphAdjList, vet1::Vertex, vet2::Vertex)::Nothing
	if !haskey(graph.adj_list, vet1) || !haskey(graph.adj_list, vet2) || vet1 == vet2 error("oh no") end
	# 添加边 vet1 - vet2
	push!(graph.adj_list[vet1], vet2)
	push!(graph.adj_list[vet2], vet1)
	return nothing
end

"""删除边"""
function remove_edge!(graph::GraphAdjList, vet1::Vertex, vet2::Vertex)::Nothing
	if !haskey(graph.adj_list, vet1) || !haskey(graph.adj_list, vet2) || vet1 == vet2 error("oh no") end
	# 删除边 vet1 - vet2
	filter!(x -> x ≠ vet2, graph.adj_list[vet1])
	filter!(x -> x ≠ vet1, graph.adj_list[vet2])
	return nothing
end

"""添加顶点"""
function add_vertex!(graph::GraphAdjList, vet::Vertex)::Nothing
	if !haskey(graph.adj_list, vet)
		graph.adj_list[vet] = Vertex[]
	end
	return nothing
end

"""删除顶点"""
function remove_vertex!(graph::GraphAdjList, vet::Vertex)::Nothing
	if !haskey(graph.adj_list, vet) error("oh no") end
	delete!(graph.adj_list, vet)  # 在邻接表中删除顶点 vet 对应的链表
	for vertex ∈ values(graph.adj_list)  # 遍历其他顶点的链表，删除所有包含 vet 的边
		filter!(x -> x ≠ vet, vertex)
	end
	return nothing
end

"""打印邻接表"""
function print(graph::GraphAdjList)::Nothing
	println("邻接表 =")
	for (key, val) ∈ graph.adj_list
		tmp = [v.val for v ∈ val]
		println(key.val, ": ", tmp, ",")
	end
	return nothing
end


if abspath(PROGRAM_FILE) == @__FILE__
	const v = vals_to_vets([1, 3, 2, 5, 4])  # 初始化无向图
	const graph = GraphAdjList([
		[v[1], v[2]],
		[v[1], v[4]],
		[v[2], v[3]],
		[v[3], v[4]],
		[v[3], v[5]],
		[v[4], v[5]],
	])
	println("\n初始化后，图为")
	print(graph)

	# 添加边
	add_edge!(graph, v[1], v[3])  # 顶点 1, 2 即 v[1], v[3]
	println("\n添加边 1-2 后，图为")
	print(graph)

	# 删除边
	remove_edge!(graph, v[1], v[2])  # 顶点 1, 3 即 v[1], v[2]
	println("\n删除边 1-3 后，图为")
	print(graph)

	# 添加顶点
	add_vertex!(graph, Vertex(6))
	println("\n添加顶点 6 后，图为")
	print(graph)

	# 删除顶点
	remove_vertex!(graph, v[2])
	println("\n删除顶点 3 后，图为")  # 顶点 3 即 v[2]
	print(graph)
end
