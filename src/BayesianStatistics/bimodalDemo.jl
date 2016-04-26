using Gadfly
using StatsFuns

"""
Bimodal Spike Demo
"""
function drawBimodalDemo(fileName::AbstractString)
    μ = [.0 2.]
    Σ = [1. .05]
    w = [.5 .5]
    xs = collect(-2:.01:μ[2]*2)

    p = [(w[1]*normpdf(μ[1], Σ[1], x) + w[2]*normpdf(μ[2], Σ[2], x)) for x=xs]

    μ = mean(xs .* p)

    pp = plot(x=xs, y=p, Geom.line, Theme(default_color=colorant"black", line_width=3px),
              xintercept=[μ], Geom.vline(color=colorant"red", size=3px))

    draw(SVG("$fileName.svg", 10cm, 15cm), pp)
end

