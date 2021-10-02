function x = gpabsc(level)
% Get abscissae of Gauss-Patterson formula
%    (internal function)

% Author : Andreas Klimke
% Version: 1.0
% Date   : November 18, 2007

% Change log:
% V1.0   : November 18, 2007
%					Initial release.

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
	x = [ 0.77459666924148337704e-0 0.00000000000000000000e-0 ];
 case 2
  x = [ 0.96049126870802028342e-0 0.77459666924148337704e-0 0.43424374934680255800e-0 ...
        0.00000000000000000000e-0 ];
 case 3
  x = [ 0.99383196321275502221e-0 0.96049126870802028342e-0 0.88845923287225699889e-0 ...
	      0.77459666924148337704e-0 0.62110294673722640294e-0 0.43424374934680255800e-0 ...
				0.22338668642896688163e-0 0.00000000000000000000e-0 ];
 case 4
  x = [ 0.99909812496766759766e-0 0.99383196321275502221e-0 0.98153114955374010687e-0 ...
	      0.96049126870802028342e-0 0.92965485742974005667e-0 0.88845923287225699889e-0 ...
        0.83672593816886873550e-0 0.77459666924148337704e-0 0.70249620649152707861e-0 ...
        0.62110294673722640294e-0 0.53131974364437562397e-0 0.43424374934680255800e-0 ...
        0.33113539325797683309e-0 0.22338668642896688163e-0 0.11248894313318662575e-0 ...
        0.00000000000000000000e-0 ];
 case 5
  x = [ 0.99987288812035761194e-0 0.99909812496766759766e-0 0.99720625937222195908e-0 ...
        0.99383196321275502221e-0 0.98868475754742947994e-0 0.98153114955374010687e-0 ...
        0.97218287474858179658e-0 0.96049126870802028342e-0 0.94634285837340290515e-0 ...
        0.92965485742974005667e-0 0.91037115695700429250e-0 0.88845923287225699889e-0 ...
        0.86390793819369047715e-0 0.83672593816886873550e-0 0.80694053195021761186e-0 ...
        0.77459666924148337704e-0 0.73975604435269475868e-0 0.70249620649152707861e-0 ...
        0.66290966002478059546e-0 0.62110294673722640294e-0 0.57719571005204581484e-0 ...
        0.53131974364437562397e-0 0.48361802694584102756e-0 0.43424374934680255800e-0 ...
        0.38335932419873034692e-0 0.33113539325797683309e-0 0.27774982202182431507e-0 ...
        0.22338668642896688163e-0 0.16823525155220746498e-0 0.11248894313318662575e-0 ...
        0.56344313046592789972e-1 0.00000000000000000000e-0 ];
 case 6
  x = [ 0.99998243035489159858e-0 0.99987288812035761194e-0 0.99959879967191068325e-0 ...
        0.99909812496766759766e-0 0.99831663531840739253e-0 0.99720625937222195908e-0 ...
        0.99572410469840718851e-0 0.99383196321275502221e-0 0.99149572117810613240e-0 ...
        0.98868475754742947994e-0 0.98537149959852037111e-0 0.98153114955374010687e-0 ...
        0.97714151463970571416e-0 0.97218287474858179658e-0 0.96663785155841656709e-0 ...
        0.96049126870802028342e-0 0.95373000642576113641e-0 0.94634285837340290515e-0 ...
        0.93832039777959288365e-0 0.92965485742974005667e-0 0.92034002547001242073e-0 ...
        0.91037115695700429250e-0 0.89974489977694003664e-0 0.88845923287225699889e-0 ...
        0.87651341448470526974e-0 0.86390793819369047715e-0 0.85064449476835027976e-0 ...
        0.83672593816886873550e-0 0.82215625436498040737e-0 0.80694053195021761186e-0 ...
        0.79108493379984836143e-0 0.77459666924148337704e-0 0.75748396638051363793e-0 ...
        0.73975604435269475868e-0 0.72142308537009891548e-0 0.70249620649152707861e-0 ...
        0.68298743109107922809e-0 0.66290966002478059546e-0 0.64227664250975951377e-0 ...
        0.62110294673722640294e-0 0.59940393024224289297e-0 0.57719571005204581484e-0 ...
        0.55449513263193254887e-0 0.53131974364437562397e-0 0.50768775753371660215e-0 ...
        0.48361802694584102756e-0 0.45913001198983233287e-0 0.43424374934680255800e-0 ...
        0.40897982122988867241e-0 0.38335932419873034692e-0 0.35740383783153215238e-0 ...
        0.33113539325797683309e-0 0.30457644155671404334e-0 0.27774982202182431507e-0 ...
        0.25067873030348317661e-0 0.22338668642896688163e-0 0.19589750271110015392e-0 ...
        0.16823525155220746498e-0 0.14042423315256017459e-0 0.11248894313318662575e-0 ...
        0.84454040083710883710e-1 0.56344313046592789972e-1 0.28184648949745694339e-1 ...
        0.00000000000000000000e-0 ];
 otherwise
	error('MATLAB:spinterp:unsupportedLevel',['Maximum supported depth (level 6) ' ... 
	  'exceeded for precomputed nodes of Gauss-Patterson grid.']);
end

if level > 0
	x = 0.5 + [-x(1:end-1) fliplr(x)] / 2;
end
