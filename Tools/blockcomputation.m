function [RHS] = blockcomputation(x,x0,potentials,blockSize,kernalPar,GPU)
%BLOCKCOMPUTATION Compute matrix vector product of kernel with potential
%   Calcuated the matrix vector product of kernel with potential in block
%   of maximum size blockSize
% Inputs:
%   x         : A (3*N,1) vector of stokelet points where we have the 
%                force formated as [x1 y1 z1 x2 y2 z2 ...]'
%   x0        : A (3*M,1) vector of sample points where we want to compute 
%               the velocity formated as [x1 y1 z1 x2 y2 z2 ...]'
%   blockSize : Maximum size of kernel matrix in GB
%   kernalPar : Parameters for kernel
%   GPU       : GPU computation flag (default=0)
%
% Outputs:
%   RHS : A (3*M,1) of velocities formated as 
%         [vx1 vy1 vZ1 vx2 vy2 vz2 ...]'

if ~exist('GPU','var')
     % third parameter does not exist, so default it to something
      GPU = 0;
end

if GPU
    x = gpuArray(x);
    potentials = gpuArray(potentials);
end

threeM = size(x,1);
threeN = size(x0,1);

blockNodes=floor(blockSize*2^27/(3*threeM));
blocks = [1:3*blockNodes:threeN threeN+1];

RHS = zeros(threeN,1);
for i = 1:length(blocks)-1
    RHS(blocks(i):blocks(i+1)-1,:) = ...
        gather(kernel(x,gpuArray(x0(blocks(i):blocks(i+1)-1,:)),...
                      kernalPar)*potentials);        
end

if GPU
    x = [];
    x0 = [];
    potentials = [];
end
end

