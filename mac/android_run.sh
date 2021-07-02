#!/bin/zsh
echo "start run android "
#echo "\$0 is $0"
#echo "\$1 is $1"
echo $*
adb devices

containsElement () {

  local e match="$1"

  shift

  for e; do [[ "$e" == "$match" ]] && return 0; done

  return 1

}

containsElement 

# clean
#./gradlew clean

# assemblePackage
#./gradlew assembleSitDebug

# install
#adb install -r -t app/build/outputs/apk/sit/debug/app-sit-debug.apk

# launch
#adb shell am start com.dejiplaza.deji/.ui.welcome.FlashActivity
