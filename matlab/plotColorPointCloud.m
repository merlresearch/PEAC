% Copyright (C) 2014,2023 Mitsubishi Electric Research Laboratories (MERL)
%
% SPDX-License-Identifier: AGPL-3.0-or-later
function plotColorPointCloud(xyz,mbs)
% plot color point cloud, for xyz and mbs format, see fitAHCPlane
x=xyz(:,:,1);
y=xyz(:,:,2);
z=xyz(:,:,3);
cmap = myPseudoColor(length(mbs)+1);
figure,hold on;
for i=1:length(mbs)
  mb=mbs{i};
  c=cmap(i+1,:);
  plot3(x(mb),y(mb),z(mb),'.','color',c);
end
axis equal;
grid on;
end
