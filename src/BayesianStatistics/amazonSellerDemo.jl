using Cubature
using Distributions
using Gadfly
using PMTK4BasicModels

y1 = 90
n1 = 100
y2 = 2 
n2 = 2
β1 = Beta(y1+1, n1-y1+1)
β2 = Beta(y2+1, n2-y2+1)

"""
Analysis of binomial differences.
"""
function unpairedTestHandednessDemo()
    θ1, θ2, δ, dens = contingencyTableUnpairedDiffPostMc(n1, y1, n2, y2)
    diff = θ1-θ2

    qq = quantile(EmpiricalUnivariateDistribution(diff), [.025, .975])
    
    pp = plot(x=δ, y=dens, Geom.line, Theme(default_color=colorant"black", line_width=3px),
              xintercept=qq, Geom.vline(color=colorant"blue", size=3px))
end

"""
Compute a probability whether buying from the first seller is better than from the second.
First value is given by a numerical integration method, the second - by MCMC.
"""
function amazonsSellerDelta()
    integrand(θ::Vector{Float64}) = pdf(β1, θ[1]) .* pdf(β2, θ[2]) .* (θ[1] > θ[2])
    pGreaterExact, err = hcubature(integrand, [0, 0], [1, 1], reltol=1e-4)

    θ1, θ2, δ, dens = contingencyTableUnpairedDiffPostMc(n1, y1, n2, y2)
    pGreaterMC = mean(θ1.>θ2)

    [pGreaterExact, pGreaterMC]
end

"""
Exact posteriors p(θ|D)
"""
function amazonSellersTheta()
    xs = linspace(0.001, 0.999, 40)
    ps1 = pdf(β1, xs)
    ps2 = pdf(β2, xs)
    
    pdf1_l = layer(x=xs, y=ps1, Geom.line, Theme(default_color=colorant"red", line_width=3px))
    pdf2_l = layer(x=xs, y=ps2, Geom.point, Theme(default_color=colorant"green", line_width=3px))
    
    pp = plot(pdf1_l, pdf2_l)
end

