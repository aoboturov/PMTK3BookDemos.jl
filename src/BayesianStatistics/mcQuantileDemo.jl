using Distributions
using StatsBase

"""
Example of a computation of beta credible interval with MC sampling.
"""
function mcQuantileDemo()
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

