% Copyright (C) 2014,2023 Mitsubishi Electric Research Laboratories (MERL)
%
% SPDX-License-Identifier: AGPL-3.0-or-later
function viewSeg(mbs,w,h)
seg=createSegImg(mbs,w,h);
figure,imshow(seg);
[x,y]=meshgrid(1:w,1:h);
for i=1:length(mbs)
  mb=mbs{i};
  mx=mean(x(mb));
  my=mean(y(mb));
  text(mx,my,num2str(i),'color','w');
end
end
