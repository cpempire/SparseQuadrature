function x = ghabsc(level)
% Get abscissae of Gauss-Hermite formula
%    (internal function)

% Author : Peng Chen
% Version: 1.0
% Date   : January 21, 2016

% ------------------------------------------------------------
% Sparse Grid Interpolation Toolbox
% Copyright (c) 2006 W. Andreas Klimke, Universitaet Stuttgart 
% Copyright (c) 2007-2008 W. A. Klimke. All Rights Reserved.
% See LICENSE.txt for license. 
% email: klimkeas@ians.uni-stuttgart.de
% web  : http://www.ians.uni-stuttgart.de/spinterp
% ------------------------------------------------------------

x = sqrt(2)*GaussHermite(level+1);
