function [weights, startid] = kpnweights(maxlev)
% KPNWEIGHTS   Get the 1D integration weights for the
% Kronrod-Patterson-Normal grid.
	
% Author : Peng Chen
% Version: 1.0
% Date   : November 25, 2015

% ------------------------------------------------------------
% Sparse Grid Interpolation Toolbox
% Copyright (c) 2006 W. Andreas Klimke, Universitaet Stuttgart 
% Copyright (c) 2007-2008 W. A. Klimke. All Rights Reserved.
% See LICENSE.txt for license. 
% email: klimkeas@ians.uni-stuttgart.de
% web  : http://www.ians.uni-stuttgart.de/spinterp
% ------------------------------------------------------------

% Determine size of weights vector
nset = [1,2,6,10,16];
n = 0;
for lev = 1:maxlev+1
	n = n + nset(lev);
end
weights = zeros(n, 1);
startid = zeros(maxlev+1,1);
wid = 0;

for lev = 0:maxlev
	w = getweights(lev);
	nw = length(w);
	weights(wid+1:wid+nw) = w;
	startid(lev+1) = wid + 1;
	wid = wid + nw;
	if lev > 0
		weights(wid+1:wid+nw) = w(end:-1:1);
		wid = wid + nw;
	end
end

% ------------------------------------------------------------
function w = getweights(level)

switch level
 case 0
	w = 1;
 case 1
	w = 1.6666666666666669e-01;
 case 2
	w = [9.4269457556517470e-05	7.9963254708935293e-03 2.7007432957793776e-01];
 case 3
	w = [8.6296846022298611e-10	6.0948087314689830e-07	2.8848804365067555e-03 ...
        1.8085234254798459e-02	6.1151730125247702e-02];
 case 4
	w = [1.0541326582337528e-18	5.4500412650638428e-15	3.0972223576062983e-12 ...
        2.1394194479561059e-08	2.7342206801187888e-06	2.7524214116785147e-04 ...
        1.5673473751851161e-02	1.9176011588804442e-01];
 otherwise
	error('MATLAB:spinterp:unsupportedWeights',['Maximum depth (level 4) ' ... 
	  'exceeded for precomputed weights of Kronrod-Patterson-Normal grid. Using all-zero ' ...
		'weights for levels > 4.']);
end