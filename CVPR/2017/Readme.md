# CVPR 2017

[![cvpr2017_logo.jpg](https://raw.githubusercontent.com/GalAster/CV_List/master/CVPR/2017/cvpr_logo.jpg)](https://www.cv-foundation.org/openaccess/CVPR2017.py)

https://www.cv-foundation.org/openaccess/CVPR2017.py

### Bash

```sh
wget -i https://raw.githubusercontent.com/GalAster/CV_List/master/CVPR/2017/download.txt
```

### Mathematica
```mma
path=FileNameJoin[{$UserBaseDirectory,"CVPR 2017"}]
get=URLExecute["https://raw.githubusercontent.com/GalAster/CV_List/master/CVPR/2017/data.json","RawJSON"];
URLDownload[#["PDF"],FileNameJoin[{path,#["Name"]<>".pdf"}]]&/@get["Data"]
```