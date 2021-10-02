function w = kpnbaryw(level)
% KPNBARYW   Get the 1D barycentric weights for the
% Kronrod-Patterson-Normal grid.
	
% Author : Peng Chen 
% Version: 1.0
% Date   : November 24, 2015

% ------------------------------------------------------------
% Sparse Grid Interpolation Toolbox
% Copyright (c) 2006 W. Andreas Klimke, Universitaet Stuttgart 
% Copyright (c) 2007-2008 W. A. Klimke. All Rights Reserved.
% See LICENSE.txt for license. 
% email: klimkeas@ians.uni-stuttgart.de
% web  : http://www.ians.uni-stuttgart.de/spinterp
% ------------------------------------------------------------

switch level
 case 0
	w = 1;
 case 1
  w = [-1.0000000000000000e+00	5.0000000000000000e-01];
 case 2
  w = [1.0000000000000000e+00	-6.7730254783341959e-01	2.1341463414634154e-01 ...
      -3.9049016894082814e-02	2.9369305811607523e-03];	
 case 3
  w = [-7.7823017780097248e-01	9.8460713073893469e-01	-1.0000000000000000e+00	...
        5.2353985483716703e-01	-3.4326819807146414e-01	2.8473101197424572e-01	...
       -6.1433927694495655e-02	9.6923686006837508e-04	-3.0451471615723722e-05	...
       4.3172764617279589e-07];	
 case 4 
  w = [-1.0000000000000000e+00	6.3409961931796655e-01	-2.0206421597223853e-01	...
        1.0765964626357427e-01	-6.7851282029721918e-02	6.0034222366008770e-02	...
        -6.0419069861815097e-02	3.6671973144990516e-02	-9.3890035731640665e-03	...
        1.3853720673220125e-03	-1.4402946398702312e-04	1.9728086959563470e-05	...
        -3.2042811630474236e-06	2.5166946366704187e-07	-7.8942199042518391e-09	...
        1.6189959434932987e-10	-1.8828644113435187e-12	7.1733533944546879e-15];
 otherwise
	error('MATLAB:spinterp:unsupportedWeights',['Maximum depth (level 4) ' ... 
	   'exceeded for barycentric weights of Kronrod-Patterson-Normal grid.']);
end

if level > 0
	w = [fliplr(w),w(2:end)];
end
