function yvalue = barycentricinterp(y,x,xvalue)

w = barycentricweight(x);

ny = length(y);
nx = length(x);

for iy = 1:ny 
    c1 = 0;
    c2 = 0;
    ip = 0;
    for ix = 1:nx 
        if abs(y(iy) - x(ix)) < eps
            yvalue(iy) = xvalue(ix);
            ip = 1;
            continue;
        else
            c1 = c1 + w(ix)/(y(iy) - x(ix))*xvalue(ix);
            c2 = c2 + w(ix)/(y(iy) - x(ix));
        end
    end
    if ip == 0
        yvalue(iy) = c1/c2;
    end
end