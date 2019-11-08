# Android保存图片并显示在系统相册

提供以下两种方法将图片保存到系统相册相对醒目的位置，目前不完全保证这两种方法保存成功后能显示在相册，目前个人测试妹=没问题

```java

public void saveToGallery(Bitmap mBitmap){
        //系统相册路径
        String galleryPath = Environment.getExternalStorageDirectory()
                + File.separator + Environment.DIRECTORY_DCIM
                + File.separator + "Camera" + File.separator;

        final File photo = new File(galleryPath, picName);
        //保存到文件
        Bitmap newBitmap = Bitmap.createBitmap(mBitmap.getWidth(), mBitmap.getHeight(), Bitmap.Config.ARGB_8888);
        Canvas canvas = new Canvas(newBitmap);
        canvas.drawColor(Color.WHITE);
        canvas.drawBitmap(mBitmap, 0, 0, null);
        OutputStream stream = new FileOutputStream(photo);
        newBitmap.compress(Bitmap.CompressFormat.JPEG, 100, stream);
        stream.close();

        //发送广播通知系统扫描此文件
        Intent intent = new Intent(Intent.ACTION_MEDIA_SCANNER_SCAN_FILE);
        // mark 使用content uri无效，需要使用file uri（如下方法）
        Uri uri = Uri.fromFile(photo);
        intent.setData(uri);
        mContext.sendBroadcast(intent);
}

```

```java
/**
 * 将图片插到系统的Pictures路径下，并显示在相册
 * @param mContext context
 * @param photo 已有的文件
 * @param picName 需要保存到Pictures下的图片名
 */
public void saveToPicture(Context mContext, File photo, String picName) throws FileNotFoundException {
    MediaStore.Images.Media.insertImage(mContext.getContentResolver(), photo.getAbsolutePath(), picName, null);
}

```
