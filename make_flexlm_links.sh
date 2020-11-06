#!/bin/bash
cd /opt/flexlm/bin
for util in lmdown lmhostid lmremove lmreread lmstat lmswitchr lmver
do
    #echo $util
    ln -s lmutil $util
done
