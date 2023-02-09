% Copyright (C) 2014,2023 Mitsubishi Electric Research Laboratories (MERL)
%
% SPDX-License-Identifier: AGPL-3.0-or-later
function mbs=fitAHCPlane(xyz)
% fast plane extraction using AHC
% xyz<wxhx3>: organized point cloud, as a 3-channel image, xyz(i,j,1) is the x coordinate of the (i,j) point, xyz(i,j,2) is the y coordinate, xyz(i,j,3) is the z coordinate
% mbs<Nx{Kix1}>: N cells, each cell mbs{i} is a Kix1 vector storing pixel indices of the points belonging to the i-th extracted plane
tic;
mbs=mxFitAHCPlane(xyz);
toc;
end
