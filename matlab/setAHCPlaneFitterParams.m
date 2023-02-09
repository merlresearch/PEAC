% Copyright (C) 2014,2023 Mitsubishi Electric Research Laboratories (MERL)
%
% SPDX-License-Identifier: AGPL-3.0-or-later
function setAHCPlaneFitterParams(params)
% set the AHC plane fitter parameters, params must be constructed exactly as the same format as getDefaultAHCFitterparams
vals=double(struct2array(params));
keys=int32((1:length(vals))-1);
mxFitAHCPlane(keys, vals);
end
