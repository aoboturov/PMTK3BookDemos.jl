using Distributions
using StatsBase
using StatsFuns

"""
Example of a computation of beta credible interval with MC sampling.
"""
function mcBetaQuantileDemo()
    S = 47
    N = 100
    a = S+1
    b = (N-S)+1
    α = .05
    
    SS = 1000
    rn = Beta(a, b)
    X = rand(rn, SS)
    sort!(X)
    
    Xl = X[round(Int, SS*α/2)]
    Xu = X[round(Int, SS*(1-α/2))]
    CIhat = [Xl Xu]
    
    CIhat2 = [percentile(X, 100*α/2), percentile(X, 100*(1-α/2))]
end


"""
Example of a computation of normal credible interval with MC sampling.
"""
function mcNormalQuantileDemo()
    μ = 0
    Σ = 1
    S = 1000
    rn = Normal(μ, Σ)
    X = rand(rn, S)
    qs = [0.025 0.5 0.975]
    
    qexact = [norminvcdf(μ, Σ, q) for q=qs]
    
    qapprox = [percentile(X, 100*q) for q=qs]
end

