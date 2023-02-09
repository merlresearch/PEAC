% Copyright (C) 2014,2023 Mitsubishi Electric Research Laboratories (MERL)
%
% SPDX-License-Identifier: AGPL-3.0-or-later
function [xyz,rgb,depth,mbs]=kinect_ahc(varargin)
% call kinect_ahc('rgb'); to see our fitAHCPlane run in real-time
% depends on Kinect.m

viewRGB=false;
viewXYZ=false;
viewDepth=false;
for i=1:nargin
  if strcmpi(varargin{i},'rgb')
    viewRGB=true;
  elseif strcmpi(varargin{i},'xyz')
    viewXYZ=true;
  elseif strcmpi(varargin{i},'depth')
    viewDepth=true;
  end
end
if ~viewRGB && ~viewXYZ && ~viewDepth
  xyz=[]; rgb=[]; depth=[]; mbs=[];
  return;
end

hd = Kinect;
[xyz,rgb,depth]=hd.grab;

ahcParams = getDefaultAHCFitterparams;
ahcParams.windowWidth=8;
ahcParams.windowHeight=8;
ahcParams.mergeMSETolerance=10;
% ahcParams.initMSETolerance=5;
% ahcParams.depthSigmaFactor=9e-7;
setAHCPlaneFitterParams(ahcParams);
[h,w]=size(depth);

hfRGB=[];
hfXYZ=[];
hfD=[];
if viewRGB
  figure;
  hfRGB=imshow(rgb);
end
if viewXYZ
  figure;
  [x,y,z]=splitXYZ(xyz);
  hfXYZ=plot3(x,y,z,'.');
  axis equal;
  grid on;
end
if viewDepth
  figure;
  hfD=imshow(depth); colormap('jet');
end

  function ret=rgbNotDone
    ret = viewRGB && ~isempty(hfRGB) && ishghandle(hfRGB);
  end
  function ret=xyzNotDone
    ret = viewXYZ && ~isempty(hfXYZ) && ishghandle(hfXYZ);
  end
  function ret=depthNotDone
    ret = viewDepth && ~isempty(hfD) && ishghandle(hfD);
  end
  function ret=notDone
    ret= rgbNotDone...
      || xyzNotDone...
      || depthNotDone;
  end

while notDone
  [xyz,rgb,depth]=hd.grab;
  mbs=fitAHCPlane(xyz);
  seg=createSegImg(mbs,w,h);
  rgb=(rgb+seg)/2;
  if rgbNotDone
    set(hfRGB,'CDATA',rgb);
  end
  if xyzNotDone
    [x,y,z]=splitXYZ(xyz);
    set(hfXYZ,'XDATA',x);
    set(hfXYZ,'YDATA',y);
    set(hfXYZ,'ZDATA',z);
  end
  if depthNotDone
    set(hfD,'CDATA',depth);
  end
  drawnow;
end
end
