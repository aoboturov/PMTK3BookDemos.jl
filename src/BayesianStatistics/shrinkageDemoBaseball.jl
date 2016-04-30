using DataArrays
using DataFrames
using Gadfly

function θestimation_()
    # 1970 batting averages for 18 major league players. first column = batting average for first 45 at bats 2nd column = batting everage for remainder of season
    data = [.400 .346
            .378 .298
            .356 .276
            .333 .222
            .311 .273
            .311 .270
            .289 .263
            .267 .210
            .244 .269
            .244 .230
            .222 .264
            .222 .256
            .222 .303
            .222 .264
            .222 .226
            .200 .285
            .178 .316
            .156 .200]
    
    # data transformation
    y = data[:,1]
    ytest = data[:,2]
    n = 45
    # arcsin transform
    x = sqrt(n).*asin(2.*y-1)
    
    # shrinkage estimate
    μBar = mean(x)
    V    = sumabs2(x - μBar)
    d    = length(x)
    s2   = V/d
    # by construction of the arcsin transform
    σ2   = 1
    B    = σ2/(σ2 + max(0, s2-σ2))
    μShrunk = μBar + (1-B).*(x-μBar)
    
    # back transform
    θShrunk = 0.5*(sin(μShrunk/sqrt(n))+1)
    θMLE    = y
    (ytest, θShrunk, θMLE)
end

"""
Baseball Batting Average Shrinkage Estimates
Reproduce example from "Data Analysis Using Stein's Estimator and its Generalizations" Bradley Efron; Carl Morris JASA Vol. 70, No. 350. (Jun., 1975), pp. 311-319.
"""
function shrinkageDemoBaseball()
    θtrue, θShrunk, θMLE = θestimation_()
    # plot Shrinkage Estimates
    p1 = plot([layer(x=[θMLE[i] θShrunk[i]], y=[1 0], Geom.line) for i=1:d]...,
              layer(x=θMLE, y=ones(1, d), Geom.point),
              layer(x=θShrunk, y=zeros(1, d), Geom.point),
              Theme(default_color=colorant"blue"))
    
    # histograms
    df = DataFrame(PN=[1:d, 1:d, 1:d], Theta=[ytest, θShrunk, θMLE], Type=[ones(d), 2*ones(d), 3*ones(d)])
    p2 = plot(df, y="Theta", x="PN", color="Type", Geom.bar(position=:dodge))
    
    [p1, p2]
end

function shrinkageMSEBaseball()
    θtrue, θShrunk, θMLE = θestimation_()
    mseMLE = mean((θtrue-θMLE).^2)
    mseShrink = mean((θtrue-θShrunk).^2)
    [mseMLE, mseShrink, mseMLE/mseShrink]
end

