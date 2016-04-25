using Cubature
using Gadfly
using StatsBase
using StatsFuns
using PMTK4BasicModels

y1 = 90
n1 = 100
y2 = 2 
n2 = 2

"""
Analysis of binomial differences.
"""
function unpairedTestHandednessDemo(fileName::AbstractString)
    θ1, θ2, deltas, dens = contingencyTableUnpairedDiffPostMc(n1, y1, n2, y2)
    diff = θ1-θ2
    
    qq = [percentile(diff, 100*q) for q=[.025, .975]]
    
    pp = plot(x=deltas, y=dens, Geom.line, Theme(default_color=colorant"black", line_width=3px),
              xintercept=qq, Geom.vline(color=colorant"blue", size=3px))
    draw(SVG("$fileName.svg", 20cm, 15cm), pp)
end

"""
Compute a probability whether buying from the first seller is better than from the second.
First value is given by a numerical integration method, the second - by MCMC.
"""
function amazonSellerDelta()
    integrand(θ::Vector{Float64}) = betapdf(y1+1, n1-y1+1, θ[1]) .* betapdf(y2+1, n2-y2+1, θ[2]) .* (θ[1] > θ[2])
    pGreaterExact, err = hcubature(integrand, [0, 0], [1, 1], reltol=1e-4)

    θ1, θ2, deltas, dens = contingencyTableUnpairedDiffPostMc(n1, y1, n2, y2)
    pGreaterMC = mean([convert(Int, θ1[i]>θ2[i]) for i in 1:length(θ1)])

    [pGreaterExact, pGreaterMC]
end

"""
Exact posteriors p(θ|D)
"""
function amazonSellersTheta(fileName::AbstractString)
    xs = linspace(0.001, 0.999, 40)
    ps1 = [exp(betalogpdf(1+y1, 1+n1-y1, x)) for x=xs]
    ps2 = [exp(betalogpdf(1+y2, 1+n2-y2, x)) for x=xs]
    
    pdf1_l = layer(x=xs, y=ps1, Geom.line, Theme(default_color=colorant"red", line_width=3px))
    pdf2_l = layer(x=xs, y=ps2, Geom.point, Theme(default_color=colorant"green", line_width=3px))
    
    pp = plot(pdf1_l, pdf2_l)
    draw(SVG("$fileName.svg", 20cm, 15cm), pp)
end

