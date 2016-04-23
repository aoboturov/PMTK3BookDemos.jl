using PMTK4BasicModels
using Gadfly

"""
Bimodal Spike Demo
"""
function drawBimodalDemo(fileName::AbstractString)
    mu = [.0 2.]
    sigma = [1. .05]
    w = [.5 .5]
    xs = collect(-2:.01:mu[2]*2)

    p = w[1]*gaussProb(xs, mu[1], sigma[1].^2) + w[2]*gaussProb(xs, mu[2], sigma[2].^2)

    mu = mean(xs .* p)

    pp = plot(x=xs, y=p, Geom.line, Theme(default_color=colorant"black", line_width=3px),
              xintercept=[mu], Geom.vline(color=colorant"red", size=3px))

    draw(SVG("$fileName.svg", 10cm, 15cm), pp)
end

