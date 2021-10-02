function x = getkpnbaryw(allnx)
% Generate Kronrod-Patterson-Normal weights for barypdstepkpn
%    (internal function)

% Author : Peng Chen 
% Version: 1.0
% Date   : November 24, 2015

% Change log:
% V1.0   : November 24, 2015
%					Initial release.

% ------------------------------------------------------------
% Sparse Grid Interpolation Toolbox
% Copyright (c) 2006 W. Andreas Klimke, Universitaet Stuttgart 
% Copyright (c) 2007-2008 W. A. Klimke. All Rights Reserved.
% See LICENSE.txt for license. 
% email: klimkeas@ians.uni-stuttgart.de
% web  : http://www.ians.uni-stuttgart.de/spinterp
% ------------------------------------------------------------

d = uint8(length(allnx));
x = zeros(sum(allnx),1);

aid = uint32(0);
for k = 1:d
    switch allnx(k)
        case 1
            weights = kpnbaryw(0);
        case 3
            weights = kpnbaryw(1);
        case 9
            weights = kpnbaryw(2);
        case 19
            weights = kpnbaryw(3);            
        case 35
            weights = kpnbaryw(4);
        otherwise
            error('KPN implemented only up to level 4')
    end
    x(1+aid:aid+allnx(k)) = weights;
	aid = aid + allnx(k);
end
