#!/usr/bin/env bash
cd .. && cd CVPR
wolframscript -script 2013/crawler/crawler.m && echo "CVPR 2013 done!"
wolframscript -script 2014/crawler/crawler.m && echo "CVPR 2014 done!"
wolframscript -script 2015/crawler/crawler.m && echo "CVPR 2015 done!"
wolframscript -script 2016/crawler/crawler.m && echo "CVPR 2016 done!"
wolframscript -script 2017/crawler/crawler.m && echo "CVPR 2017 done!"