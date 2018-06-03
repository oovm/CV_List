# CVPR 2018
![cvpr2018_logo.jpg](https://raw.githubusercontent.com/GalAster/CVPR_List/master/2018/cvpr2018_logo.jpg)

### Bash
```sh
wget -i https://raw.githubusercontent.com/GalAster/CVPR_List/master/2018/download.txt
```


### Mathematica
```mma
path=FileNameJoin[{$UserBaseDirectory,"CVPR 2018"}]
get=URLExecute["https://raw.githubusercontent.com/GalAster/CVPR_List/master/2018/data.json","RawJSON"];
URLDownload[#["PDF"],FileNameJoin[{path,#["Name"]<>".pdf"}]]&/@get["Data"]
```

### Python
```py
import os
f = open('filename')
content = f.read().split("\n")
for line in content:
    if not line:
        break
    cmd = 'wget --content-disposition "%s" ' % line
    os.system(cmd)
```