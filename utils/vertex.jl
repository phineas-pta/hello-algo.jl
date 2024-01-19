"""顶点类"""
mutable struct Vertex
	val::Int
end


"""输入值列表 vals ，返回顶点列表 vets"""
function vals_to_vets(vals::Vector{Int})::Vector{Vertex}
	return [Vertex(val) for val ∈ vals]
end


"""输入顶点列表 vets ，返回值列表 vals"""
function vets_to_vals(vets::Vector{Vertex})::Vector{Int}
	return [vet.val for vet ∈ vets]
end
