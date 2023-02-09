% Copyright (C) 2014,2023 Mitsubishi Electric Research Laboratories (MERL)
%
% SPDX-License-Identifier: AGPL-3.0-or-later
function seg=createSegImg(mbs,w,h)
% given mbs output from fitAHCPlane, create a RGB segmentation image of size wxh
seg=ones(h,w);
for i=1:length(mbs)
  mb=mbs{i};
  seg(mb)=i+1;
end
seg=uint8(255*ind2rgb(seg,myPseudoColor(length(mbs)+1)));
end
