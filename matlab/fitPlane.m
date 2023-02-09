% Copyright (C) 2014,2023 Mitsubishi Electric Research Laboratories (MERL)
%
% SPDX-License-Identifier: AGPL-3.0-or-later
function [center,majorAxis,majorAxisVar]=fitPlane(Vxyz)
% fit plane from Vxyz using PCA
% Vxyz<3xn>: points expressed in world coordinate system
% center<3x1>: center of mass
% majorAxis<3x3>: from pca usually, majorAxis(:,1) is the x-direction in
% world coordinate system, majorAxis(:,2) is y-direction, majorAxis(:,3) is
% z-direction

center=mean(Vxyz,2);
Vnew = bsxfun(@minus, Vxyz, center);
K=Vnew*Vnew';
[zyxVar,zyxDir]=mxEig33Sym(K);
majorAxis=zyxDir(:,[3,2,1]);
viewDir = center/norm(center); %assume viewpoint is at (0,0,0)'
if dot(viewDir,majorAxis(:,3))>0
  majorAxis(:,3)=-majorAxis(:,3); %ensure <zdir,viewdir> <0
end
if det(majorAxis)<0 %ensure rotation matrix
  majorAxis(:,2)=-majorAxis(:,2);
end
if nargout>2
  majorAxisVar=zyxVar([3,2,1])/size(Vxyz,2);
end
end
