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

# Interaface (Default interaface)
INTERFACE="enp0s25"

# Create vnstat dir
mkdir -p /tmp/vnstat

# Change owner of /tmp/vnstat path
chown -R vnstat:vnstat /tmp/vnstat

##########################################################
# # VNSTAT                                            ####
##########################################################
# Summary
vnstati -s -i $INTERFACE -o /tmp/vnstat/vnstat-summary.png

# Top Days
vnstati -m -i $INTERFACE -o /tmp/vnstat/vnstat-top-days.png

# Stats
vnstati -5 -i $INTERFACE -o /tmp/vnstat/vnstat-fiveminutes.png
vnstati -h -i $INTERFACE -o /tmp/vnstat/vnstat-hourly.png
vnstati -hg -i $INTERFACE -o /tmp/vnstat/vnstat-hourly-graph.png
vnstati -d -i $INTERFACE -o /tmp/vnstat/vnstat-daily.png
vnstati -m -i $INTERFACE -o /tmp/vnstat/vnstat-monthly.png
vnstati -y -i $INTERFACE -o /tmp/vnstat/vnstat-yearly.png

