<!--
Copyright (C) 2014,2023 Mitsubishi Electric Research Laboratories (MERL)

SPDX-License-Identifier: AGPL-3.0-or-later
-->

# Fast Plane Extraction Using Agglomerative Hierarchical Clustering (AHC)


## Overview

This source code package contains our C++ implementation of the AHC based fast plane extraction for organized point cloud (point cloud that can be indexed as an image). There are three folders in this package:

* include

    Our C++ implementation of the algorithm with dependencies on OpenCV and shared_ptr (from C++11 or Boost).

* cpp

    Two example C++ console applications using our algorithm to extract planes from Kinect-like point cloud (depends on PCL), with a CMake script to help generating project files.

* matlab

    A matlab interface (fitAHCPlane.m) through MEX for using our algorithm in matlab. We also provide a wrapper class Kinect.m and kinect_ahc.m to do real-time plane extraction in matlab, partially depends on a 3rd-party toolbox [Kinect_Matlab].

[Kinect_Matlab]:http://www.mathworks.com/matlabcentral/fileexchange/30242-kinect-matlab

## Installation

Software Dependencies:

* OpenCV (`BSD-3-Clause` license)
* Boost (`BSL-1.0` license)
* Point Cloud Library (`BSD-3-Clause` license)

### C++ example

1. Install OpenCV, Boost and PCL (If you install PCL using their all-in-one installer, you directly get Boost installed as well).

2. Generate project file using CMake under either Windows or Linux.

3. Compile.

4. Run the compiled process: `plane_fitter` (first connect a Kinect to your computer!) or `plane_fitter_pcd` (first
modify `plane_fitter_pcd.ini` accordingly!).

5. Enjoy!

### Matlab example

1. In matlab:
```
cd WHERE_YOU_EXTRACT_THE_PACKAGE/matlab/mex
```

2. Run `makefile.m`

3. Select the directories for `OpenCV_Include`, `OpenCV_Lib`, and `Boost_Include` respectively

4. If everything compiles smoothly:
```
cd ..
```

5. Load a single frame we've prepared for you in matlab by:
```
load frame
```

6. Run our algorithm on the point cloud:
```
frame.mbs=fitAHCPlane(frame.xyz);
viewSeg(frame.mbs,640,480)
```

7. Enjoy!

8. If you want to play with the kinect_ahc.m with a Kinect, install [Kinect_Matlab] first.

## Citation

If you use the software, please cite the following  ([MERL TR2014-066](https://merl.com/publications/TR2014-066)):

```
@inproceedings{Feng2014may,
author = {Feng, C. and Taguchi, Y. and Kamat, V.},
title = {Fast Plane Extraction in Organized Point Clouds Using Agglomerative Hierarchical Clustering},
booktitle = {IEEE International Conference on Robotics and Automation (ICRA)},
year = 2014,
pages = {6218--6225},
month = may,
publisher = {IEEE},
doi = {10.1109/ICRA.2014.6907776},
url = {https://www.merl.com/publications/TR2014-066}
}
```

## Contact

Tim Marks <tmarks@merl.com>

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for our policy on contributions.

## License

Released under `AGPL-3.0-or-later` license, as found in the [LICENSE.md](LICENSE.md) file.

All files:

```
Copyright (c) 2014,2023 Mitsubishi Electric Research Laboratories (MERL).

SPDX-License-Identifier: AGPL-3.0-or-later
```
