% Copyright (C) 2014,2023 Mitsubishi Electric Research Laboratories (MERL)
%
% SPDX-License-Identifier: AGPL-3.0-or-later
function kinect_record(fname)
if nargin<1
  fname=uiputfile;
end

msgbox('Click image to start record and click it again to stop and quit!');

hd = Kinect;
[~,rgb,depth]=hd.grab;

startRecord=false;
  function myfunc(~,~)
    if startRecord %if started
      fprintf('Record End, saved as %s\n',fname);
      hd.recordStop();
      close(hfRGB);
    else %not started yet
      startRecord=true; %let's start
      fprintf('Record Start...\n');
      hd.recordStart(fname);
    end
  end

hfRGB=figure;
rgb=uint8((double(rgb)+double(mono2rgb(depth)))/2);
hRGB=imshow(rgb);
set(hRGB,'ButtonDownFcn',@myfunc);

  function ret=rgbNotDone
    ret = ~isempty(hRGB) && ishghandle(hRGB);
  end
  function ret=notDone
    ret= rgbNotDone;
  end

while notDone
  [~,rgb,depth]=hd.grab;
  rgb=uint8((double(rgb)+double(mono2rgb(depth)))/2);
  if rgbNotDone
    set(hRGB,'CDATA',rgb);
  end
  drawnow;
end
end
