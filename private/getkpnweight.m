function w = getkpnweight(ndims,dimvec,oldndims,olddimvec,newlevel,oldlevel)
% Generate Kronrod-Patterson-Normal weights for subquadraturekpn
%    (internal function)

% Author : Peng Chen 
% Version: 1.0
% Date   : December 7, 2015

% Change log:
% V1.0   : December 7, 2015
%					Initial release.

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

w = 1;
for inew = ndims:-1:1
%     w = kron(w,getweights(oldlevel(iold),newlevel(dimold(iold))));
    iold = find(olddimvec(1:oldndims) == dimvec(inew));
    if isempty(iold)
        ioldlevel = 0;
    else
        ioldlevel = oldlevel(iold);
    end
    weight = getweights(ioldlevel,newlevel(inew));
    nw = length(weight);
    for iw = 1:length(w) 
        x((iw-1)*nw+1:iw*nw) = w(iw)*weight;
    end
    w = x;
end

function w = getweights(oldlevel,newlevel)

switch newlevel
 case 0
	w = 1;
 case 1
	w = [1.6666666666666669e-01 6.6666666666666674e-01 1.6666666666666669e-01];
%     w = [w, w(end-1:-1:1)];
    switch oldlevel
        case 0
            w = w([2]);
        case 1 
            w = w([1,3]);
        otherwise
            error('wrong weight')
    end
 case 2
	w = [9.4269457556517470e-05 7.9963254708935293e-03 9.4850948509485125e-02 ...
         2.7007432957793776e-01 2.5396825396825407e-01];
     w = [w, w(end-1:-1:1)];
     switch oldlevel
        case 0
            w = w([5]);
        case 1 
            w = w([3,7]); 
        case 2 
            w = w([1,2,4,6,8,9]);
        otherwise
            error('wrong weight')            
     end
 case 3
	w = [8.6296846022298611e-10 6.0948087314689830e-07 6.0123369459847983e-05 ...
         2.8848804365067555e-03 -6.3372247933737554e-03 1.8085234254798459e-02 ...
         6.4096054686807596e-02 6.1151730125247702e-02 2.0832499164960872e-01 ...
         3.0346719985420617e-01];
     w = [w, w(end-1:-1:1)];
     switch oldlevel
        case 0
            w = w([10]);
        case 1 
            w = w([7,13]);
        case 2
            w = w([3,5,9,11,15,17]); 
        case 3
            w = w([1,2,4,6,8,12,14,16,18,19]);
        otherwise
            error('wrong weight')               
     end
 case 4
	w = [1.0541326582334017e-18 5.4500412650638144e-15 3.0972223576063007e-12 ...
         4.6011760348655932e-10 2.1394194479561069e-08 2.4676421345798151e-07 ...
         2.7342206801187897e-06 3.5729348198975346e-05 2.7524214116785142e-04 ...
         8.1895392750226767e-04 2.3113452403522080e-03 3.1554462691875521e-03 ...
         1.5673473751851158e-02 4.5273685465150405e-02 9.2364726716986381e-02 ...
         1.4807083115521591e-01 1.9176011588804440e-01 5.1489450806921399e-04];
     w = [w, w(end-1:-1:1)];
      switch oldlevel
          case 0
              w = w([18]);
          case 1 
              w = w([14,22]);
          case 2 
              w = w([8,11,16,20,25,28]);
          case 3
              w = w([4,6,10,12,15,21,24,26,30,32]);
          case 4
              w = w([1,2,3,5,7,9,13,17,19,23,27,29,31,33,34,35]);
        otherwise
            error('wrong weight')               
     end              
              
 otherwise
	error('MATLAB:spinterp:unsupportedWeights',['Maximum depth (level 4) ' ... 
	  'exceeded for precomputed weights of Kronrod-Patterson-Normal grid. Using all-zero ' ...
		'weights for levels > 4.']);
end





