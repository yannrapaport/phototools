#!/bin/sh

#  ptt-lib.inc.sh
#  
#
#  Created by Yann Rapaport on 30/07/2018.
#  

PHOTOS="*.DNG *.JPG *.CR2 *.ARW"
VIDEOS="*.MOV *.MP4"
DIRS="1-photos 10-export 1-videos"

debug() {
    if $DEBUG; then
        echo $1
    fi
}
