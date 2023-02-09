% Copyright (C) 2014,2023 Mitsubishi Electric Research Laboratories (MERL)
%
% SPDX-License-Identifier: AGPL-3.0-or-later
function params=getDefaultAHCFitterparams
params.depthSigma=1.6e-6;
params.stdTol_merge=8;
params.stdTol_init=5;
params.similarityTh_merge=cosd(60);
params.similarityTh_refine=cosd(30);
params.angle_far=deg2rad(90);
params.angle_near=deg2rad(15);
params.z_near=500;
params.z_far=4000;
params.depthAlpha=0.04;
params.depthChangeTol=0.02;

params.windowWidth=10;
params.windowHeight=10;
params.maxStep=100000;
params.minSupport=800;
params.doRefine=1;
params.erodeType=2;
params.initType=0;
end
