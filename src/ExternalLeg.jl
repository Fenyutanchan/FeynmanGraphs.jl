# Copyright (c) 2023 Fenyutanchan (Quan-feng WU) <fenyutanchan@vip.qq.com>
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

struct ExternalLeg <: FeynmanEdge
    src::InternalVertex # from internal vertex to external vertex
    dst::ExternalVertex # from internal vertex to external vertex

    particle
    momentum

    momentum_direction::ExternalDirection
    other_directions::Dict{String, ExternalDirection}
end

==(e1::ExternalLeg, e2::ExternalLeg) = e1.src == e2.src &&
    e1.dst == e2.dst &&
    e1.particle == e2.particle &&
    e1.momentum == e2.momentum &&
    e1.momentum_direction == e2.momentum_direction &&
    e1.other_directions == e2.other_directions

function add_external_leg!(g::FeynmanGraph, e::ExternalLeg)::Bool
    if e.dst ∉ g.vertex_list
        push!(g.edge_list, e)
        union!(g.vertex_list, e.src)
        push!(g.vertex_list, e.dst)
        return true
    end
    return false
end 
