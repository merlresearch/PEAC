% Copyright (C) 2014,2023 Mitsubishi Electric Research Laboratories (MERL)
%
% SPDX-License-Identifier: AGPL-3.0-or-later
function [x,y,z]=splitXYZ(xyz)
% split the 3-channel point cloud representation into 3 vectors of coordinates
x=xyz(:,:,1);
y=xyz(:,:,2);
z=xyz(:,:,3);
x=x(:);
y=y(:);
z=z(:);
end
