#!/usr/bin/env bash
# ADB should now be enabled, we need to skip Android Setup.
echo "Please press Allow and Remember device."
adb kill-server
adb wait-for-device

adb shell settings put global setup_wizard_has_run 1
adb shell settings put secure user_setup_complete 1
adb shell content insert --uri content://settings/secure --bind name:s:DEVICE_PROVISIONED --bind value:i:1
adb shell content insert --uri content://settings/secure --bind name:s:user_setup_complete --bind value:i:1
adb shell content insert --uri content://settings/secure --bind name:s:INSTALL_NON_MARKET_APPS --bind value:i:1
adb shell am start -c android.intent.category.HOME -a android.intent.action.MAIN

sleep 5 
adb shell am start -n com.android.settings/com.android.settings.Settings
echo "FRP unlock commands completed running... You check for errors yourself..."
sleep 5
adb reboot
