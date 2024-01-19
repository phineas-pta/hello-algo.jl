"""二叉树节点类"""
@kwdef mutable struct TreeNode
	val::Int  # 节点值
	height::Int = 0  # 节点高度
	 left::Union{TreeNode, Nothing} = nothing  # 左子节点引用
	right::Union{TreeNode, Nothing} = nothing  # 右子节点引用
end


"""将列表反序列化为二叉树：递归"""
function _list_to_tree_dfs(arr::Vector{Union{Int, Nothing}}, i::Int)::Union{TreeNode, Nothing}
	# 如果索引超出数组长度，或者对应的元素为 None ，则返回 None
	if i < 1 || i > length(arr) || isnothing(arr[i])
		return nothing
	else
		return TreeNode(  # 构建当前节点
			val=arr[i],  # 递归构建左右子树
			 left=_list_to_tree_dfs(arr, 2i + 1),
			right=_list_to_tree_dfs(arr, 2i + 2)
		)
	end
end


"""将列表反序列化为二叉树"""
function list_to_tree(arr::Vector{Union{Int, Nothing}})::Union{TreeNode, Nothing}
	return _list_to_tree_dfs(arr, 1)
end


"""将二叉树序列化为列表：递归"""
function _tree_to_list_dfs!(root::Union{TreeNode, Nothing}, i::Int, res::Vector{Union{Int, Nothing}})::Nothing
	if !isnothing(root)
		if i ≥ length(res)
			append!(res, fill(nothing, i - length(res) + 1))
		end
		res[i] = root.val
		_tree_to_list_dfs!(root.left,  2i + 1, res)
		_tree_to_list_dfs!(root.right, 2i + 2, res)
	end
	return nothing
end


"""将二叉树序列化为列表"""
function tree_to_list(root::Union{TreeNode, Nothing})::Vector{Union{Int, Nothing}}
	res = Vector{Union{Int, Nothing}}()
	_tree_to_list_dfs!(root, 1, res)
	return res
end
