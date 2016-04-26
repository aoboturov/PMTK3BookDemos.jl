using Gadfly
using Colors
using StatsFuns

"""
Plot a Gamma Distribution
"""
function drawGammaDistribution()
    as = [1. 1.5 2.]
    bs = ones(1, length(as))
    xs = linspace(0.1, 7, 40)

    colors = ["orange", "red", "purple"]
    titles = [string("a=", as[i], ",b=", bs[i]) for i=1:length(as)]

    ps = [exp(gammalogpdf(as[i], bs[i], x)) for x=xs, i=1:length(as)]

    μ = as./bs

    ls = [layer(x=xs, y=ps[:,i], Geom.line,
                Theme(default_color=parse(Colorant, colors[i]), line_width=3px),
                xintercept=[μ[i]], Geom.vline(color=parse(Colorant, colors[i]), size=3px))
          for i=1:length(as)]

    pp = plot(Guide.manual_color_key("Gamma parameters", titles, colors), ls...)
end

