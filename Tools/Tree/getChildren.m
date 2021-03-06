function [children] = getChildren(tree, indices)
% getchildren  finds indices of all nodes below given nodes
%Inputs:
%   tree    : tree structure generated by Octree
%   indices : List of indices of nodes
%
%Output:
%   children : returns a column array off all children below given nodes

nonLeafIndices = indices(~isleaf(tree,indices,'All'));
newChildren = tree.nodeChildren(nonLeafIndices,:);
newChildren = reshape(newChildren,[],1);
if size(newChildren,1) ~= 0
    children = [indices(isleaf(tree,indices,'All')); newChildren; getChildren(tree,newChildren)];
else
    children = [];
end
end

