function w = spquadw(n,d,options)
% SPQUADW   Compute the sparse grid quadrature weights
%    W = SPQUADW(N,D)  Computes the sparse grid quadrature
%    weights of level N and problem dimension D. The ordering
%    of the weights vector corresponds to the ordering of the
%    rows of point coordinates generated by SPGRID(N,D).
%
%    W = SPQUADW(N, D, OPTIONS) computes the weights as above,
%    but with default grid type replaced by the grid type
%    specified in OPTIONS, an argument created with the SPSET
%    function. See SPSET for details.
%
%    See also SPGRID, SPQUAD, SPDIM.
	
% Author : Andreas Klimke
% Version: 1.1
% Date   : Sepember 8, 2007

% Change log:
% V1.0   : September 8, 2007
%          Initial version
% V1.1   : November 24, 2007
%          Added Gauss-Patterson grid

% ------------------------------------------------------------
% Sparse Grid Interpolation Toolbox
% Copyright (c) 2006 W. Andreas Klimke, Universitaet Stuttgart 
% Copyright (c) 2007-2008 W. A. Klimke. All Rights Reserved.
% See LICENSE.txt for license. 
% email: klimkeas@ians.uni-stuttgart.de
% web  : http://www.ians.uni-stuttgart.de/spinterp
% ------------------------------------------------------------
	
if nargin < 3, options = []; end
if nargin < 2, d = []; end

gridtype = spget(options, 'GridType', 'Clenshaw-Curtis');
sparseIndices = spget(options, 'SparseIndices', 'auto');
options = spset(options, 'SparseIndices', sparseIndices);

switch lower(gridtype)
 case 'clenshaw-curtis'
	if strcmpi(sparseIndices, 'off')
		wmethod = 'spquadwcc';
	else
		wmethod = 'spquadwccsp';
	end
 case 'maximum'
	wmethod = 'spquadwm';
 case 'noboundary'
	wmethod = 'spquadwnb';
 case 'chebyshev'
	if strcmpi(sparseIndices, 'off')
		wmethod = 'spquadwcb';
	else
		wmethod = 'spquadwcbsp';
	end
	wtype = 'chebweights';
 case 'gauss-patterson'
	if strcmpi(sparseIndices, 'off')
		wmethod = 'spquadwgp';
	else
		wmethod = 'spquadwgpsp';
	end
	wtype = 'gpweights';
 case 'kronrod-patterson-normal'
	if strcmpi(sparseIndices, 'off')
		wmethod = 'spquadwkpn';
	else
		wmethod = 'spquadwkpnsp';
	end
	wtype = 'kpnweights';    
 otherwise
	error('MATLAB:spinterp:badopt',['Unknown grid type ''' gridtype '''.']);
end

% Get the sequence of levels
if ~isempty(d)
	levelseq = spgetseq(n,d,options);
	maxn = n;
else
	% For internal usage: pass sequence of levels directly.
	levelseq = n;
	if (isstruct(levelseq))
		maxn = double(max(levelseq.indicesLevs));
	else
	  maxn = max(levelseq(:));
	end
end

if strcmpi(gridtype, 'chebyshev') || ...
        strcmpi(gridtype, 'gauss-patterson') || ...
        strcmpi(gridtype, 'kronrod-patterson-normal')
	[w1d, id] = feval(wtype, maxn);
	w = feval(wmethod, levelseq, w1d, id);
else
	w = feval(wmethod, levelseq);
end
