function weights = kpnfullweights(level)
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
% level = double(level);
wid = 0;
for lev = 1:length(level)
	w = getweights(level(lev));
	nw = length(w);
	weights(wid+1:wid+nw) = w;
	wid = wid + nw;
end

% ------------------------------------------------------------
function w = getweights(level)

switch level
 case 0
	w = 1;
 case 1
	w = [1.6666666666666669e-01 6.6666666666666674e-01];
 case 2
	w = [9.4269457556517470e-05 7.9963254708935293e-03 9.4850948509485125e-02 ...
         2.7007432957793776e-01 2.5396825396825407e-01];
 case 3
	w = [8.6296846022298611e-10 6.0948087314689830e-07 6.0123369459847983e-05 ...
         2.8848804365067555e-03 -6.3372247933737554e-03 1.8085234254798459e-02 ...
         6.4096054686807596e-02 6.1151730125247702e-02 2.0832499164960872e-01 ...
         3.0346719985420617e-01];
 case 4
	w = [1.0541326582334017e-18 5.4500412650638144e-15 3.0972223576063007e-12 ...
         4.6011760348655932e-10 2.1394194479561069e-08 2.4676421345798151e-07 ...
         2.7342206801187897e-06 3.5729348198975346e-05 2.7524214116785142e-04 ...
         8.1895392750226767e-04 2.3113452403522080e-03 3.1554462691875521e-03 ...
         1.5673473751851158e-02 4.5273685465150405e-02 9.2364726716986381e-02 ...
         1.4807083115521591e-01 1.9176011588804440e-01 5.1489450806921399e-04];
 otherwise
	error('MATLAB:spinterp:unsupportedWeights',['Maximum depth (level 4) ' ... 
	  'exceeded for precomputed weights of Kronrod-Patterson-Normal grid. Using all-zero ' ...
		'weights for levels > 4.']);
end

w = [w, w(end-1:-1:1)];