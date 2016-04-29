using Gadfly

"""
Coins Model Selection Demo
Attempt to determine if a coin is biased or not as we accumulate more and more data, (coin flips).
"""
function coinsModelSelDemo()
    θ = .7
    N = 5
    α = 1
    ε = 0.001
    
    αh = α
    αt = α
    ii = 0:(2^N-1)
    
    flips = hcat([digits(i, 2, N) for i=ii]...)
    Nh    = reshape(sum(flips, 1), length(ii))
    Nt    = N-Nh
    marglik = exp(lbeta(αh+Nh, αt+Nt) - lbeta(αh, αt))
    mle     = Nh./N
    loglik  = Nh.*log(mle + ε) + Nt.*log(1-mle + ε)
    logBF   = lbeta(αh+Nh, αt+Nt) - lbeta(αh, αt) - N*log(0.5)
    
    # Sort in order of number of heads
    idx = sortperm(Nh)
    Nh      = Nh[idx]
    marglik = marglik[idx]
    logBF   = logBF[idx]
    loglik  = loglik[idx]
    
    # Plot marginal likelihood
    p1 = plot(x=ii, y=marglik, Geom.line, Geom.point, Theme(default_color=colorant"blue", line_width=3px),
              yintercept=[(1/2)^N], Geom.hline(color=colorant"black", size=3px))
    
    # Plot Bayes factors
    p2 = plot(x=ii, y=exp(logBF), Geom.line, Geom.point, Theme(default_color=colorant"blue", line_width=3px))
    
    # Plot BIC
    BIC1 = loglik - 1
    p3 = plot(x=ii, y=BIC1, Geom.line, Geom.point, Theme(default_color=colorant"blue", line_width=3px))
    
    # Plot log of marginal likelihood
    p4 = plot(x=ii, y=log(marglik), Geom.line, Geom.point, Theme(default_color=colorant"blue", line_width=3px))
    
    [p1, p2, p3, p4]
end

