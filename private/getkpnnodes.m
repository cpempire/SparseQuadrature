function x = getkpnnodes(allnx)
% Generate Kronrod-Patterson-Normal nodes for barypdstepkpn
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
            nodes = kpnabsc(0);
        case 3
            nodes = kpnabsc(1);
        case 9
            nodes = kpnabsc(2);
        case 19
            nodes = kpnabsc(3);            
        case 35
            nodes = kpnabsc(4);
        otherwise
            error('KPN implemented only up to level 4')
    end
    x(1+aid:aid+allnx(k)) = nodes;
	aid = aid + allnx(k);
end
