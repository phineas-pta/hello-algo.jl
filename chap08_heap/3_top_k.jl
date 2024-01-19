#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

include("2_my_heap.jl")


"""基于堆查找数组中最大的 k 个元素"""
function top_k_heap(nums::Vector{Int}, k::Int)::Vector{Int}
	heap = MaxHeap(Int[])  # 初始化小顶堆
	for i ∈ 1:k  # 将数组的前 k 个元素入堆
		push!(heap, -nums[i])  # 元素取反
	end
	for i ∈ k:length(nums)  # 从第 k+1 个元素开始，保持堆的长度为 k
		if nums[i] > -peek(heap)  # 若当前元素大于堆顶元素，则将堆顶元素出堆、当前元素入堆
			pop!(heap)
			push!(heap, -nums[i])  # 元素取反
		end
	end
	return heap.max_heap .* -1  # 返回堆中元素
end


if abspath(PROGRAM_FILE) == @__FILE__
	const res = top_k_heap([1, 7, 6, 3, 2], 3)
	println("最大的 3 个元素为")
	print_heap(res)
end
