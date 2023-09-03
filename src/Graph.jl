# Copyright (c) 2023 Fenyutanchan (Quan-feng WU) <fenyutanchan@vip.qq.com>
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

mutable struct FeynmanGraph <: AbstractGraph{FeynmanVertex}
    vertex_list::Vector{FeynmanVertex}
    edge_list::Vector{FeynmanEdge}

    FeynmanGraph() = new(FeynmanVertex[], FeynmanEdge[])
end

# Graphs.jl: the APIs for AbstractGraph
edges(g::FeynmanGraph) = g.edge_list
eltype(::FeynmanGraph) = FeynmanVertex
edgetype(::FeynmanGraph) = FeynmanEdge
has_edge(g::FeynmanGraph, e::FeynmanEdge) = e ∈ g.edge_list 
has_vertex(g::FeynmanGraph, v::FeynmanVertex) = v ∈ g.vertex_list
inneighbors(g::FeynmanGraph, v::FeynmanVertex) = [e.src for e ∈ g.edge_list if e.dst == v]
ne(g::FeynmanGraph) = length(g.edge_list)
nv(g::FeynmanGraph) = length(g.vertex_list)
outneighbors(g::FeynmanGraph, v::FeynmanVertex) = [e.dst for e ∈ g.edge_list if e.src == v]
vertices(g::FeynmanGraph) = g.vertex_list
is_directed(::FeynmanGraph) = true
is_directed(::Type{FeynmanGraph}) = true
zero(::Type{FeynmanGraph}) = FeynmanGraph()
