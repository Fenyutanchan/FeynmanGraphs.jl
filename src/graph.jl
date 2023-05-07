# Copyright (c) 2023 Fenyutanchan (Quan-feng WU) <fenyutanchan@vip.qq.com>
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

include("edge.jl")

mutable struct FeynmanGraph{T} <: AbstractGraph{T}
    vertex_list::Vector{AbstractVertex{Int}}
    edge_list::Vector{FeynmanEdge{<:T}}
    vertex_dict::Dict{AbstractVertex,Int}

    function FeynmanGraph(edge_list::Vector{<:FeynmanEdge})
        vertex_list = (unique ∘ vcat)(src.(edge_list), dst.(edge_list))
        vertex_id_list = map(v->v.id, vertex_list)
        @assert (length ∘ unique)(vertex_id_list) == length(vertex_id_list) "Vertices with same name but different vertex type detected!"

        new_vertex_list = AbstractVertex[]
        vertex_dict = Dict{AbstractVertex, Int}()

        num_id_vertex_list = filter(v -> isa(v.id, Real), vertex_list)
        sort!(num_id_vertex_list, by=v->v.id)
        setdiff!(vertex_list, num_id_vertex_list)

        string_id_vertex_list = filter(v -> isa(v.id, String), vertex_list)
        sort!(string_id_vertex_list, by=v->v.id)
        setdiff!(vertex_list, string_id_vertex_list)

        T = Union{}

        vertex_index = 1
        for num_id_vertex ∈ num_id_vertex_list
            new_vertex = eval(:($((nameof ∘ typeof)(num_id_vertex))($vertex_index)))
            T = Union{T, typeof(num_id_vertex.id)}
            push!(new_vertex_list, new_vertex)
            vertex_dict[num_id_vertex] = vertex_index
            vertex_index += 1
        end # for num_id_vertex

        for string_id_vertex ∈ string_id_vertex_list
            new_vertex = eval(:($((nameof ∘ typeof)(string_id_vertex))($vertex_index)))
            T = Union{T, typeof(string_id_vertex.id)}
            push!(new_vertex_list, new_vertex)
            vertex_dict[string_id_vertex] = vertex_index
            vertex_index += 1
        end # for remaining_vertex

        for remaining_vertex ∈ vertex_list
            new_vertex = eval(:($((nameof ∘ typeof)(remaining_vertex))($vertex_index)))
            T = Union{T, typeof(remaining_vertex.id)}
            push!(new_vertex_list, new_vertex)
            vertex_dict[remaining_vertex] = vertex_index
            vertex_index += 1
        end # for remaining_vertex

        sort!(edge_list, by=e->(vertex_dict[src(e)], vertex_dict[dst(e)]))

        return new{T}(new_vertex_list, edge_list, vertex_dict)
    end # function FeynmanGraph
end # struct FeynmanGraph

function construct_Feynman_graph end
