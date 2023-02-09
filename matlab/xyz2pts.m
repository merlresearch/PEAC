% Copyright (C) 2014,2023 Mitsubishi Electric Research Laboratories (MERL)
%
% SPDX-License-Identifier: AGPL-3.0-or-later
function pts=xyz2pts(xyz)
[x,y,z]=splitXYZ(xyz);
pts=[x(:),y(:),z(:)]';
end
