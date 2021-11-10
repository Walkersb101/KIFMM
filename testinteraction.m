clear all;
clf;

points = rand(10000,3);

points = points(points(:,1)<0.5,:);

tic
tree = OcTree(points,'binCapacity',5,'maxDepth',21);
toc

plot3(points(:,1), points(:,2), points(:,3),'.')
hold on;
axis equal;

tic
interactions = geninteractionlists(tree);
toc

% randNodeIndex = randi([1 tree.binCount]);
randNodeIndex = 8;
[U,V,W,X] = interactions{randNodeIndex,1:4};

% % Plot cubes
% plotcube(tree.binCorners(U,:),'g')
% plotcube(tree.binCorners(V,:),'c')
% plotcube(tree.binCorners(W,:),'k')
% plotcube(tree.binCorners(X,:),'b')
% plotcube(tree.binCorners(randNodeIndex,:),'r')
% 
% surf = gendownsurf(tree,randNodeIndex,6,2);
% plot3(surf(:,1),surf(:,2),surf(:,3),'.');
% 
% hold off;


for i = 1:tree.binCount
    [U,V,W,X] = interactions{i,1:4};
    superinteractions = [];
    if ~isempty(U)
        superinteractions = [superinteractions U];
    end
    if ~isempty(V)
        superinteractions = [superinteractions V];
        end
    if ~isempty(W)
        superinteractions = [superinteractions W];
        end
    if ~isempty(X)
        superinteractions = [superinteractions X];
    end
    if size(superinteractions) ~= size(unique(superinteractions))
        disp("Fix ME")
    end
end
