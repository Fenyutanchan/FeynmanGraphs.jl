# Copyright (c) 2023 Fenyutanchan (Quan-feng WU) <fenyutanchan@vip.qq.com>
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

abstract type Direction end
abstract type MomentumDirection <: Direction end
abstract type ExtMomentumDirection <: MomentumDirection end
struct InwardExtDirection <: ExtMomentumDirection end
struct OutwardExtDirection <: ExtMomentumDirection end

# I/O
string(::OutwardExtDirection) = "Outward"
string(::InwardExtDirection) = "Inward"

show(io::IO, ::MIME"text/plain", ::OutwardExtDirection) =
    print(io, "Outward")
show(io::IO, ::MIME"text/plain", ::InwardExtDirection) =
    print(io, "Inward")
