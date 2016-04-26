using Gadfly
using Distributions

"""
Bimodal Spike Demo
"""
function drawBimodalDemo()
    μ = [.0 2.]
    Σ = [1. .05]
    w = [.5 .5]
    xs = collect(-2:.01:μ[2]*2)

    n1 = Normal(μ[1], Σ[1])
    n2 = Normal(μ[2], Σ[2])
    p = w[1]*pdf(n1, xs) + w[2]*pdf(n2, xs)

    μ = mean(xs .* p)

    pp = plot(x=xs, y=p, Geom.line, Theme(default_color=colorant"black", line_width=3px),
              xintercept=[μ], Geom.vline(color=colorant"red", size=3px))
end

