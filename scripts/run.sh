#!/bin/bash

echo -e "\n\n *** Start new execution : `date` ***"
su mangas -c  "calibre-debug $WORK_DIR/main.py -- $CONFIG_FILE"
echo -e "*** End ***"