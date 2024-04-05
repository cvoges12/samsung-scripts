#!/bin/sh


echo sending AT commands...
echo "AT+KSTRINGB=0,3" > /dev/ttyACM0 ; sleep 0.5  
echo "AT+DUMPCTRL=1,0" > /dev/ttyACM0 ; sleep 0.5  
echo "AT+DEBUGLVC=0,5" > /dev/ttyACM0 ; sleep 0.5  
echo "AT+SWATD=0" > /dev/ttyACM0 ; sleep 0.5  
echo "AT+ACTIVATE=0,0,0" > /dev/ttyACM0 ; sleep 0.5  
echo "AT+SWATD=1" > /dev/ttyACM0 ; sleep 0.5  
echo "AT+DEBUGLVC=0,5" > /dev/ttyACM0 ; sleep 0.5  

echo Please press Allow...
adb kill-server
adb wait-for-device
adb shell settings put global setup_wizard_has_run 1
adb shell settings put secure user_setup_complete 1
adb shell content insert --uri content://settings/secure --bind name:s:DEVICE_PROVISIONED --bind value:i:1
adb shell content insert --uri content://settings/secure --bind name:s:user_setup_complete --bind value:i:1
adb shell content insert --uri content://settings/secure --bind name:s:INSTALL_NON_MARKET_APPS --bind value:i:1
adb shell am start -c android.intent.category.HOME -a android.intent.action.MAIN
sleep 5 # Wait 5 sec
adb shell am start -n com.android.settings/com.android.settings.Settings
sleep 5 # Wait 5 sec
echo FRP unlock commands completed running... idk if it errored
adb reboot
