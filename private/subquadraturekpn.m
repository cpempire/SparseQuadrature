function subquad = subquadraturekpn(d,y,subindex,seq)

subquad = 0;

currentindex = subindex;
% Get the indices data from the structure (required here such that
% the processing in the loops gets JIT-compiled).
subGridPoints = seq.subGridPoints;
subGridAddr = seq.subGridAddr;
indicesNDims = seq.indicesNDims;
indicesDims = seq.indicesDims;
indicesAddr = seq.indicesAddr;
indicesLevs = seq.indicesLevs;

backward = seq.backwardNeighbors;
if isfield(seq, 'forwardAddr')
	forwardAddr = seq.forwardAddr;
	directForward = false;
else
	directForward = true;
end
forward = seq.forwardNeighbors;
	
% Allocate temporary arrays
level = zeros(d,1,'uint8');
newlevel = zeros(d,1,'uint8');
oldlevel = zeros(d,1,'uint8');
dimvec = ones(d,1,'uint16');
olddimvec = ones(d,1,'uint16');
down = ones(d,1,'uint8');

% The number of subgrids contributing to the hierarchical
% surpluses of current index.
ngrids = uint32(1);

newaddr = indicesAddr(currentindex);
ndims = indicesNDims(currentindex);
did = uint16(1);
while did <= ndims
    dim = indicesDims(newaddr);
    backvec(dim) = backward(newaddr);
    dimvec(did) = dim;
    lev = indicesLevs(newaddr);
    newlevel(did) = lev;
    level(did) = lev;
    ngrids = ngrids * (uint32(lev)+1);
    down(did) = 1;
    newaddr = newaddr + 1;
    did = did + 1;
end
	
kl = uint32(1);
while kl <= ngrids
    % Determine the subgrid to compute
    if kl < ngrids
        did = uint16(1);
        while did <= ndims
            if down(did)
                if level(did) > 0
                    level(did) = level(did) - 1;
                    oldindex = backvec(dimvec(did));
                    break;
                else
                    down(did) = 0;
                end
            else
                if level(did) < newlevel(did)
                    level(did) = level(did) + 1;
                    if directForward
                        oldindex = forward(oldindex, dimvec(did));
                    else						
                        oldindex = forward(forwardAddr(oldindex), dimvec(did));
                    end
                    break;
                else
                    down(did) = 1;
                end
            end
            did = did + 1;
        end
    else
        oldindex = currentindex;
    end
    
    oldndims = indicesNDims(oldindex);
    index = subGridAddr(oldindex);

    oldaddr = indicesAddr(oldindex);
    noldpoints = subGridPoints(oldindex);
    if oldndims == 0
        oldlevel = 0;
        olddimvec = 0;
    else
        did = uint16(1);
        while did <= oldndims
            olddim = indicesDims(oldaddr);
            olddimvec(did) = olddim;
            oldlval = indicesLevs(oldaddr);
            oldlevel(did) = oldlval;
            backvec(olddim) = backward(oldaddr);
            oldaddr = oldaddr + 1;
            did = did + 1;
        end
    end
    vals  = y(index:index+noldpoints-1);
    weight = getkpnweight(ndims,dimvec,oldndims,olddimvec,newlevel,oldlevel);
    subquad = subquad + weight*vals;

    kl = kl + 1;
end
