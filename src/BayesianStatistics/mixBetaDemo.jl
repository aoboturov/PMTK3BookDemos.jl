using Distributions
using Gadfly
using GSL
using PMTK4Stats

αSS    = [20, 20]
βSS    = [10, 10]
αPrior = [20, 30]
βPrior = [20, 10]
M = 2
mixprior = [0.5, 0.5]
αPost      = αPrior + αSS
βPost      = βPrior + βSS

function mixBetaPost_()
    logmarglik  = lbeta(αPrior+αSS, βPrior+βSS)-lbeta(αPrior, βPrior)
    normPost, L = normalizeLogspace(logmarglik .+ log(mixprior))
    mixpost     = exp(normPost)
end

function mixBetaDemo()
    mixpost = mixBetaPost_()
    grid = 0.0001:0.01:0.9999
    
    function evalpdf(θ, Z, α, β)
        sum([Z[i].*pdf(Beta(α[i], β[i]), θ) for i=1:length(Z)])
    end
    
    prior = evalpdf(grid, mixprior, αPrior, βPrior)
    post  = evalpdf(grid, mixpost, αPost, βPost)
    
    lprior = layer(x=grid, y=prior, Geom.line, Theme(default_color=colorant"red", line_width=3px, line_style=Gadfly.get_stroke_vector(:dash)))
    lpost  = layer(x=grid, y=post, Geom.line, Theme(default_color=colorant"blue", line_width=3px))
    [lprior lpost]
end

function mixBetaBiased()
    mixpost = mixBetaPost_()
    pbiased = sum(mixpost.*(1-[sf_beta_inc(αPost[i], βPost[i], .5) for i=1:length(αPost)]))
    pbiasedSimple = 1-sf_beta_inc(αPost[1], βPost[1], .5)
    [pbiased, pbiasedSimple]
end

