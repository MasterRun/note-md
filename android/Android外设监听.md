# Android 外设监听

## 蓝牙接入监听

### 思路

注册系统广播的形式可监听蓝牙的打开关闭和连接断开状态

- 通过 `BluetoothAdapter.ACTION_STATE_CHANGED`  字段可监听蓝牙的打开和关闭状态
- 通过 `BluetoothDevice.ACTION_ACL_CONNECTED`  字段可监听蓝牙连接，同时可以获取到相关连接设备的设备名、mac地址和设备类型
- 通过 `BluetoothDevice.ACTION_ACL_DISCONNECTED` 字段可监听蓝牙断开连接

### 实现

```java
public class BluetoothMonitorReceiver extends BroadcastReceiver {

    public void register(@NotNull FragmentActivity activity) {
        activity.getLifecycle().addObserver(new LifecycleObserver() {

            @OnLifecycleEvent(Lifecycle.Event.ON_CREATE)
            public void onCreate() {
                IntentFilter intentFilter = new IntentFilter();
                // 监视蓝牙关闭和打开的状态
                intentFilter.addAction(BluetoothAdapter.ACTION_STATE_CHANGED);

                // 监视蓝牙设备与APP连接的状态
                intentFilter.addAction(BluetoothDevice.ACTION_ACL_DISCONNECTED);
                intentFilter.addAction(BluetoothDevice.ACTION_ACL_CONNECTED);
//        intentFilter.addAction(BluetoothHeadset.ACTION_AUDIO_STATE_CHANGED);
//        intentFilter.addAction(BluetoothHeadset.ACTION_CONNECTION_STATE_CHANGED);
                activity.registerReceiver(BluetoothMonitorReceiver.this, intentFilter);
            }

            @OnLifecycleEvent(Lifecycle.Event.ON_DESTROY)
            public void onDestroy() {
                activity.unregisterReceiver(BluetoothMonitorReceiver.this);
            }

        });
    }

    @Override
    public void onReceive(Context context, Intent intent) {
        String action = intent.getAction();
        if (action != null) {
            switch (action) {
                case BluetoothAdapter.ACTION_STATE_CHANGED:
                    int blueState = intent.getIntExtra(BluetoothAdapter.EXTRA_STATE, 0);
                    switch (blueState) {
                        case BluetoothAdapter.STATE_TURNING_ON:
                            Toast.makeText(context, "蓝牙正在打开", Toast.LENGTH_SHORT).show();
                            break;
                        case BluetoothAdapter.STATE_ON:
                            Toast.makeText(context, "蓝牙已经打开", Toast.LENGTH_SHORT).show();
                            break;
                        case BluetoothAdapter.STATE_TURNING_OFF:
                            Toast.makeText(context, "蓝牙正在关闭", Toast.LENGTH_SHORT).show();
                            break;
                        case BluetoothAdapter.STATE_OFF:
                            Toast.makeText(context, "蓝牙已经关闭", Toast.LENGTH_SHORT).show();
                            break;
                        default:
                    }
                    break;

                case BluetoothDevice.ACTION_ACL_CONNECTED:
                    BluetoothDevice bluetoothDevice = intent.getParcelableExtra(BluetoothDevice.EXTRA_DEVICE);
                    String bluetoothTypeString = getBluetoothTypeString(bluetoothDevice);
//                    bluetoothDevice.getAddress();
//                    bluetoothDevice.getName();
                    Toast.makeText(context, "蓝牙设备已连接:" + bluetoothTypeString, Toast.LENGTH_SHORT).show();
                    break;

                case BluetoothDevice.ACTION_ACL_DISCONNECTED:
                    Toast.makeText(context, "蓝牙设备已断开", Toast.LENGTH_SHORT).show();
                    break;
/*                case BluetoothHeadset.ACTION_AUDIO_STATE_CHANGED:
                    Toast.makeText(context, "蓝牙耳机audio", Toast.LENGTH_SHORT).show();
                    break;
                case BluetoothHeadset.ACTION_CONNECTION_STATE_CHANGED:
                    Toast.makeText(context, "蓝牙耳机conn", Toast.LENGTH_SHORT).show();
                    break;*/
                default:
            }

        }
    }

    /**
     * 获取蓝牙设备的类型
     *
     * @param device
     * @return
     */
    public static String getBluetoothTypeString(BluetoothDevice device) {
        String type = "未知的...";
        if (device != null) {
            int cls = device.getBluetoothClass().getDeviceClass();
            switch (cls) {
                case BluetoothClass.Device.AUDIO_VIDEO_CAMCORDER:
                    type = "录像机";
                    break;
                case BluetoothClass.Device.AUDIO_VIDEO_CAR_AUDIO:
                    type = "车载设备";
                    break;
                case BluetoothClass.Device.AUDIO_VIDEO_HANDSFREE:
                    type = "蓝牙耳机";
                    break;
                case BluetoothClass.Device.AUDIO_VIDEO_LOUDSPEAKER:
                    type = "扬声器";
                    break;
                case BluetoothClass.Device.AUDIO_VIDEO_MICROPHONE:
                    type = "麦克风";
                    break;
                case BluetoothClass.Device.AUDIO_VIDEO_PORTABLE_AUDIO:
                    type = "打印机";
                    break;
                case BluetoothClass.Device.AUDIO_VIDEO_SET_TOP_BOX:
                    type = "BOX";
                    break;
                case BluetoothClass.Device.AUDIO_VIDEO_UNCATEGORIZED:
                    type = "未知的";
                    break;
                case BluetoothClass.Device.AUDIO_VIDEO_VCR:
                    type = "录像机";
                    break;
                case BluetoothClass.Device.AUDIO_VIDEO_VIDEO_CAMERA:
                    type = "照相机录像机";
                    break;
                case BluetoothClass.Device.AUDIO_VIDEO_VIDEO_CONFERENCING:
                    type = "conferencing";
                    break;
                case BluetoothClass.Device.AUDIO_VIDEO_VIDEO_DISPLAY_AND_LOUDSPEAKER:
                    type = "显示器和扬声器";
                    break;
                case BluetoothClass.Device.AUDIO_VIDEO_VIDEO_GAMING_TOY:
                    type = "游戏";
                    break;
                case BluetoothClass.Device.AUDIO_VIDEO_VIDEO_MONITOR:
                    type = "可穿戴设备";
                    break;
                case BluetoothClass.Device.PHONE_CELLULAR:
                    type = "手机";
                    break;
                case BluetoothClass.Device.PHONE_CORDLESS:
                    type = "无线设备";
                    break;
                case BluetoothClass.Device.PHONE_ISDN:
                    type = "手机服务数据网";
                    break;
                case BluetoothClass.Device.PHONE_MODEM_OR_GATEWAY:
                    type = "手机调节器";
                    break;
                case BluetoothClass.Device.PHONE_SMART:
                    type = "智能手机";
                    break;
                case BluetoothClass.Device.PHONE_UNCATEGORIZED:
                    type = "未知手机";
                    break;
                case BluetoothClass.Device.WEARABLE_GLASSES:
                    type = "可穿戴眼睛";
                    break;
                case BluetoothClass.Device.WEARABLE_HELMET:
                    type = "可穿戴头盔";
                    break;
                case BluetoothClass.Device.WEARABLE_JACKET:
                    type = "可穿戴上衣";
                    break;
                case BluetoothClass.Device.WEARABLE_PAGER:
                    type = "客串点寻呼机";
                    break;
                case BluetoothClass.Device.WEARABLE_UNCATEGORIZED:
                    type = "未知的可穿戴设备";
                    break;
                case BluetoothClass.Device.WEARABLE_WRIST_WATCH:
                    type = "手腕监听设备";
                    break;
                case BluetoothClass.Device.TOY_CONTROLLER:
                    type = "可穿戴设备";
                    break;
                case BluetoothClass.Device.TOY_DOLL_ACTION_FIGURE:
                    type = "玩具doll_action_figure";
                    break;
                case BluetoothClass.Device.TOY_GAME:
                    type = "游戏";
                    break;
                case BluetoothClass.Device.TOY_ROBOT:
                    type = "玩具遥控器";
                    break;
                case BluetoothClass.Device.TOY_UNCATEGORIZED:
                    type = "玩具未知设备";
                    break;
                case BluetoothClass.Device.TOY_VEHICLE:
                    type = "vehicle";
                    break;
                case BluetoothClass.Device.HEALTH_BLOOD_PRESSURE:
                    type = "健康状态-血压";
                    break;
                case BluetoothClass.Device.HEALTH_DATA_DISPLAY:
                    type = "健康状态数据";
                    break;
                case BluetoothClass.Device.HEALTH_GLUCOSE:
                    type = "健康状态葡萄糖";
                    break;
                case BluetoothClass.Device.HEALTH_PULSE_OXIMETER:
                    type = "健康状态脉搏血氧计";
                    break;
                case BluetoothClass.Device.HEALTH_PULSE_RATE:
                    type = "健康状态脉搏速来";
                    break;
                case BluetoothClass.Device.HEALTH_THERMOMETER:
                    type = "健康状态体温计";
                    break;
                case BluetoothClass.Device.HEALTH_WEIGHING:
                    type = "健康状态体重";
                    break;
                case BluetoothClass.Device.HEALTH_UNCATEGORIZED:
                    type = "未知健康状态设备";
                    break;
                case BluetoothClass.Device.COMPUTER_DESKTOP:
                    type = "电脑桌面";
                    break;
                case BluetoothClass.Device.COMPUTER_HANDHELD_PC_PDA:
                    type = "手提电脑或Pad";
                    break;
                case BluetoothClass.Device.COMPUTER_LAPTOP:
                    type = "便携式电脑";
                    break;
                case BluetoothClass.Device.COMPUTER_PALM_SIZE_PC_PDA:
                    type = "微型电脑";
                    break;
                case BluetoothClass.Device.COMPUTER_SERVER:
                    type = "电脑服务";
                    break;
                case BluetoothClass.Device.COMPUTER_UNCATEGORIZED:
                    type = "未知的电脑设备";
                    break;
                case BluetoothClass.Device.COMPUTER_WEARABLE:
                    type = "可穿戴的电脑";
                    break;
                case BluetoothClass.Device.AUDIO_VIDEO_HEADPHONES:
                    type = "头戴式受话器";
                    break;
                case BluetoothClass.Device.AUDIO_VIDEO_HIFI_AUDIO:
                    type = "高保真音频设备";
                    break;
                case BluetoothClass.Device.AUDIO_VIDEO_WEARABLE_HEADSET:
                    type = "可穿戴耳机";
                    break;
                default:
                    break;

            }
        }
        return type;
    }
}
```

## SD卡监听

### 思路

注册系统广播的形式可监听存储设备的安装与卸载，包括SD卡和其他usb存储设备

- 通过 `Intent.ACTION_MEDIA_MOUNTED`  字段可监听存储设备安装
- 通过 `Intent.ACTION_MEDIA_UNMOUNTED`  字段可监听存储设备卸载

### 实现

```java
public class SdcardReceiver extends BroadcastReceiver {
    private static final String TAG = "SdcardReceiver";

    public void register(@NotNull FragmentActivity activity) {
        activity.getLifecycle().addObserver(new LifecycleObserver() {

            @OnLifecycleEvent(Lifecycle.Event.ON_CREATE)
            public void onCreate() {
                IntentFilter intentFilter = new IntentFilter();
                intentFilter.addAction(Intent.ACTION_MEDIA_UNMOUNTED);
                intentFilter.addAction(Intent.ACTION_MEDIA_MOUNTED);
//        intentFilter.addAction(Intent.ACTION_MEDIA_EJECT);
                intentFilter.addDataScheme("file");
                activity.registerReceiver(SdcardReceiver.this, intentFilter);
            }

            @OnLifecycleEvent(Lifecycle.Event.ON_DESTROY)
            public void onDestroy() {
                activity.unregisterReceiver(SdcardReceiver.this);
            }

        });
    }

    @Override
    public void onReceive(Context context, Intent intent) {
        String action = intent.getAction();
        if (Objects.equals(action, Intent.ACTION_MEDIA_MOUNTED)) {
            Log.e(TAG, "sdcard mounted");
        } else if (Objects.equals(action, Intent.ACTION_MEDIA_UNMOUNTED)) {
            Log.e(TAG, "sdcard unmounted");
        } /*else if (Objects.equals(action, Intent.ACTION_MEDIA_EJECT)) {
            Log.e(TAG, "sdcard eject");
        }*/
    }
}

```

## 有线耳机接入监听

### 思路


注册系统广播的形式可监听有线耳机的插拔

- 通过 `Intent.ACTION_HEADSET_PLUG` 字段可监听到耳机的插拔，可根据回调的字段判别插入/拔出

### 实现

```java
public class HeadsetPlugReceiver extends BroadcastReceiver {

    private boolean hasHeadset = false;

    //耳机的广播 Intent.ACTION_HEADSET_PLUG
    @Override
    public void onReceive(Context context, Intent intent) {
        String action = intent.getAction();
        //判断耳机
        if (Objects.equals(action, Intent.ACTION_HEADSET_PLUG)) {
            int intExtra = intent.getIntExtra("state", 0);
            // state --- 0代表拔出，1代表插入
            // name--- 字符串，代表headset的类型。
            // microphone -- 1代表这个headset有麦克风，0则没有
            // int i=intent.getIntExtra("",0);
            if (intExtra == 0) {
                if (hasHeadset) {
                    hasHeadset = false;
                    Toast.makeText(context, "拔出耳机", Toast.LENGTH_SHORT).show();
                }
            }
            if (intExtra == 1) {
                hasHeadset = true;
                int intType = intent.getIntExtra("microphone", 0);
                if (intType == 0) {
                    Toast.makeText(context, "耳机插入:没有麦克风", Toast.LENGTH_SHORT).show();
                } else if (intType == 1) {
                    Toast.makeText(context, "耳机插入:有麦克风", Toast.LENGTH_SHORT).show();
                }
            }

        }
    }

    public void register(@NotNull FragmentActivity activity) {
        activity.getLifecycle().addObserver(new LifecycleObserver() {
            @OnLifecycleEvent(Lifecycle.Event.ON_CREATE)
            public void onCreate() {
                IntentFilter filter = new IntentFilter();
                filter.addAction(Intent.ACTION_HEADSET_PLUG);
                activity.registerReceiver(HeadsetPlugReceiver.this, filter);
            }

            @OnLifecycleEvent(Lifecycle.Event.ON_DESTROY)
            public void onDestroy() {
                activity.unregisterReceiver(HeadsetPlugReceiver.this);
            }
        });
    }

}

```

## USB外设监听

### 思路

注册系统广播的形式可监听USB设备的插拔

- 通过 `android.hardware.usb.action.USB_STATE` 字段可以监听到USB的连接与断开（例如：电脑使用USB连接手机），在通过`UsbManager`获取USB外设信息时无法获取到这种设备的信息
- 通过 `UsbManager.ACTION_USB_DEVICE_ATTACHED`  字段可监听当手机为主导模式时，USB设备的接入（例如：插入手机U盘）
- 通过 `UsbManager.ACTION_USB_DEVICE_DETACHED`  字段可监听当手机为主导模式时，USB设备的断开（例如：拔出手机U盘）

### 实现

```java

public class PeripheralReceiver extends BroadcastReceiver {
    //usb线的广播
    public final static String TAGUSB = "android.hardware.usb.action.USB_STATE";
    //外设的广播
    public static final String TAGIN = UsbManager.ACTION_USB_DEVICE_ATTACHED;
    public static final String TAGOUT = UsbManager.ACTION_USB_DEVICE_DETACHED;
    private boolean is_tagin = false;
    private boolean is_usbin = false;

    @Override
    public void onReceive(Context context, Intent intent) {
        ;
        String action = intent.getAction();
        //判断外设
        if (action.equals(TAGIN)) {
            Toast.makeText(context, "外设已经连接", Toast.LENGTH_SHORT).show();
            is_tagin = true;
            tipUsbDeviceCount(context);
        }
        if (action.equals(TAGOUT)) {
            if (is_tagin) {
                Toast.makeText(context, "外设已经移除", Toast.LENGTH_SHORT).show();
                is_tagin = false;
            }
            tipUsbDeviceCount(context);
        }
        //判断存储usb
        if (action.equals(TAGUSB)) {
            boolean connected = intent.getExtras().getBoolean("connected");
            if (connected) {
                is_usbin = true;
                Toast.makeText(context, "USB 已经连接", Toast.LENGTH_SHORT).show();

            } else {
                if (is_usbin) {
                    Toast.makeText(context, "USB 断开", Toast.LENGTH_SHORT).show();
                    is_usbin = false;
                }

            }
        }
    }

    public void register(@NotNull FragmentActivity activity) {
        activity.getLifecycle().addObserver(new LifecycleObserver() {
            @OnLifecycleEvent(Lifecycle.Event.ON_CREATE)
            public void onCreate() {
                IntentFilter filter = new IntentFilter();
                filter.addAction(PeripheralReceiver.TAGIN);
                filter.addAction(PeripheralReceiver.TAGOUT);
                filter.addAction(PeripheralReceiver.TAGUSB);
//                filter.addAction(UsbManager.ACTION_USB_ACCESSORY_ATTACHED);
//                filter.addAction(UsbManager.ACTION_USB_ACCESSORY_DETACHED);
                activity.registerReceiver(PeripheralReceiver.this, filter);
            }

            @OnLifecycleEvent(Lifecycle.Event.ON_DESTROY)
            public void onDestroy() {
                activity.unregisterReceiver(PeripheralReceiver.this);
            }
        });
    }

    private void tipUsbDeviceCount(@NonNull Context context) {

        UsbManager usbManager = (UsbManager) context.getSystemService(Context.USB_SERVICE);
        if (usbManager != null) {
            HashMap<String, UsbDevice> map;
            map = usbManager.getDeviceList();
            if (map.size() > 0) {
                Toast.makeText(context, "usb device count" + map.size(), Toast.LENGTH_SHORT).show();
                System.out.println("......................before....................................");
                for (UsbDevice device : map.values()) {
                    Toast.makeText(context, "外设 name：" + device.getDeviceName(), Toast.LENGTH_SHORT).show();
                    Toast.makeText(context, "外设 vid ：" + device.getVendorId(), Toast.LENGTH_SHORT).show();
                    System.out.println(".......one..........dName: " + device.getDeviceName());
                    System.out.println(".......tow.........vid: " + device.getVendorId() + "\t pid: " + device.getProductId());
                }
                System.out.println("........................after..................................");
            }
        }
    }
}

```

## NFC监听

暂未查找到有关系统广播可监听NFC的连接断开
