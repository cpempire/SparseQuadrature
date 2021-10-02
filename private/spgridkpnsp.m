function x = spgridkpnsp(seq, fromindex, toindex)
% SPGRIDGPSP  Compute grid points, Kronrod-Patterson-Patterson (sparse indices)
%    X = SPGRIDKPNSP(SEQ, FROMINDEX, TOINDEX)  Computes the sparse
%    grid points for the given sequence of index sets SEQ, starting
%    with index FROMINED up to index TOINDEX. The coordinate value
%    of dimension i is stored in column i of the matrix X. One row
%    of matrix X represents one grid point. This routine works with
%    the sparse index set data generated with SPGETSEQSP.
%    (Internal function)
%	
% See also SPGETSEQSP.
	
% Author : Peng Chen
% Version: 1.0
% Date   : November 21, 2015

% ------------------------------------------------------------
% Sparse Grid Interpolation Toolbox
% Copyright (c) 2006 W. Andreas Klimke, Universitaet Stuttgart 
% Copyright (c) 2007-2008 W. A. Klimke. All Rights Reserved.
% See LICENSE.txt for license. 
% email: klimkeas@ians.uni-stuttgart.de
% web  : http://www.ians.uni-stuttgart.de/spinterp
% ------------------------------------------------------------

if nargin < 2
	if isfield(seq, 'currentindex')
		fromindex = seq.currentindex;
	else
		fromindex = uint32(1);
	end
	toindex = size(seq.indicesNDims,1);
end

% Get the number of levels
nlevels = toindex - fromindex + 1;

d = uint16(size(seq.forwardNeighbors,2));

% index contains the index of the resulting array containing all
% subdomains of the level.
index = uint32(1);

totalpoints = uint32(sum(seq.subGridPoints(fromindex:toindex)));
x = zeros(totalpoints,d);
dim = zeros(d,1,'uint16');

currentindex = fromindex;
while currentindex <= toindex
	ndims    = seq.indicesNDims (currentindex);
	addr     = seq.indicesAddr  (currentindex);
	npoints  = seq.subGridPoints(currentindex);
	
	c = cell(double(ndims),1);
	k = uint8(1);
	while k <= ndims
		lev = double(seq.indicesLevs(addr));
		dim(k) = seq.indicesDims(addr);
		ctemp = kpnabsc(lev);
        switch lev
            case 0
                c{k} = ctemp;
            case 1
                c{k} = ctemp([1,3])'; % 2
            case 2 
                c{k} = ctemp([1,2,4,6,8,9])'; % 6
            case 3
                c{k} = ctemp([1,2,4,6,8,12,14,16,18,19])'; % 10
            case 4
                c{k} = ctemp([1,2,3,5,7,9,13,17,19,23,27,29,31,33,34,35])'; % 16
            otherwise 
                error('MATLAB:spinterp:unsupportedLevel',['Maximum supported depth (level 4) ' ... 
                  'exceeded for precomputed nodes of Kronrod-Patterson-Normal grid.']);                
        end
		addr = addr + 1;
		k = k + 1;
    end
	if ndims > 1
		[c{:}] = ndgrid(c{:});
    end
%     pause
	k = uint8(1);
	while k <= ndims
		x(index:index+npoints-1,dim(k)) = c{k}(:);
		k = k + 1;
	end
	index = index + npoints;
	currentindex = currentindex + 1;
end
