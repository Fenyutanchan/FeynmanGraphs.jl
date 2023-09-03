# Copyright (c) 2023 Fenyutanchan (Quan-feng WU) <fenyutanchan@vip.qq.com>
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

abstract type FeynmanVertex end

abstract type InternalVertex <: FeynmanVertex end
abstract type ExternalVertex <: FeynmanVertex end

# abstract type FictitiousVertex <: InternalVertex end

# struct SelfLoopVertex <: FictitiousVertex
#     id
# end
# struct MultiEdgeVertex <: FictitiousVertex
#     id
# end

struct Vertex <: InternalVertex
    id
end

struct EndVertex <: ExternalVertex
    id
end

struct CounterTermVertex <: InternalVertex
    id
    order::Dict{String, Int}
end

==(v1::FeynmanVertex, v2::FeynmanVertex) = typeof(v1) == typeof(v2) && v1.id == v2.id
==(v1::CounterTermVertex, v2::CounterTermVertex) = v1.id == v2.id && v1.order == v2.order
