#!/bin/zsh
echo "\r\n----------   start   ----------\r\n"

# 渠道
channelStr=(sit sit2 pre prod)
# 默认识别 debug release
channelAllKnown=(debug release)

currentVarient=(sit debug)

packageName="com.dejiplaza.deji"
pageName=".ui.welcome.FlashActivity"

hasDevices=0

# 指令参数
# c -> gradlew clean
# i -> 直接安装指定渠道包
# I -> 直接使用 gradlew install 系列命令
# l -> 不安装直接launch（不使用此ops默认最后launch）
# O -> open finder
# u -> uninstall
# p -> 指定page
cleanOps="clean"
#        c i I l u O
in_opts=("" 0 0 0 0 0) #默认值为0
while { getopts ciIlOp: arg } {
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

        (l)
        in_opts[4]=1
        ;;

        (u)
        in_opts[5]=1
        ;;

        (O)
        in_opts[6]=1
        ;;

        (p)
        # echo $arg option with arg: $OPTARG
        pageName=$OPTARG
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

# 首字母大写
upcaseFirstLetter() {
    inStr=$1
    firstLetter=$inStr[1]
    #uFirstLetter=${firstLetter:u}
    #替换掉首字母
    #inStr=${inStr/$firstLetter/$uFirstLetter}
    inStr[1]=${firstLetter:u}
    echo $inStr
}

# 读当前的variant
readCurrentVariant() {

    filename=$(pwd)"/.idea/modules/app/Deji-release.app.iml"
    echo "${filename}"
    lineKeyWord="SELECTED_BUILD_VARIANT"

    # echo "$(<$filename)"
    # 遍历行
    variant=""
    for i (${(f)"$(<$filename)"}) {
        # 取带有关键词的行
       if (( $i[(I)$lineKeyWord] )) {
            # 使用 value 进行分割
          separated="${i[(ws:value:)2]}"
          # 因为引号影响，强行裁剪
          variant=$separated[3,-6]
          break
       }
    }
    # echo $variant
    #转成小写
    variant=${variant:l}
    centerIndex=0
    for i ($channelAllKnown) {
        centerIndex=${variant[(I)$i]}
        if (( $centerIndex )) {
            break
        }
    }
    currentVarient[1]=${variant[0,centerIndex-1]}
    currentVarient[2]=${variant[centerIndex,-1]}
}

uninstallApkIfNeed(){
    if (( $in_opts[5] )){
        echo "uninstall $packageName"
        adb shell am uninstall $packageName
    }
}

sendNotification(){
    osascript -e "beep"
    osascript -e "display notification \"variant $2\" with title \"app_run $1\""
}

# 如果有参数 或者 没设备  且 没指定仅启动
if (( $allArgsCount || $hasDevices==0 )) && (( $in_opts[4]==0 )) {
    readCurrentVariant

    # 交集 查找指定的渠道类型,默认为sit
    channel=${*:*channelStr}
    if (( $#channel == 0 )) {
        channel=$currentVarient[1]
    }
    # echo channel is $channel

    # 交集 查找 release 或 debug,如果未指定，默认为debug
    allKnowChannel=${*:*channelAllKnown}
    if (( $#allKnowChannel == 0 )) {
        allKnowChannel=$currentVarient[2]
    }
    # echo use $allKnowChannel channel

    # 通过首字母大写 拼接gradle命令的后半截
    gradleScriptSuffix=$(upcaseFirstLetter $channel)$(upcaseFirstLetter $allKnowChannel)
    echo channel is $gradleScriptSuffix
echo ($in_opts[6])
    if (( $in_opts[6] )) {
     open app/build/outputs/apk/$channel/$allKnowChannel
    }
    exit 0

    if [[ $#gradleScriptSuffix == 0 ]] {
        sendNotification Error "channel error"
        exit 1
    }

    if (( $in_opts[3] )) {
        uninstallApkIfNeed
        # 执行gradle直接安装命令
        echo run gradlew $in_opts[1] install$gradleScriptSuffix
        ./gradlew $in_opts[1] install$gradleScriptSuffix
    } else {
        # 如果不指定为install 则打包
        if (( $in_opts[2] == 0 )) {
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

            if (( $? )) {
                sendNotification Error "install failed"
                exit 1
            }
        }
    }

    if (( $in_opts[6] )) {
        # 打开finder
        echo open app/build/outputs/apk/$channel/$allKnowChannel
        open app/build/outputs/apk/$channel/$allKnowChannel
    }
}

if (( $hasDevices )) {
    # launch
    launchActivity="$packageName/$pageName"
    echo launching $launchActivity
    adb shell am start $launchActivity
}

echo "\r\n----------   complete   ----------"
sendNotification "Complete!" ${gradleScriptSuffix}