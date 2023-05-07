# Copyright (c) 2023 Fenyutanchan (Quan-feng WU) <fenyutanchan@vip.qq.com>
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

include("direction.jl")
include("vertex.jl")

abstract type FeynmanEdge{T} <: AbstractEdge{T} end

struct ExtLeg{T,T_mom} <: FeynmanEdge{T}
    int::InternalVertex{<:T}
    ext::ExternalVertex{<:T}
    mom::T_mom
    direction::ExtMomentumDirection # momentum direction (default `OutwardExtDirection()`)

    function ExtLeg(
        int, ext;
        mom=0,
        direction::ExtMomentumDirection=OutwardExtDirection()
    )
        v_int = isa(int, Vertex) ?
            int::InternalVertex :
            Vertex(int)
        v_ext = isa(ext, Vertex) ?
            ext::ExternalVertex :
            EndVertex(ext)
        T = Union{typeof(v_int.id), typeof(v_ext.id)}
        return new{T,typeof(mom)}(v_int, v_ext, mom, direction)
    end # function ExtLeg
end # struct ExtLeg

struct Propagator{T_vertex,T_mom,T_mass,T_delta} <: FeynmanEdge{T_vertex}
    src::InternalVertex{<:T_vertex}
    dst::InternalVertex{<:T_vertex}
    mom::T_mom
    mass::T_mass
    δ::T_delta  # Feynman's iδ prescription

    function Propagator(
        src, dst;
        mom=0, mass=0, δ=:δ
    )
        v_src = isa(src, Vertex) ?
            int::InternalVertex :
            Vertex(src)
        v_dst = isa(dst, Vertex) ?
            int::InternalVertex :
            Vertex(dst)
        T_vertex = Union{typeof(v_src.id), typeof(v_dst.id)}
        return new{T_vertex,typeof(mom),typeof(mass),typeof(δ)}(
            v_src, v_dst, mom, mass, δ
        ) # end return
    end # function Propagator
end # struct Propagator

# I/O
function show(io::IO, ::MIME"text/plain", ext_leg::ExtLeg)
    direction_str = string(ext_leg.direction)
    int_str = get_id_str(ext_leg.int)
    ext_str = get_id_str(ext_leg.ext)
    src_str = (get_id_str ∘ src)(ext_leg)
    dst_str = (get_id_str ∘ dst)(ext_leg)
    return print(io,
        """
        External leg ($int_str => $ext_str):
            - mom: $(ext_leg.mom)
            - momentum flow ($(direction_str)): from $src_str to $dst_str
        """
    ) # end return
end # function show

function show(io::IO, ::MIME"text/plain", propagator::Propagator)
    src_str = (get_id_str ∘ src)(propagator)
    dst_str = (get_id_str ∘ dst)(propagator)
    return print(io, 
        """
        Propagator:
            - momentum: $(propagator.mom)
            - momentum flow: from $src_str to $dst_str
            - mass: $(propagator.mass)
            - denominator: ($(propagator.mom))² - ($(propagator.mass))² + i $(propagator.δ)
        """
    )
end # function show

# Direction
direction(ext_leg::ExtLeg)::ExtMomentumDirection = ext_leg.direction
is_inward(ext_leg::ExtLeg)::Bool =
    isa(ext_leg.direction, InwardExtDirection)
is_outward(ext_leg::ExtLeg)::Bool =
    isa(ext_leg.direction, OutwardExtDirection)

src(ext_leg::ExtLeg) =
    if is_outward(ext_leg)
        ext_leg.int
    elseif is_inward(ext_leg)
        ext_leg.ext
    end # end if

dst(ext_leg::ExtLeg) =
    if is_inward(ext_leg)
        ext_leg.int
    elseif is_outward(ext_leg)
        ext_leg.ext
    end # end if

src(p::Propagator) = p.src
dst(p::Propagator) = p.dst
