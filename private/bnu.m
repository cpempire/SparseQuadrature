% in paper Sparse Quadrature for High-Dimensional Integration with Gaussian Measure 
function b_value = bnu(levelseq, k, tau)

ndims = levelseq.indicesNDims(k);
ndims = uint32(ndims);
addr = levelseq.indicesAddr(k);
addr = uint32(addr);
jtau = zeros(ndims,1);
nlev = zeros(ndims,1);
for id = 1:ndims 
    jdim = levelseq.indicesDims(addr+id-1); % which dimension
    jtau(id) = tau(jdim);
    nlev(id) = levelseq.indicesLevs(addr+id-1); % how many levels
end

b_value = 1;
Ntotal = prod(nlev+1);
for k = 1:Ntotal-1
    b_k = 1;
    for id = ndims:-1:1 
        kres = mod(k, prod(nlev(1:id-1)+1));
        k_id = (k - kres)/prod(nlev(1:id-1)+1);
        b_k = b_k * nchoosek(nlev(id),k_id) * jtau(id)^(2*k_id);
        k = kres;
    end
    b_value = b_value + b_k;
end

% b_value = double(b_value);
% function k_d = decom(k,nlev,ndims)
% 
% for id = ndims:-1:1 
%     kres = mod(k, prod(nlev(1:id-1)+1));
%     k_d(id) = (k - kres)/prod(nlev(1:id-1)+1);
%     k = kres;
% end
