# Copyright (c) 2023 Fenyutanchan (Quan-feng WU) <fenyutanchan@vip.qq.com>
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

abstract type Direction end

abstract type InternalDirection <: Direction end
abstract type ExternalDirection <: Direction end

struct ForwardDirection <: InternalDirection end
struct BackwardDirection <: InternalDirection end

struct InwardDirection <: ExternalDirection end
struct OutwardDirection <: ExternalDirection end
