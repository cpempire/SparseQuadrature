function w = getghweight(ndims,level)
% Generate Gauss-Hermite weights for subquadraturegh
%    (internal function)

% Author : Peng Chen 
% Version: 1.0
% Date   : January 21, 2015

% ------------------------------------------------------------
% Sparse Grid Interpolation Toolbox
% Copyright (c) 2006 W. Andreas Klimke, Universitaet Stuttgart 
% Copyright (c) 2007-2008 W. A. Klimke. All Rights Reserved.
% See LICENSE.txt for license. 
% email: klimkeas@ians.uni-stuttgart.de
% web  : http://www.ians.uni-stuttgart.de/spinterp
% ------------------------------------------------------------
% [~,ik] = setdiff(dimvec(1:ndims),olddimvec(1:oldndims));
% dimold = setdiff(1:ndims,ik);
level = double(level);
w = 1;
for inew = ndims:-1:1
    [~, weight] = GaussHermite(level(inew)+1);
    nw = length(weight);
    for iw = 1:length(w) 
        x((iw-1)*nw+1:iw*nw) = w(iw)*weight;
    end
    w = x;
end