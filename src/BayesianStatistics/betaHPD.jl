using Distributions
using Gadfly
using PMTK4Stats

"""
Plot CI and HPD for beta posterior
"""
function drawBetaHPD()
    a = 3
    b = 9
    α = 0.05
    β = Beta(a, b)   

    CI = quantile(β, [α/2, 1-α/2])
    
    xs = linspace(0.001, 0.999, 40)
    ps = pdf(β, xs)
    
    icdf(p::Real) = quantile(β, p)
    HPD = hdiFromIcdf(icdf)
    
    ints = hcat(CI, HPD)
    names = ["CI"; "HPD"]
    
    function plot_ci(int, name)
        l, u = int
        pl = pdf(β, l)
        pu = pdf(β, u)
        vert_up_l = layer(x=[l, l], y=[0, pl], Geom.line, Theme(default_color=colorant"blue", line_width=3px))
        hor_l     = layer(x=[l, u], y=[pl, pu], Geom.line, Theme(default_color=colorant"blue", line_width=3px))
        vert_dn_l = layer(x=[u, u], y=[pu, 0], Geom.line, Theme(default_color=colorant"blue", line_width=3px))
        pdf_l     = layer(x=xs, y=ps, Geom.line, Theme(default_color=colorant"black", line_width=3px))
    
        pp = plot(vert_up_l, hor_l, vert_dn_l, pdf_l)
    end
    
    [plot_ci(slicedim(ints, 2, i), names[i]) for i=1:length(names)]
end

