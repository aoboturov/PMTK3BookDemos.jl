using StatsFuns

"""
Example of a computation of beta credible interval
"""
function betaCredibleInt()
    S = 47
    N = 100
    a = S+1
    b = (N-S)+1
    α = .05
    l  = betainvcdf(a, b, α/2)
    u  = betainvcdf(a, b, 1-α/2)
    CI = [l, u]
end

