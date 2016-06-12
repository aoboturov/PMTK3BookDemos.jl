using Gadfly

"""
Precision-recall curve for two hypothetical classifications systems.
A is better than B.
"""
function PRhandDemo()
    domain = 0:0.01:1

    fA(x) = 1-x.^(3)
    fB(x) = 1-x.^(3/2)

    lA = layer(x=domain, y=fA(domain), Geom.line, Theme(default_color=colorant"red",  line_width=3px, line_style=Gadfly.get_stroke_vector(:dot)))
    lB = layer(x=domain, y=fB(domain), Geom.line, Theme(default_color=colorant"blue", line_width=3px))
    
    plot(lA, lB, Guide.xlabel("recall"), Guide.ylabel("precision"))
end

"""
ROC curves for two hypothetical classification systems.
A is better than B.
Plots true positive rate, (tpr) vs false positive (fpr).
"""
function ROChandDemo()
    domain = 0:0.01:1

    fA(x) = x.^(1/3)
    fB(x) = x.^(2/3)

    lA = layer(x=domain, y=fA(domain), Geom.line, Theme(default_color=colorant"red",  line_width=3px, line_style=Gadfly.get_stroke_vector(:dot)))
    lB = layer(x=domain, y=fB(domain), Geom.line, Theme(default_color=colorant"blue", line_width=3px))
    shade = layer(x=domain, y=zeros(domain), ymin=zeros(domain), ymax=fB(domain), Geom.ribbon)

    plot(lA, shade, lB, Guide.xlabel("fpr"), Guide.ylabel("tpr"))
end

