using Cubature
using Distributions

"""
Demo of robust Bayesian analysis, from Berger 1984
"""
function robustPriorDemo()
    x = 5
    obsVar = 1
    
    # First let us verify that the Gaussian prior indeed satisfies the prior quartiles
    priorMu = 0
    priorVar = 2.19
    
    nprior = Normal(priorMu, sqrt(priorVar))
    @assert isapprox(cdf(nprior, -1), .25; atol=.001)
    @assert isapprox(cdf(nprior, 0) - cdf(nprior, -1), .25; atol=.001)
    @assert isapprox(cdf(nprior, 1) - cdf(nprior, 0), .25; atol=.001)
    @assert isapprox(1-cdf(nprior, 1), .25; atol=.001)
    @assert isapprox(median(nprior), 0; atol=.001)
    
    # Now compute posterior mean using Gaussian prior
    postVar = 1/(1/obsVar + 1/priorVar)
    postMeanNormal = postVar*(priorMu/priorVar + x/obsVar)
    @assert isapprox(postMeanNormal, 3.43; atol=.01)
    
    # Now let us do the same thing for the Cauchy
    cprior = Cauchy(0, 1)
    @assert isapprox(cdf(cprior, -1), .25; atol=.001)
    @assert isapprox(cdf(cprior, 0) - cdf(cprior, -1), .25; atol=.001)
    @assert isapprox(cdf(cprior, 1) - cdf(cprior, 0), .25; atol=.001)
    @assert isapprox(1-cdf(cprior, 1), .25; atol=.001)
    @assert isapprox(median(cprior), 0; atol=.001)
    
    # Now let us compute posterior mean using Cauchy
    
    lik(θ) = pdf(Normal(θ, sqrt(obsVar)), x)
    prior(θ) = pdf(cprior, θ)
    post(θ) = lik(θ).*prior(θ)
    
    ∞=10
    
    Z, err = hquadrature(post, -∞, ∞; reltol=1e-4)
    
    f(θ) = θ.*post(θ)/Z
    
    postMeanCauchy, err = hquadrature(f, -∞, ∞; reltol=1e-4)
    @assert isapprox(postMeanCauchy, 4.56; atol=.01)
    
    (postMeanNormal, postMeanCauchy)
end

