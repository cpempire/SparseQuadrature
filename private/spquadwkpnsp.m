function w = spquadwkpnsp(seq,w1d,id)
% SPQUADWKPNSP  Compute quadrature weights, kronrod-patterson-normal grid 
%    W = SPQUADWKPNSP(LEVELSEQ)  Computes the quadrature weights
%    for the given sequence of index sets LEVELSEQ. One row of 
%    column vectow W represents one weight.  
%    W1D are the integration weights in 1D, ID are the indices
%    where the weights of an according level start.  This routine
%    does essentially the same as SPQUADWKPN, but operates over
%    sparse index sets for increased efficiency, especially in 
%    case of higher dimensions D. (Internal function)
%
% See also SPQUADWKPN.

% Author : Peng Chen
% Version: 1.0
% Date   : December 1, 2015

% Change log:
% V1.0   : December 1, 2015
%          Initial version

% ------------------------------------------------------------
% Sparse Grid Interpolation Toolbox
% Copyright (c) 2006 W. Andreas Klimke, Universitaet Stuttgart 
% Copyright (c) 2007-2008 W. A. Klimke. All Rights Reserved.
% See LICENSE.txt for license. 
% email: klimkeas@ians.uni-stuttgart.de
% web  : http://www.ians.uni-stuttgart.de/spinterp
% ------------------------------------------------------------

indicesNDims  = seq.indicesNDims;
indicesLevs   = seq.indicesLevs;
subGridPoints = seq.subGridPoints;

d = size(seq.forwardNeighbors,2);

% Get the number of levels
nlevels = uint32(length(indicesNDims));
	
% index contains the index of the resulting array containing all
% subdomains of the level.
index = uint32(1);

wid = zeros(d,1);
widstart = zeros(d,1);
widend = zeros(d,1);
level  = ones(d,1,'uint8');
	
% currentindex is the index of the currently processed multiindex
% entry. 
currentindex = uint32(1);
addr = uint32(1);

% Init weights vector
w = zeros(sum(subGridPoints),1);

while currentindex <= nlevels
	ndims = indicesNDims(currentindex);
	npoints = subGridPoints(currentindex);

	% Do special case
	if ndims == 0
	  w(index) = 1; 
		index = index + 1;
		currentindex = currentindex + 1;
		continue;
	end
	
	did = uint8(1);
	while did <= ndims
		level(did) = indicesLevs(addr);
		addr = addr + 1;
		did = did + 1;
	end

	for k = 1:ndims
		lval = double(level(k));
% 		np = 2^lval;
      switch lval
          case 0
              np = 1;
          case 1
              np = 2; 
          case 2 
              np = 6;
          case 3
              np = 10;
          case 4
              np = 16;
          otherwise
              error('KPN is only implemented to level 4')
      end
		widstart(k) = id(lval+1);
		wid(k) = widstart(k);
		widend(k) = wid(k) + np - 1;
	end
	
	wid1 = wid(1);
	for k = index:index+npoints-1
		
		% Compute multi-dimensional weight
		wval = w1d(wid1);
		for l = 2:ndims
			wval = wval * w1d(wid(l));
		end
		w(k) = wval;
		
		% Compute next set of indices into w1d
		if wid1 < widend(1)
			wid1 = wid1 + 1;
		else
			wid1 = widstart(1);
			for l = 2:ndims
				if wid(l) < widend(l)
					wid(l) = wid(l) + 1;
					break;
				else
					wid(l) = widstart(l);
				end
			end
		end
	end

	index = index + npoints;
	currentindex = currentindex + 1;
end
