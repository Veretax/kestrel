#!/bin/bash
source config.shlib; # load the config library functions
echo $(config_get myvar); # will be found in user-cfg
echo $(config_get othervar); # will fall back to defaults
echo $(config_get bleh); # "__UNDEFINED__" since it isn't set anywhere
echo $(config_get DBHOST); #load DBHOST
echo $(config_get DBNAME); #load DBName
echo $(config_get DBUSER); #load DBUser
echo $(config_get DBPASS); #load DBPass

