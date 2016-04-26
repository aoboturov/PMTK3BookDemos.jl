using Colors
using Gadfly
using Distributions

"""
Plot a Gamma Distribution
"""
function drawGammaDistribution()
    as = [1. 1.5 2.]
    bs = ones(1, length(as))
    xs = linspace(0.1, 7, 40)

    colors = ["orange", "red", "purple"]
    titles = [string("a=", as[i], ",b=", bs[i]) for i=1:length(as)]

    γs = [Gamma(as[i], bs[i]) for i=1:length(as)]
    ps = [pdf(γ, x) for x=xs, γ=γs]

    μ = as./bs

    ls = [layer(x=xs, y=ps[:,i], Geom.line,
                Theme(default_color=parse(Colorant, colors[i]), line_width=3px),
                xintercept=[μ[i]], Geom.vline(color=parse(Colorant, colors[i]), size=3px))
          for i=1:length(as)]

    pp = plot(Guide.manual_color_key("Gamma parameters", titles, colors), ls...)
end

