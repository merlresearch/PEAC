% Copyright (C) 2014,2023 Mitsubishi Electric Research Laboratories (MERL)
%
% SPDX-License-Identifier: AGPL-3.0-or-later
function map=myPseudoColor(ncolors)
map=[0,0,0;
     255, 0, 0;
		 255, 255, 0;
		 100, 20, 50;
		 0, 30, 255;
		 10, 255, 60;
		 80, 10, 100;
		 0, 255, 200;
		 10, 60, 60;
		 255, 0, 128;
		 60, 128, 128]/255.0;
if ncolors>length(map)
  nMore=ncolors-length(map);
  map=[map;rand(nMore,3)];
elseif ncolors<length(map)
  map=map(1:ncolors,:);
end
end
