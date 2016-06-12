module PMTK4BookDemos

    export unpairedTestHandednessDemo, amazonSellersDelta, amazonSellersTheta
    include("BayesianStatistics/amazonSellerDemo.jl")
    export drawBayesChangeOfVar
    include("BayesianStatistics/bayesChangeOfVar.jl")
    export drawBetaHPD
    include("BayesianStatistics/betaHPD.jl")
    export betaCredibleInt
    include("BayesianStatistics/betaCredibleInt.jl")
    export drawBimodalDemo
    include("BayesianStatistics/bimodalDemo.jl")
    export coinsModelSelDemo
    include("BayesianStatistics/coinsModelSelDemo.jl")
    export drawGammaDistribution
    include("BayesianStatistics/gammaPlotDemo.jl")
    export mcBetaQuantileDemo, mcNormalQuantileDemo
    include("BayesianStatistics/lossFunctionDemo.jl")
    export lossDemo, hingeLossDemo
    include("BayesianStatistics/mcQuantileDemo.jl")
    export mixBetaDemo, mixBetaBiased
    include("BayesianStatistics/mixBetaDemo.jl")
    export robustPriorDemo
    include("BayesianStatistics/robustPriorDemo.jl")
    export shrinkageDemoBaseball, shrinkageMSEBaseball
    include("BayesianStatistics/shrinkageDemoBaseball.jl")

end

