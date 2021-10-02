function subquad = subquadraturegh(d,y,subindex,seq)


currentindex = subindex;
% Get the indices data from the structure (required here such that
% the processing in the loops gets JIT-compiled).
subGridPoints = seq.subGridPoints;
subGridAddr = seq.subGridAddr;
indicesNDims = seq.indicesNDims;
indicesAddr = seq.indicesAddr;
indicesLevs = seq.indicesLevs;
	
% Allocate temporary arrays
level = zeros(d,1,'uint16');


newaddr = indicesAddr(currentindex);
ndims = indicesNDims(currentindex);
did = uint16(1);
while did <= ndims
    lev = indicesLevs(newaddr);
    level(did) = lev;
    newaddr = newaddr + 1;
    did = did + 1;
end

npoints = subGridPoints(currentindex);
index = subGridAddr(currentindex);
vals  = y(index:index+npoints-1);
growthLevel = seq.growthLevel;
if strcmpi(growthLevel, 'double')
    level = 2.^(level+1) - 2;
end
weight = getghweight(ndims,level);
subquad = weight*vals;