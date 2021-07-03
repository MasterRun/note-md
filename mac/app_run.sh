#!/bin/zsh
echo "\r\n=========   start   ========== \r\n"

# 渠道
channelStr=(sit sit2 pre prod)
# 默认识别 debug release
channelAllKnown=(debug release)

packageName="com.dejiplaza.deji"
launchActivity="$packageName/.ui.welcome.FlashActivity"

hasDevices=0

# 指令参数
# c -> gradlew clean
# i -> 直接安装指定渠道包
# I -> 直接使用 gradlew install 系列命令
# l -> launch(默认)
# u -> uninstall
cleanOps="clean"
in_opts=("" 0 0 0 0) #默认值为0
while { getopts iIcl arg } {
    case $arg {
        (c)
        in_opts[1]=$cleanOps
        ;;

        (i)
        in_opts[2]=1
        ;;

        (I)
        in_opts[3]=1
        ;;

        # (l)
        # echo $arg option with arg: $OPTARG
        # ;;

        (u)
        in_opts[5]
        ;;
    }
}
# echo $in_opts

allArgsCount=$#*

# otherArgs=$*[$OPTIND,-1] # 得到字符串
# echo $otherArgs
# echo $#otherArgs
# 移除之前的参数
shift $(($OPTIND-1))

# 如果带有clean,依旧添加clean
if (( $*[(I)$cleanOps] )) {
    in_opts[1]=$cleanOps
}

# 检查adb
checkAdb() {
    # adb path
    adbPath="/Users/jsongo/Library/Android/sdk/platform-tools"

    # append adbPath to PATH
    if (( $PATH[(I)$adbPath] == 0 )) {
        PATH=$adbPath:$PATH
    }
    # echo "\$PATH=$PATH \r\n"

    deviceList=$(adb devices)
    #空格分割
    str_array=("${(@s/ /)deviceList}")
    # 取最后一位
    deviceList=$str_array[-1]
    #查找device
    hasDevices=$deviceList[(I)device]
    echo hasDevices $hasDevices
}
checkAdb

upcaseFirstLetter() {
    inStr=$1
    firstLetter=$inStr[1]
    #uFirstLetter=${firstLetter:u}
    #替换掉首字母
    #inStr=${inStr/$firstLetter/$uFirstLetter}
    inStr[1]=${firstLetter:u}
    echo $inStr
}

uninstallApkIfNeed(){
    if (( $in_opts[5] )){
        echo "uninstall $packageName"
        adb shell am uninstall $packageName
    }
}

# 如果有参数
if (( $allArgsCount )) {

    # 交集 查找指定的渠道类型,默认为debug
    channel=${*:*channelStr}
    if (( $#channel == 0 )) {
        channel=$channelStr[1]
    }
    # echo channel is $channel

    # 交集 查找 release 或 debug,如果未指定，默认为debug
    allKnowChannel=${*:*channelAllKnown}
    if (( $#allKnowChannel == 0 )) {
        allKnowChannel=$channelAllKnown[1]
    }
    # echo use $allKnowChannel channel

    # 通过首字母大写 拼接gradle命令的后半截
    gradleScriptSuffix=$(upcaseFirstLetter $channel)$(upcaseFirstLetter $allKnowChannel)
    echo channel is $gradleScriptSuffix

    if (( $in_opts[3] )) {
        uninstallApkIfNeed
        # 执行gradle直接安装命令
        echo run gradlew $in_opts[1] install$gradleScriptSuffix
        ./gradlew $in_opts[1] install$gradleScriptSuffix
    } else {
        # 如果不指定为install 则打包
        if (( $in_opts[2] == 0 ))  {
            # 执行打包命令 assemblePackage
            echo run gradlew $in_opts[1] assemble$gradleScriptSuffix
            ./gradlew $in_opts[1] assemble$gradleScriptSuffix
        }

        if (( $hasDevices )) {
            uninstallApkIfNeed
            # 安装
            # install
            apkPath=app/build/outputs/apk/$channel/$allKnowChannel/app-$channel-$allKnowChannel.apk
            echo install $apkPath
            adb install -r -t $apkPath
        }
    }
}

if (( $hasDevices )) {
    # launch
    echo launching
    adb shell am start $launchActivity
}
echo "\r\n=========   complete   =========="