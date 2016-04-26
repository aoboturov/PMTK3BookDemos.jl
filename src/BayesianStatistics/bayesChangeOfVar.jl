using Distributions
using Gadfly
using Colors

"""
Bayes changes of variables
"""
function drawBayesChangeOfVar()
    xseq = collect(0:0.1:10)
    
    ginv(x) = 1./(1+exp(-x+5))
    
    μ = 6
    Σ = 1
    N = 10^6
    
    rn = Normal(μ, Σ)
    x  = rand(rn, N)
    
    yheight, ypoints = hist(ginv(x), 51)
    
    titles=["g"; "p_X"; "p_Y"]
    colors=["blue"; "red"; "green"]
    
    g   = layer(x=xseq, y=ginv(xseq), Geom.line, Theme(default_color=parse(Colorant, colors[1]), line_width=3px))
    p_x = layer(x=x, Geom.histogram(bincount=50, density=true), Theme(default_color=parse(Colorant, colors[2])))
    p_y = layer(y=ginv(x), Geom.histogram(bincount=50, density=true, orientation=:horizontal),
               Theme(default_color=parse(Colorant, colors[3])))
    hl  = layer(x=[0; μ], y=[ginv(μ); ginv(μ)], Geom.line, Theme(line_width=3px))
    vl  = layer(x=[μ; μ], y=[0, ginv(μ)], Geom.line, Theme(line_width=3px))
    
    pp = plot(hl, vl, g, p_x, p_y, Guide.manual_color_key("Bayes changes of vars", titles, colors))
end

