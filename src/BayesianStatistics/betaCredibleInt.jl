using Distributions

"""
Example of a computation of beta credible interval
"""
function betaCredibleInt()
    S = 47
    N = 100
    a = S+1
    b = (N-S)+1
    α = .05
    β = Beta(a, b)
    CI = quantile(β, [α/2, 1-α/2])
end

