function surplus = computequadsurplus(d,y,seq,kstart,kend,iskpn,isgh)
% compute the integration surplus at each of the given indices
% weight and the function index to evaluate integration

% Get the first new active index
currentindex = kstart;

% Compute total number of new indices that require computation of
% new surpluses
nnewlevels = kend - currentindex + 1;
surplus = zeros(1,nnewlevels);

indicesNDims = seq.indicesNDims;
indicesDims = seq.indicesDims;
indicesAddr = seq.indicesAddr;

backward = seq.backwardNeighbors;

dimvec = ones(d,1,'uint16');

nkl = uint32(1);
while nkl <= nnewlevels
        
	% get the number of involved dimensions
	ndims = indicesNDims(currentindex);
    
    % get the starting index of involved dimension 
    newaddr = indicesAddr(currentindex);
    
	did = uint16(1);
	while did <= ndims
		dim = indicesDims(newaddr);
		backvec(dim) = backward(newaddr);
		dimvec(did) = dim;
		newaddr = newaddr + 1;
		did = did + 1;
    end    
    
    % compute (Q_(i1)-Q_(i1-1))x...x(Q_(indims)-Q_(indims-1)) f
    for iq = pow2(double(ndims)):-1:1
        indexquad = rem(floor((iq-1)*pow2(1-double(ndims):0)),2)-1;
        coeff = prod(indexquad*2+1);
        
        % compute the iq-th index
        subindex = currentindex;
        subbackvec = backvec;
        for isub = 1:ndims
            if indexquad(isub) == -1
                subindex = subbackvec(dimvec(isub));
                subaddr = indicesAddr(subindex);
                subndims = indicesNDims(subindex);

                did = uint16(1);
                while did <= subndims
                    dim = indicesDims(subaddr);
                    subbackvec(dim) = backward(subaddr);
                    subaddr = subaddr + 1;
                    did = did + 1;
                end                
            end
        end

        if iskpn == 1
            subquad = subquadraturekpn(d,y,subindex,seq);
        elseif isgh == 1
            subquad = subquadraturegh(d,y,subindex,seq);
        else
            error('choose between kpn and gh')
        end
%         surplus
%         coeff
%         subquad
        surplus(nkl) = surplus(nkl) + coeff * subquad;%
    end

	currentindex = currentindex + 1;
	nkl = nkl + 1;
end    