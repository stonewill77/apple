#!/bin/bash

export _DEBUG="ON"
#export wll=0
LOG_PATH="./wlan.log"

function DEBUG()
{ 
   [ "$_DEBUG" == "ON" ] && $@ || :
}

function DBG_MSG()
{
   DEBUG echo $1 >>$LOG_PATH
}

function main()
{
   local wlan_update=$wll
   
   DBG_MSG "wlan_update ++++"
      
   if [ $wlan_update -eq 0 ] ; then
      DBG_MSG "Wlan bin have been updated before,return"
      DBG_MSG "wlan_update ----"
      exit 0;
   else
      DBG_MSG "Wlan bin is being updated now"
#      rm -rf /persist/WCNSS_qcom_wlan_nv.bin
      if [ $? != 0 ]; then
        DBG_MSG "Wlan remove wlan bin file fail"
        DBG_MSG "wlan_update ----"
        exit 1;
      fi
      
#      cp /system/etc/wifi/WCNSS_qcom_wlan_nv_new.bin /persist/WCNSS_qcom_wlan_nv.bin
      
      if [ $? != 0 ]; then
        DBG_MSG "Wlan remove wlan bin file fail"
        DBG_MSG "wlan_update ----"
        exit 2;
      fi
      
#      chmod 644  /persist/WCNSS_qcom_wlan_nv.bin
#      setprop persist.wlan.update 0
      DBG_MSG "Wlan update OK "
   fi
   
   DBG_MSG "wlan_update --- "   
   exit 0
}

main
