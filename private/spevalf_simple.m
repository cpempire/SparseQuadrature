function [z,x] = spevalf_simple(method,f,levelseq,d,indicesRange, ...
												 range,varpos,vectorized, ... 
												 nresults,functionArgType,data,varargin)
% SPEVALF  Evaluate the objective function at grid nodes
%    (internal function)

% Author : Peng Chen 
% Date   : Feb 5, 2016
val = varargin;

if ~isempty(indicesRange)
	x = feval(method,levelseq,indicesRange(1),indicesRange(2));
else
	x = feval(method,levelseq);
end	

% compute the function values at the grid points
if ~isempty(range)
	v = zeros(size(x));
	for l = 1:d
		v(:,l) = x(:,l) .* (range(l,2)-range(l,1)) + range(l,1);
	end
else
	v = x;
end

res = zeros(size(v,1),1);
for l = 1:size(v,1)
    res(l) = feval(f,v(l,:),data);
end
z{1} = res;
% if strcmp(lower(vectorized), 'on')
% 	v = mat2cell(v,size(v,1),ones(1,d));
% 		
% 	if isempty(varpos)
% 		[z{1:nresults}] = feval(f, v{:}, data, varargin{:});
% 	else
% 		for l = 1:d
% 			val{varpos(l)} = v{l};
% 		end
% 		[z{1:nresults}] = feval(f, val{:}, data);
% 	end
% else
% 	z(1:nresults) = {zeros(size(v,1),1)};
% 	res(1:nresults) = {0};
% 	if isempty(varpos)
% 		if ~strcmp(lower(functionArgType), 'list')
% 			vec = 1;
% 		else
% 			vec = 0;
% 		end
% 		for l = 1:size(v,1)
% 			if ~vec
% 				val = mat2cell(v(l,:), 1, ones(1,d));
% 				[res{1:nresults}] = feval(f, val{:}, data, varargin{:});
% 			else
% 				val = v(l,:);
% 				[res{1:nresults}] = feval(f, val, data, varargin{:});
% 			end
% 			for m = 1:nresults
% 				z{m}(l) = res{m};
% 			end
% 		end
% 	else
% 		for l = 1:size(v,1)
% 			for m = 1:d
% 				val{varpos(m)} = v(l,m);
% 			end
% 			[res{1:nresults}] = feval(f, val{:}, data);
% 			for m = 1:nresults
% 				z{m}(l) = res{m};
% 			end
% 		end
% 	end
% end
% 	
