#!/usr/bin/env -S julia --color=yes --threads=auto --startup-file=no

include("../utils/utils.jl")
import .utils: print_heap


"""大顶堆"""
struct MaxHeap
	max_heap::Vector{Int}

	"""构造方法，根据输入列表建堆"""
	function MaxHeap(nums::Vector{Int})
		heap = new(nums)
		for i ∈ _parent(size(heap)):-1:1
			_shift_down!(heap, i)
		end
		return heap
	end
end

"""获取左子节点的索引"""
_left(i::Integer)::Integer = 2i + 1

"""获取右子节点的索引"""
_right(i::Integer)::Integer = 2i + 2

"""获取父节点的索引"""
_parent(i::Integer)::Integer = (i - 1) ÷ 2

"""交换元素"""
function _swap!(heap::MaxHeap, i::Int, j::Int)::Nothing
	heap.max_heap[i], heap.max_heap[j] = heap.max_heap[j], heap.max_heap[i]
	return nothing
end

"""获取堆大小"""
size(heap::MaxHeap)::Integer = length(heap.max_heap)

"""判断堆是否为空"""
is_empty(heap::MaxHeap)::Bool = size(heap) == 0

"""访问堆顶元素"""
peek(heap::MaxHeap)::Integer = heap.max_heap[begin]

"""元素入堆"""
function push!(heap::MaxHeap, val::Integer)::Nothing
	Base.push!(heap.max_heap, val)  # full name coz overwritten itself  # 添加节点
	_shift_up!(heap, size(heap))  # 从底至顶堆化
	return nothing
end

"""从节点 i 开始，从底至顶堆化"""
function _shift_up!(heap::MaxHeap, i::Integer)::Nothing
	while true
		p = _parent(i)  # 获取节点 i 的父节点
		if p < 1 || heap.max_heap[i] ≤ heap.max_heap[p] break end  # 当“越过根节点”或“节点无须修复”时，结束堆化
		_swap!(heap, i, p)  # 交换两节点
		i = p  # 循环向上堆化
	end
	return nothing
end

"""元素出堆"""
function pop!(heap::MaxHeap)::Integer
	if is_empty(heap) error("堆为空") end
	_swap!(heap, 1, size(heap))  # 交换根节点与最右叶节点（交换首元素与尾元素）
	val = Base.pop!(heap.max_heap)  # full name coz overwritten itself  # 删除节点
	_shift_down!(heap, 1)  # 从顶至底堆化
	return val  # 返回堆顶元素
end

"""从节点 i 开始，从顶至底堆化"""
function _shift_down!(heap::MaxHeap, i::Integer)::Nothing
	while true
		l, r, ma = _left(i), _right(i), i  # 判断节点 i, l, r 中值最大的节点，记为 ma
		if l ≤ size(heap) && heap.max_heap[l] > heap.max_heap[ma]; ma = l end
		if r ≤ size(heap) && heap.max_heap[r] > heap.max_heap[ma]; ma = r end
		if ma == i break end  # 若节点 i 最大或索引 l, r 越界，则无须继续堆化，跳出
		_swap!(heap, i, ma)  # 交换两节点
		i = ma  # 循环向下堆化
	end
	return nothing
end

"""打印堆（二叉树）"""
print(heap::MaxHeap)::Nothing = print_heap(heap.max_heap)


if abspath(PROGRAM_FILE) == @__FILE__
	const max_heap = MaxHeap([9, 8, 6, 6, 7, 5, 2, 1, 4, 3, 6, 2])  # 初始化大顶堆
	println("\n输入列表并建堆后")
	print(max_heap)

	println("\n堆顶元素为 ", peek(max_heap))  # 获取堆顶元素

	push!(max_heap, 7)  # 元素入堆
	println("\n元素 7 入堆后")
	print(max_heap)

	println("\n堆顶元素 ", pop!(max_heap), " 出堆后")  # 堆顶元素出堆
	print(max_heap)

	println("\n堆元素数量为 ", size(max_heap))  # 获取堆大小

	println("\n堆是否为空 ", is_empty(max_heap))  # 判断堆是否为空
end
