using PMTK4BasicModels
using Gadfly
using Colors

"""
Plot a Gamma Distribution
"""
function drawGammaDistribution(fileName::AbstractString)
    as = [1. 1.5 2.]
    bs = ones(1, length(as))
    xs = linspace(0.1, 7, 40)

    colors = ["orange", "red", "purple"]
    titles = [string("a=", as[i], ",b=", bs[i]) for i=1:length(as)]

    ps = [exp(gammaLogprob(as[i], bs[i], xs)) for i=1:length(as)]

    mus = as./bs

    ls = [layer(x=xs, y=ps[i], Geom.line,
                Theme(default_color=parse(Colorant, colors[i]), line_width=3px),
                xintercept=[mus[i]], Geom.vline(color=parse(Colorant, colors[i]), size=3px))
          for i=1:length(ps)]

    pp = plot(Guide.manual_color_key("Gamma parameters", titles, colors), ls...)

    draw(SVG("$fileName.svg", 10cm, 15cm), pp)
end

