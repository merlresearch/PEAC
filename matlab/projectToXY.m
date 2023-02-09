% Copyright (C) 2014,2023 Mitsubishi Electric Research Laboratories (MERL)
%
% SPDX-License-Identifier: AGPL-3.0-or-later
function Vxy=projectToXY(Vxyz,majorAxis)
% project Vxyz to x-y plane using the major axis
% Vxyz<3xn>: points expressed in world coordinate system
% majorAxis<3x3>: from pca usually, majorAxis(:,1) is the x-direction in
% world coordinate system, majorAxis(:,2) is y-direction, majorAxis(:,3) is
% z-direction

Vxy=majorAxis'*Vxyz;
Vxy=Vxy(1:2,:);
end
