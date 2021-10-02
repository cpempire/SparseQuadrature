function x = kpnabsc(level)
% Get abscissae of Kronrod-Patterson-Normal formula
%    (internal function)

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

switch level
 case 0
	x = 0;
 case 1
	x = [0.0000000000000000e+000 1.7320508075688772e+000];
 case 2
    x = [0.0000000000000000e+000 7.4109534999454085e-001 1.7320508075688772e+000 ...
         2.8612795760570582e+000 4.1849560176727323e+000];
 case 3
  x = [0.0000000000000000e+000 7.4109534999454085e-001 1.2304236340273060e+000 ...
       1.7320508075688772e+000 2.5960831150492023e+000 2.8612795760570582e+000 ... 
       3.2053337944991944e+000 4.1849560176727323e+000 5.1870160399136562e+000 ...
       6.3633944943363696e+000];
 case 4
  x = [0.0000000000000000e+000 2.4899229757996061e-001 7.4109534999454085e-001 ... 
       1.2304236340273060e+000 1.7320508075688772e+000 2.2336260616769419e+000 ...
       2.5960831150492023e+000 2.8612795760570582e+000 3.2053337944991944e+000 ...
       3.6353185190372783e+000 4.1849560176727323e+000 4.7364330859522967e+000 ... 
       5.1870160399136562e+000 5.6981777684881099e+000 6.3633944943363696e+000 ... 
       7.1221067008046166e+000 7.9807717985905606e+000 9.0169397898903032e+000];

 otherwise
	error('MATLAB:spinterp:unsupportedLevel',['Maximum supported depth (level 4) ' ... 
	  'exceeded for precomputed nodes of Kronrod-Patterson-Normal grid.']);
end

if level > 0
	x = [-fliplr(x) x(2:end)];
end
