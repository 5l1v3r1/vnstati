#!/bin/bash
###############################################################################
###############################################################################
###                                                                         ###
### Author: wuseman <wuseman@nr1.nu>                                        ###
### IRC: Freenode @ wuseman                                                 ###
###                                                                         ###
###############################################################################
############################## AUTHOR WUSMAN ##################################
###############################################################################
###                                                                         ###
### If you will copy any developers work and claim you are the dev/founder  ###
### it wont make you a hacker - The only person you're fooling is yourself  ###
### so please respect all developers and GPL Licenses no matter if it's my  ###
### script, tool or project or if it's anyone else, thank you!              ###
###                                                                         ###
###############################################################################
###########################o###################################################
###############################################################################
####                                                                       ####
####  Copyright (C) 2018-2020, wuseman                                     ####
####                                                                       ####
####  This program is free software; you can redistribute it and/or modify ####
####  it under the terms of the GNU General Public License as published by ####
####  the Free Software Foundation; either version 2 of the License, or    ####
####  (at your option) any later version.                                  ####
####                                                                       ####
####  This program is distributed in the hope that it will be useful,      ####
####  but WITHOUT ANY WARRANTY; without even the implied warranty of       ####
####  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the        ####
####  GNU General Public License for more details.                         ####
####                                                                       ####
####  You must obey the GNU General Public License. If you will modify     ####
####  the file(s), you may extend this exception to your version           ####
####  of the file(s), but you are not obligated to do so.  If you do not   ####
####  wish to do so, delete this exception statement from your version.    ####
####  If you delete this exception statement from all source files in the  ####
####  program, then also delete it here.                                   ####
####                                                                       ####
###############################################################################
### Last Modified: 04:09:15 - 2021-04-27

# Interface (Default interface)
INTERFACE="enp0s25"
# INTERFACE="ip addr|awk '/state UP/ {print $2}'|sed 's/.$//'" # Set interface for us, works flawless on Gentoo enviroments, no idea about other creappy distros.

# vnstati binary
VNSTATI="/usr/bin/vnstati"

# Storage path
PATH="/tmp/vnstat/"

# Filenames
FILENAME="vnstat-"

# Check for requirement packages before we doing anything else
check_requirements() {
for requirements in crontab vnstat vnstati vnstatd; do 
    hash "$requirements" &>/dev/null || \
                 echo "$requirements is required to be installed, exiting..." ; exit 1
done 
}

# Create '/tmp/vnstat' if the directory does not exist
check_paths() {
       [[ ! -d "/tmp/vnstat" ]] && mkdir /tmp/vnstat
}

# Check permissions on our /tmp/vnstat dir
check_permissions() {
    vnstatOwner="$(stat -c '%U:%G' /tmp/vnstat/)"
    [[ $vnstatOwner != "vnstat:vnstat" ]] && chown -R vnstat:vnstat /tmp/vnstat/
}

# Check if root is executing the script
check_root() {
      (( ${EUID} > 0 )) && printf "%s\n" "$basename$0: internal error -- root privileges is required for this script" && exit 1
  }

# - NOTICE FOR CRONIE FUNCTION
# -
# Lets skip this part for public script until later, lazy cow
# -
#check_cronie() {
#    if [[ $(crontab -l | grep -iq "vnstat"; echo $?) == 1 ]]; then
#        set -f
#        echo $(crontab -l ; echo '0 * * * * /path/vnstati-generate.sh') | crontab -
#       set +f
#     fi
#}

check_requirements
check_paths
check_permission
check_root

##########################################################
# yay, now vnstati will do the real real job          ####
##########################################################

### Bandwidth Summary
${VNSTATI} -s -i $INTERFACE -o ${PATH}/${FILENAME}-summary.png              # Summary for our nic

# Bandwidth - Top Days
${VNSTATI} -m -i $INTERFACE -o ${PATH}/${FILENAME}-top-days.png             # Sort top days at top (this will show the days you used most banwidth for your server, sorted by 5)

# Bandwidth stats for: Realtime/Hourly/Daily/Monthly/Yearly
${VNSTATI} -5  -i $INTERFACE -o ${PATH}/${FILENAME}-fiveminutes.png         # Output 5 minutes
${VNSTATI} -h  -i $INTERFACE -o ${PATH}/${FILENAME}-hourly.png              # Hourly
${VNSTATI} -hg -i $INTERFACE -o ${PATH}/${FILENAME}-hourly-graph.png        # Hourly Graph 
${VNSTATI} -d  -i $INTERFACE -o ${PATH}/${FILENAME}-daily.png               # Daily
${VNSTATI} -m  -i $INTERFACE -o ${PATH}/${FILENAME}-monthly.png             # Monthly
${VNSTATI} -y  -i $INTERFACE -o ${PATH}/${FILENAME}-yearly.png              # Yearly




