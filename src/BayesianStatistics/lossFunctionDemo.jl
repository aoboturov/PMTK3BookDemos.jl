using Gadfly

function lossDemo()
    qs = [.2, 1, 2]
    loss(x, q) = abs(x).^q

    x = -2:0.01:2

    function lossPlot(q)
        plot(x=x, y=loss(x, q), Geom.line, Theme(default_color=colorant"black", line_width=1px))
    end

    [lossPlot(q) for q in qs]
end

function hingeLossDemo(ε)
    hinge(x) = (abs(x)-ε).*(abs(x).>=ε)

    x = -2:0.01:2
    plot(x=x, y=hinge(x), Geom.line, Theme(default_color=colorant"black", line_width=1px))
end

