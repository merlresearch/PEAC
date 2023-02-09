% Copyright (C) 2014,2023 Mitsubishi Electric Research Laboratories (MERL)
%
% SPDX-License-Identifier: AGPL-3.0-or-later
classdef Kinect < handle
% a matlab wrapper for Kinect access
% h=Kinect;
% h=Kinect(recordedONIFileName);
% depends on Kinect_Matlab toolbox at:
% http://www.mathworks.com/matlabcentral/fileexchange/30242-kinect-matlab

  properties(Access=private)
    hKinect;
    hCapture;
  end

  methods
    function h=Kinect(varargin)
      fdir=selfInstall;
      SAMPLE_XML_PATH=fullfile(fdir,'Config/SamplesConfig.xml');

      if nargin==0
        h.hKinect=mxNiCreateContext(SAMPLE_XML_PATH);
      else
        fprintf('[Kinect] open from file: %s\n',varargin{1});
        h.hKinect=mxNiCreateContext(SAMPLE_XML_PATH,varargin{1});
      end

      h.hCapture=[];
    end

    function delete(h)
      %dtor, close context handle
      assert(isa(h,'Kinect'));
      h.recordStop();
      mxNiDeleteContext(h.hKinect);
    end

    function [xyz,rgb,depth]=grab(h)
      %grab a new kinect frame
      %xyz: point clouds with unit of mm
      %rgb: color image
      %depth: depth image
      assert(isa(h,'Kinect'));
      mxNiUpdateContext(h.hKinect);

      if nargout>0
        xyz=mxNiDepthRealWorld(h.hKinect);
        z=xyz(:,:,3);
        z(z==0)=nan;
        z(z>5000)=nan;
        xyz(:,:,3)=z;
      end

      if nargout>1
        rgb=mxNiPhoto(h.hKinect);
        rgb=permute(rgb,[3 2 1]);
      end

      if nargout>2
        depth=mxNiDepth(h.hKinect);
        depth=permute(depth,[2 1]);
      end
    end

    function recordStart(h, fileName)
      %start recording the Kinect frames as a file
      assert(isa(h,'Kinect'));
      if ~isempty(h.hCapture)
        disp('[Kinect.recordStart warn] forgot to call recordStop to close previous record?');
        h.recordStop();
      end

      h.hCapture = mxNiStartCapture(h.hKinect, fileName);
    end

    function recordStop(h)
      %stop recording if exist
      assert(isa(h,'Kinect'));
      if ~isempty(h.hCapture)
        mxNiStopCapture(h.hCapture);
      end
    end
  end

  methods(Static)
    function [xyz,rgb,depth]=live(viewRGB, viewXYZ, viewDepth)
      % start a live view of Kinect by calling
      % Kinect.live(viewRGB, viewXYZ, viewDepth)

      if ~viewRGB && ~viewXYZ && ~viewDepth
        return;
      end

      hd = Kinect;
      [xyz,rgb,depth]=hd.grab;

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
  end
end

function ret=getFileFolder
fname = mfilename('fullpath');
ret = fileparts(fname);
end

function fdir=selfInstall
fdir=getFileFolder;
mexDir = fullfile(fdir,'Mex');
addpath(fdir);
addpath(mexDir);
end

function [x,y,z]=splitXYZ(xyz)
x=xyz(:,:,1);
y=xyz(:,:,2);
z=xyz(:,:,3);
x=x(:);
y=y(:);
z=z(:);
end
