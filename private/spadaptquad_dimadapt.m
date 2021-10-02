function z = spadaptquad_dimadapt(f, d, range, options, data, varargin)
% SPADAPTVALS   Compute hierarchical surpluses dimension-adaptively
% Computes the sparse grid representation of a function using 
% dimension-adaptive sparse grids. The calling options are identical 
% to SPVALS (internal function).

% Author : Peng Chen, ICES
% V1.0 : Dec 7, 2015

% ------------------------------------------------------------
% Sparse Grid Interpolation Toolbox
% Copyright (c) 2006 W. Andreas Klimke, Universitaet Stuttgart 
% Copyright (c) 2007-2008 W. A. Klimke. All Rights Reserved.
% See LICENSE.txt for license. 
% email: klimkeas@ians.uni-stuttgart.de
% web  : http://www.ians.uni-stuttgart.de/spinterp
% ------------------------------------------------------------

% CONSTANTS
RESIZE_FACTOR = 1.5;
MAX_X_SIZE = 1e7;

dtotal = uint16(d);
d = uint16(1);

if nargin < 3, range = []; end
if nargin < 4, options = []; end
if nargin < 5, varargin = {}; end

vectorized = spget(options, 'Vectorized', 'off');
zprev = spget(options, 'PrevResults');
varpos = spget(options, 'VariablePositions');
nresults = spget(options, 'NumberOfOutputs', 1);
reltol = spget(options, 'RelTol', 1e-2);
abstol = spget(options, 'AbsTol', 1e-6);
gridtype = spget(options, 'GridType', 'Clenshaw-Curtis');
functionArgType = spget(options, 'FunctionArgType', 'list');
keepFunctionValues = spget(options, 'KeepFunctionValues', 'off');
keepGrid = spget(options, 'KeepGrid', 'off');
minPoints = spget(options, 'MinPoints', 100);
maxPoints = spget(options, 'MaxPoints', 10000);
problemType = spget(options, 'ProblemType', 'interpolation');
verification = spget(options, 'Verification', 'off');
keepWeight = spget(options, 'KeepWeight', 'off');
distributionType = spget(options, 'DistributionType', 'uniform');

if strcmpi(gridtype, 'gauss-patterson') 
	nmax = spget(options, 'MaxDepth', 6);
	if nmax > 6
		warning('MATLAB:spinterp:badopt',['Maximum supported depth ' ...
		  'level for the Gauss-Patterson grid is 6, but MaxDepth ' ...
			'was set to ' num2str(nmax) '. Using MaxDepth = 6 instead.']);
		nmax = 6;
	end
elseif strcmpi(gridtype, 'chebyshev')
  nmax = spget(options, 'MaxDepth', 10);
	if nmax > 10
		warning('MATLAB:spinterp:badopt',['Maximum supported depth ' ...
		  'level for the Chebyshev grid is 10, but MaxDepth ' ...
			'was set to ' num2str(nmax) '. Using MaxDepth = 10 instead.']);
		nmax = 10;
    end
elseif strcmpi(gridtype, 'kronrod-patterson-normal')
  nmax = spget(options, 'MaxDepth', 4);
	if nmax > 4
		warning('MATLAB:spinterp:badopt',['Maximum supported depth ' ...
		  'level for the kronrod-patterson-normal grid is 4, but MaxDepth ' ...
			'was set to ' num2str(nmax) '. Using MaxDepth = 4 instead.']);
		nmax = 4;
	end    
else
  nmax = 255;
end
maxDepth = nmax;

enableDCT = spget(options, 'EnableDCT', 'on');
w = spget(options, 'DimadaptDegree', 0.9);
strat = spget(options, 'DegreeStrategy', 'balancing');
if strcmpi(strat, 'balancing'), isps = 1; else isps = 0; end

isgp = 0;
iskpn = 0;
isgh = 0;
switch lower(gridtype)
 case 'clenshaw-curtis'
  ipmethod = 'spcmpvalsccsp';
  gridgen = 'spgridccsp';
  wgen    = 'spquadwccspadapt';
 case 'chebyshev'
	if strcmpi(enableDCT, 'off')
		ipmethod = 'spcmpvalscbsp';
	else
		ipmethod = 'spcmpvalscbspdct';
	end			
  gridgen = 'spgridcbsp';
  wgen    = 'spquadwcbspadapt';
  wtype   = 'chebweights';
 case 'gauss-patterson'
  ipmethod = 'spcmpvalsgpsp';
  gridgen = 'spgridgpsp';
  wgen    = 'spquadwgpspadapt';
  wtype   = 'gpweights';
	isgp = 1;
 case 'kronrod-patterson-normal'
  ipmethod = 'spcmpvalskpnsp';
  gridgen = 'spgridkpnsp';
  wgen    = 'spquadwkpnspadapt';
  wtype   = 'kpnweights';
	iskpn = 1;        
 case 'gauss-hermite'
  ipmethod = 'spcmpvalsghsp';
  gridgen = 'spgridghsp';
  wgen    = 'spquadwghspadapt';
  wtype   = 'ghweights';
	isgh = 1;      
end

% Initialize time and feval counters
fevalTime = 0;
surplusCompTime = 0;
ntotalpoints = 0;

if minPoints > maxPoints
  minPoints = maxPoints;
end

min_nd = min(maxDepth, double(dtotal));

% shift the interpolation parameters to the right position, and
% fill field up with any parameters in varargin.
val = posvars(d, varpos, varargin{:});

if isempty(zprev)
  % Allocate some memory for the index set arrays; this is resized
  % as necessary.
  maxind = max(10, floor(65536/double(d)));
  maxforwardind = max(10, floor(65536/double(d)));
  
  % Vector to store maximum level in each dimension
  maxlevel = zeros(1,d);
  
  % Indices data
  indicesNDims = zeros(maxind,1,'uint8');
  indicesDims  = zeros(maxind*min_nd,1,'uint16');
  indicesLevs  = zeros(maxind*min_nd,1,'uint8');
  indicesAddr  = zeros(maxind,1,'uint32');
  
  % Neighbor data
  backward     = zeros(maxind*min_nd,1,'uint32');
  forwardAddr  = zeros(maxind,1,'uint32');
  forward      = zeros(maxforwardind,dtotal,'uint32');
  
  % Indicate active/passive indices (only necessary for
  % construction of the grid)
  active       = false(maxind,1);
  % Array containing ID's of active indices, ordered by error/number of
  % points  
  A            = zeros(maxind,1,'uint32');
  Ap           = zeros(maxind,1,'uint32');
  
  % Store start adresses of a sub-grid in the support node array
  ptsaddr      = zeros(maxind,1, 'uint32');  
  ptslen       = zeros(maxind,1, 'uint32');
  
  % Initialize with first index; There are no values to be inserted
  % in the indices array, since the first index is (0,...,0). (We
  % start from 0 -- this also results in the sparse structure of
  % the array).
  currentindex = uint32(1);
  
  % Global error indicator
  Emaxk = zeros(nresults,maxind);
  Emeank = zeros(nresults,maxind);
  G = zeros(maxind,1);
  
  % Conventional sparse grid ordering
  G2 = zeros(maxind,1);
  
  % number of active index sets
  na = uint32(1);
  nap = uint32(1);
  % number of index sets 
  nindexIter = uint32(1);
  nindex = nindexIter;
  
  % total number of index sets
  ni = uint32(1);
  
  % number of forward neighbor sets
  nfi = uint32(0);
  
  % Initialize the index set data for the first index
  indicesNDims(1)  = 0;
  indicesAddr(1)   = 1;
  addr             = 1;
  ptslen(1)        = 1;
  ptsaddr(1)       = 1;
  active(1)        = true;
  A(1)             = 1;
  Ap(1)            = 1;
  
  % set initial errors to infinity
  E(:,1) = inf * ones(nresults,1);
  G(1) = inf;
  G2(1) = 1;
  accuracy = inf;
  absaccuracy = inf;
  
  levelseq = struct('indicesNDims', indicesNDims, ...
        'indicesDims', indicesDims, ...
        'indicesLevs', indicesLevs, ...
        'indicesAddr', indicesAddr, ...
        'forwardAddr', forwardAddr, ...
        'forwardNeighbors', forward, ...
        'backwardNeighbors', backward, ...
        'subGridPoints', ptslen, ...
        'subGridAddr', ptsaddr);
  
  % Compute new function values for first index set
  t0 = clock;
  
  z = cell(nresults,1);
  [z(1:nresults), x] = ...
      spevalf(gridgen, f, levelseq, d, ...
        [currentindex, currentindex], ...
        range, varpos, vectorized, nresults, ...
        functionArgType,data,val{:}); 

  for l = 1:nresults
    Emaxk(l,1) = z{l,1};
    Emeank(l,1) = z{l,1};      
    Emean{l}= z{l,1};
    Mean{l} = z{l,1};
  end
  
  if strcmpi(keepFunctionValues, 'on')
    y = z;
  end
  if strcmpi(keepGrid, 'on')
      % Rescale sparse grid to actual range
      if ~isempty(range)
        for l = 1:d
          x(:,l) = range(l,1)+(range(l,2)-range(l,1)).*x(:,l);
        end
      end
  end
  if  strcmpi(keepWeight, 'on')
      % Compute quadrature weight 
      weight = 1;
  end
  fevalTime = fevalTime + etime(clock,t0);
  
  ntotalpoints = ntotalpoints + ptsaddr(1);
  nadaptpoints = ntotalpoints; % uint32(0);
  maxsetpoints = 0;
  oldpoints = ntotalpoints;  
  allpoints = ntotalpoints;
  % Since the initial subgrid contains only a single point, it is
  % clear that zmin = z and zmax = z;
  zmin = cell2mat(z);
  zmax = cell2mat(z);
  xmin = repmat(x,nresults,1);
  xmax = xmin;
  
else
  % get previous results
  d = uint16(zprev.d);


  z = zprev.vals;
  if  strcmpi(keepWeight, 'on')
      weight = zprev.weight;
  end
  gridtype = zprev.gridType;
  if isfield(zprev, 'fvals')
    y = zprev.fvals;
  end
  if isfield(zprev, 'grid')
    x = zprev.grid{1};
  end
  ntotalpoints = zprev.nPoints;
  nadaptpoints = uint32(zprev.dimadaptDegree * double(zprev.nPoints));
  oldpoints = zprev.oldpoints;
  allpoints = zprev.allpoints;
% 	if isps
% 		if isfield(zprev, 'dimadaptDegree')
% 			nadaptpoints = uint32(zprev.dimadaptDegree * double(zprev.nPoints));
%         else
% 		    nadaptpoints = uint32(0);
% 		end
% 	end
  if ntotalpoints >= maxPoints
    maxPoints = ntotalpoints + 1;
  end
  % Indices data
  indicesNDims = zprev.indices.indicesNDims;
  indicesDims  = zprev.indices.indicesDims;
  indicesLevs  = zprev.indices.indicesLevs;
  indicesAddr  = zprev.indices.indicesAddr;
  
  % Neighbor data
  backward     = zprev.indices.backwardNeighbors;
  forwardAddr  = zprev.indices.forwardAddr;
  forward      = zprev.indices.forwardNeighbors;
  
  % Indicate active/passive indices (only necessary for
  % construction of the grid)
  active       = zprev.indices.active;
  
  % Store start adresses of a sub-grid in the support node array
  ptsaddr      = zprev.indices.subGridAddr;
  ptslen       = zprev.indices.subGridPoints;

  ni = size(indicesAddr,1);
  maxind = double(ni);
  
  nfi = size(forward,1);
  maxforwardind = nfi;
  
  maxlevel = zprev.maxLevel;
  
  na = size(zprev.activeIndices,1);
  nap = size(zprev.activeIndices2,1);
  nindex = zprev.nindex;
  nindexIter = zprev.nindexIter;  
  A = zprev.activeIndices;
  Ap = zprev.activeIndices2;
  
  G = zprev.G;
  G2 = zprev.G2;
  Emeank = zprev.Emeank;
  Emean= zprev.Emean;
  Mean = zprev.Mean;

  zmin = zprev.fevalRange(:,1);
  zmax = zprev.fevalRange(:,2);
  xmin = zprev.minGridVal;
  xmax = zprev.maxGridVal;
  
  maxsetpoints = zprev.maxSetPoints;
  
  accuracy = zprev.estRelError;
  absaccuracy = zprev.estAbsError;
end

% Initialize array of maximum surpluses
maxsurplus = zeros(nresults,1);

% Initialize array of maximum error indicators
indicator = zeros(nresults,1);

% Allocate some temporary arrays
bn    = zeros(d,1,'uint32'); % 
bdim  = zeros(d,1,'uint16');
bid   = zeros(d,1,'uint32');

success = 0;
atleastonestep = 0;

while (ntotalpoints < maxPoints) && ~success
    disp(['ntotalpoints = ',num2str(ntotalpoints)]) 

    % Get next active index to process
    done = 0;
    while ~done
          % Check if conventional rule or error indicator governs next step of the algorithm
          pickedIndex = false;
          pickedAdaptive = false;
          if nap > 0
                if (~isps && 1/G2(Ap(1)) < (1-min(max(w,0),1)) * maxsetpoints) || ...
                     (isps && nadaptpoints >= (min(max(w,0),1)) * ntotalpoints)
                    [currentindex, Ap] = popheap(Ap, double(nap), G2);
                    pickedIndex = true;
                    nap = nap - 1;
                end
          end

          if ~pickedIndex
            % Put active index with maximum error into old index set
                if na > 0
                      [currentindex, A] = popheap(A, double(na), G);
                      pickedIndex = true;
                      pickedAdaptive = true;
                      na = na - 1;
                end
          end

          if ~pickedIndex
          % No more active index based on error available
              if nap > 0
                  [currentindex, Ap] = popheap(Ap, double(nap), G2);
                  pickedIndex = true;
                  nap = nap - 1;
              end
          end

          if ~pickedIndex
          % No more indices at all available!
              break;
          end

          % Check if still an active index (index may have been processed already due to other criterium)
          if active(currentindex) == true
              done = 1;
          end
    end

    if ~done, break; end

    currentaddr = indicesAddr(currentindex);
    dold = d;
    if indicesDims(currentaddr) == d
        if indicesLevs(currentaddr) == 1
            if d < dtotal
                d = d + 1;
                bn    = zeros(d,1,'uint32'); 
                bdim  = zeros(d,1,'uint16');
                bid   = zeros(d,1,'uint32');
                maxlevel = [maxlevel,1];
            end
        end
    end
    
    
    % indicate old index set
    active(currentindex) = false;

    nfi = nfi + 1;
    % Resize forward neighbor array if necessary
    if nfi > maxforwardind
          maxforwardind = ceil(maxforwardind * RESIZE_FACTOR);
          addind = maxforwardind - size(forward, 1);
          forward = [forward; zeros(addind,dtotal,'uint32')];
    end
    forwardAddr(currentindex) = nfi;

    % Get all the backward neighbors
    nbid = indicesNDims(currentindex);
    tmpaddr = indicesAddr(currentindex);
    j = uint8(1);
	
    % Corrected bug: initialization of level vector was missing!
    level = zeros(d,1,'uint8');

    while j <= nbid
        bdim(j)  = indicesDims(tmpaddr);
        bid(j)   = backward(tmpaddr);
        level(bdim(j)) = indicesLevs(tmpaddr);
        tmpaddr = tmpaddr + 1;
        j = j + 1;
    end
  
    i = uint16(1);
  
    % Resize arrays if necessary
    if ni+uint32(d) > maxind + 1
        maxind = ceil(maxind * RESIZE_FACTOR);
        addind = max(double(d), double(maxind) - size(indicesNDims, 1));
        maxind = uint32(size(indicesNDims,1) + addind);

        indicesNDims = [indicesNDims; zeros(addind,1,'uint8')];
        indicesDims  = [indicesDims; zeros(addind*min_nd,1,'uint16')];
        indicesLevs  = [indicesLevs; zeros(addind*min_nd,1,'uint8')];
        indicesAddr  = [indicesAddr; zeros(addind,1,'uint32')];

        % Neighbor data
        backward     = [backward; zeros(addind*min_nd,1,'uint32')];
        forwardAddr  = [forwardAddr; zeros(addind,1,'uint32')];

        % Store start adresses of a sub-grid in the support node array
        ptsaddr      = [ptsaddr; zeros(addind,1, 'uint32')];
        ptslen       = [ptslen; zeros(addind,1, 'uint32')];

        % Indicate active/passive indices
        active       = [active; false(addind,1)];

        % Array containing ID's of active indices, ordered by 
        % error/number of points
        A            = [A; zeros(addind,1,'uint32')];
        Ap           = [Ap; zeros(addind,1,'uint32')];
        Emeank       = [Emeank zeros(nresults, addind)];
        G            = [G; zeros(addind, 1)];
        G2           = [G2; zeros(addind, 1)];
    end
            
    niold = ni;
    while i <= d
	    % check if maximum depth is exceeded
		if level(i) + 1 > maxDepth
            i = i + 1;
            continue;
        end
			
        % check if a new index in direction l is admissible
        isadmissible = true;

        j = uint8(1);
        while j <= nbid
              if i == d && d - dold == 1
                 break;
              end
              if i == bdim(j) 
                j = j + 1;
                continue; 
              end
              forwardid = forwardAddr(bid(j));
              if forwardid == 0
                isadmissible = false;
                break;
              end
              backofnew = forward(forwardid,i);
              if backofnew == 0
                isadmissible = false;
                break;
              elseif active(backofnew)
                isadmissible = false;
                break;
              else
                bn(bdim(j)) = backofnew;
              end
              j = j + 1;
        end
    
        if isadmissible
              atleastonestep = 1;
              bn(i) = currentindex;
              addr = indicesAddr(ni)+uint32(indicesNDims(ni));
              ni = ni + 1;

              indicesAddr(ni) = addr;

              if maxlevel(i) < level(i) + 1;
                maxlevel(i) = level(i) + 1;
              end

              if nbid == 0 || (i == d && d-dold == 1)
                    nnewdims = uint8(1);
                    indicesDims(addr) = i;
                    indicesLevs(addr) = uint8(1);
                    if (i == d && d-dold == 1)
                        bn(i) = uint32(1);
                    end
                    backward(addr) = bn(i);
                    forward(forwardAddr(bn(i)),i) = ni;
                    npoints = uint32(2);
                    addr = addr + 1;
                    nisum = 1;
              else
                    j = uint8(1);
                    insert = true;
                    nnewdims = uint8(0);
                    npoints = uint32(1);
                    nisum = 0;
                    nbidtemp = nbid;   % use temporary variable, since nbid
                                       % must not change; it is not updated in
                                       % case other admissible indices are
                                       % found! 
                    while j <= nbidtemp
                          nnewdims = nnewdims + 1;
                          id = bdim(j);
                          if i > id
                                lev = level(id);
                                j  = j + 1;
                                if insert && j > nbidtemp
                                  bdim(nbidtemp+1) = i;
                                  level(i) = 0;
                                  nbidtemp = nbidtemp + 1;
                                end
                          elseif i == id
                                insert = false;
                                lev = level(id) + 1;
                                j = j + 1;
                          elseif insert
                                insert = false;
                                lev = uint8(1);
                                id = i;
                          else
                                lev = level(id);
                                j = j + 1;
                          end

                          forward(forwardAddr(bn(id)),id) = ni;
                          indicesDims(addr) = id;
                          indicesLevs(addr) = lev;
                          backward(addr) = bn(id);

                          % Compute the number of gridpoints
                          if isgp == 1
                                npoints = npoints * 2^uint32(lev);
                          elseif iskpn == 1
                              if lev == 0
                                  npoints = npoints*uint32(1);
                              else
                                  kpnpoints = uint32([2,6,10,16]);
                                  npoints = npoints*kpnpoints(lev);
                              end
                          elseif isgh == 1
                              npoints = npoints * uint32(lev+1);    
                          else
                                if lev < 3
                                    npoints = npoints * 2;
                                else
                                    npoints = npoints * 2^uint32(lev-1);
                                end
                          end

                          % Compute index sum
                          nisum = nisum + double(lev);

                          addr = addr + 1;
                    end
               end
              indicesNDims(ni) = nnewdims;
              ptslen(ni) = npoints;
              ptsaddr(ni) = ptsaddr(ni-1) + ptslen(ni-1);    
              active(ni) = true;
              ntotalpoints = ntotalpoints + npoints;
              
              if pickedAdaptive 
                  nadaptpoints = nadaptpoints + npoints; 
              end

              % update current maximum number of points per index set
              maxsetpoints = max(maxsetpoints, nisum);

              % update second error indicator 
              G2(ni) = 1./double(nisum);
         end
         i = i + 1;
    end

    if ni > niold
        levelseq = struct('indicesNDims', indicesNDims, ...
                          'indicesDims', indicesDims, ...
                          'indicesLevs', indicesLevs, ...
                          'indicesAddr', indicesAddr, ...
                          'forwardAddr', forwardAddr, ...
                          'forwardNeighbors', forward, ...
                          'backwardNeighbors', backward, ...
                          'subGridPoints', ptslen, ...
                          'subGridAddr', ptsaddr);
    
		kend = niold;
        while kend < ni
            % Compute new function values for new index sets
            t0 = clock;

            psize = 0;
            kstart = kend+1;
            while psize < MAX_X_SIZE && kend < ni 
                psize = psize + ptslen(kend) * double(d);
                kend = kend + 1;
            end
			[znew(1:nresults), xnew] = ...
					spevalf(gridgen, f, levelseq, d, [kstart, kend], ...
									range, varpos, vectorized, nresults, ...
									functionArgType,data,val{:});
            
			if strcmpi(keepFunctionValues, 'on')
				for l = 1:nresults
					y{l} = [y{l}; znew{l}];
				end
			end
    
			if strcmpi(keepGrid, 'on')
				% Rescale sparse grid to actual range
				xnew2 = xnew;
                if ~isempty(range)
                    for l = 1:d
                        xnew2(:,l) = range(l,1)+(range(l,2)-range(l,1)).*xnew2(:,l);
                    end
                end
				x = [x; xnew2];
			end
    
			fevalTime = fevalTime + etime(clock,t0);
			for l = 1:nresults
				[temp, id] = min(znew{l}(:));
				if temp < zmin(l)
					zmin(l) = temp;
					xmin(l,:) = xnew(id,:);
				end
				[temp, id] = max(znew{l}(:));
				if temp > zmax(l)
					zmax(l) = temp;
					xmax(l,:) = xnew(id,:);
				end
			end

            t0 = clock;
            for l = 1:nresults
                Emeank(l,kstart:kend) = computequadsurplus(d,y{l},levelseq,kstart,kend,iskpn,isgh);
            end
            surplusCompTime = surplusCompTime + etime(clock,t0);
            
            for k = kstart:kend      
				G(k) = max(abs(Emeank(:,k)));

				% add new index to the set of active indices
				na = na + 1;
				A(na) = k;
				A = sortheap(A, double(na), G);
				nap = nap + 1;
                nindexIter = nindexIter + 1;
				Ap(nap) = k;
				Ap = sortheap(Ap, double(nap), G2);
            end
            
			for l = 1:nresults
				z{l} = [z{l}; znew{l}];
            end
        end
    end
  

	% Compute new error only if any new indices were added, and if we know
	% the algorithm could abort after this step.
    if ni > niold && (ntotalpoints >= minPoints || all(maxlevel == maxDepth))        
       if strcmpi(problemType, 'integration')
           maxsurplus = zeros(1,nresults);
           for l = 1:na
               if active(A(l)) == true
                   for l2 = 1:nresults
                        maxsurplus(l2) = maxsurplus(l2) + Emeank(l2,A(l));
                   end
               end
           end
           accuracy = max(abs(maxsurplus)./(zmax-zmin));
           absaccuracy = max(abs(maxsurplus));
       end

        % break if desired relative accuracy is reached, or if desired
        % absolute tolerance is reached, but only if the minimum number
        % of levels have been computed. Do this over all accuracies
        % in the active set.
        if (accuracy <= reltol || absaccuracy <= abstol)
            if atleastonestep, success = 1; end
        end
    end    

%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % record data after increase the active index  
%     if ntotalpoints ~= 1 
%         points = [points, ntotalpoints];
        if currentindex ~= 1
            oldpoints = [oldpoints,oldpoints(end)+ptslen(currentindex)];
        end
        allpoints = [allpoints,ntotalpoints];
        nindex = [nindex,nindexIter];
        if strcmpi(problemType, 'integration')
            % error estimate for the integration error 
            for l = 1:nresults
                Emean{l} = [Emean{l}, sum(Emeank(l,(active==1)))];
                Mean{l} = [Mean{l},sum(Emeank(l,1:nindexIter))];
            end    
        end    
%     end
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      
%% end of the adaptive construction
end

if ~atleastonestep
      warning('MATLAB:spinterp:maxDepthReached', ...
              ['No more active indices left, returning previous result. ' ...
                         'Restart the calculation with a higher MaxDepth ' ...
                         'setting.']);
      if ~isempty(zprev)
          z = zprev;
          return;
      end
end

if ~success
      if ntotalpoints >= maxPoints
            warning('MATLAB:spinterp:maxPointsReached', ...
                   ['Current number of support nodes nPoints = ' ...
                    num2str(ntotalpoints) ':' ...
                    ' MaxPoints = ' num2str(maxPoints) ...
                    ' reached before accuracies' ...
                            ' RelTol = ' num2str(reltol) ' or AbsTol = ' num2str(abstol) ...
                            ' were achieved.\nThe current' ...  
                            ' estimated relative accuracy is ' num2str(accuracy) ...
                            '. Increase maximum number of allowable points MaxPoints' ...
                    ' to further refine the interpolant. ']);
      else
            warning('MATLAB:spinterp:maxDepthReached', ...
                    ['No more active indices left. Restart the calculation ' ...
                                 'with a higher MaxDepth setting to further refine the ' ...
                                 'interpolant.']);
      end
end

% Store results in structure
ztemp = z;
clear z;
z.vals = ztemp;
% if  strcmpi(keepWeight, 'on')
%     z.weight = weight;
% end
z.gridType = gridtype;
z.d = double(d);
z.range = range;
z.estRelError = accuracy;
z.estAbsError = absaccuracy;
z.fevalRange = [zmin zmax];
z.minGridVal = xmin;
z.maxGridVal = xmax;
z.nPoints = ntotalpoints;
z.success = success;
z.oldpoints = oldpoints;%ptslen; %points
z.allpoints = allpoints;
z.dimadaptDegree = double(nadaptpoints)/double(ntotalpoints);
% if isps
% 	z.dimadaptDegree = double(nadaptpoints)/double(ntotalpoints);
% end
z.fevalTime = fevalTime;
z.surplusCompTime = surplusCompTime;

levelseq = struct('indicesNDims', indicesNDims(1:ni), ...
                  'indicesDims', indicesDims(1:addr-1), ...
                  'indicesLevs', indicesLevs(1:addr-1), ...
                  'indicesAddr', indicesAddr(1:ni), ...
                  'active', active(1:ni), ...
                  'forwardAddr', forwardAddr(1:ni), ...
                  'forwardNeighbors', forward(1:nfi,:), ...
                  'backwardNeighbors', backward(1:addr-1), ...
                  'subGridPoints', ptslen(1:ni), ...
                  'subGridAddr', ptsaddr(1:ni));

z.indices = levelseq;
z.maxLevel = maxlevel;

z.activeIndices = A(1:na);
z.activeIndices2 = Ap(1:nap);
z.nindex = nindex;
z.nindexIter = nindexIter;
z.Emeank = Emeank(:,1:ni);
z.Emean = Emean;
z.Mean = Mean;

z.G = G(1:ni);
z.G2 = G2(1:ni);
z.maxSetPoints = maxsetpoints;
z.dimAdapt = true;

if strcmpi(keepFunctionValues, 'on')
    z.fvals = y;
end
if strcmpi(keepGrid, 'on')
    z.grid = {x};
end
