# Copyright (c) 2023 Fenyutanchan (Quan-feng WU) <fenyutanchan@vip.qq.com>
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

abstract type AbstractVertex{T} end

abstract type InternalVertex{T} <: AbstractVertex{T} end
abstract type ExternalVertex{T} <: AbstractVertex{T} end
abstract type FictitiousVertex{T} <: AbstractVertex{T} end

struct SelfLoopVertex{T} <: FictitiousVertex{T}
    id::T
end
struct MultiEdgeVertex{T} <: FictitiousVertex{T}
    id::T
end

struct Vertex{T} <: InternalVertex{T}
    id::T
end

struct EndVertex{T} <: ExternalVertex{T}
    id::T
end

# I/O
show(io::IO, ::MIME"text/plain", vertex::Vertex) =
    print(io, "Vertex: $(vertex.id)")
show(io::IO, ::MIME"text/plain", vertex::EndVertex) =
    print(io, "End vertex: $(vertex.id)")

# util
get_id_str(vertex::AbstractVertex) = string(vertex.id)
