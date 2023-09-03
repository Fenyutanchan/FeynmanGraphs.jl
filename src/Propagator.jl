# Copyright (c) 2023 Fenyutanchan (Quan-feng WU) <fenyutanchan@vip.qq.com>
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

abstract type Propagator <: FeynmanEdge end

struct StandardPropagator <: Propagator
    src::InternalVertex
    dst::InternalVertex

    particle

    momentum
    mass
    width

    momentum_direction::InwardDirection
    other_directions::Dict{String, InwardDirection}
end

==(e1::StandardPropagator, e2::StandardPropagator) = e1.src == e2.src &&
    e1.dst == e2.dst &&
    e1.particle == e2.particle &&
    e1.momentum == e2.momentum &&
    e1.mass == e2.mass &&
    e1.width == e2.width &&
    e1.momentum_direction == e2.momentum_direction &&
    e1.other_directions == e2.other_directions

function add_standard_propagator!(g::FeynmanGraph, e::StandardPropagator)::Bool
    union!(g.vertex_list, Tuple(e))
    push!(g.graph_list, e)
    return true
end