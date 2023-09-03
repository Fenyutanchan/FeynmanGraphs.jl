# Copyright (c) 2023 Fenyutanchan (Quan-feng WU) <fenyutanchan@vip.qq.com>
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

abstract type FeynmanEdge <: AbstractEdge{FeynmanVertex} end

# Graphs.jl: the APIs for AbstractEdge
src(e::FeynmanEdge) = e.src
dst(e::FeynmanEdge) = e.dst
Pair(e::FeynmanEdge) = e.src => e.dst
Tuple(e::FeynmanEdge) = (e.src, e.dst)
 