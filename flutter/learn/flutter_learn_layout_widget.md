# Flutter

## 布局Widget

### 单子布局Widget

#### Align

```dart
const Align({
  Key key,
  this.alignment: Alignment.center, // 对齐方式，默认居中对齐
  this.widthFactor, // 宽度因子，不设置的情况，会尽可能大
  this.heightFactor, // 高度因子，不设置的情况，会尽可能大
  Widget child // 要布局的子Widget
})
```

说明：

1. 子Widget在父Widget中的对其方式要求父Widget有自己的宽高
2. widthFactor及heightFactor如果有值，Align的宽\高会是子Widget的widthFactor\heightFactor倍
3. 如果factor参数不设置，Align宽高会尽可能大

#### Center

Center继承自Align，alignment为ALignment.center

#### Padding

```dart
const Padding({
  Key key,
  @requiredthis.padding, // EdgeInsetsGeometry类型（抽象类），使用EdgeInsets
  Widget child,
})
```

#### Container

```dart
Container({
  this.alignment,
  this.padding, //容器内补白，属于decoration的装饰范围
  Color color, // 背景色
  Decoration decoration, // 背景装饰
  Decoration foregroundDecoration, //前景装饰
  double width,//容器的宽度
  double height, //容器的高度
  BoxConstraints constraints, //容器大小的限制条件
  this.margin,//容器外补白，不属于decoration的装饰范围
  this.transform, //变换
  this.child,
})
```

说明：

1. 大小可以用 `width`、`height`或`constraints`. `width`、`height`如果有值，会生成`constrains`覆盖`constrains`属性
2. `color`与`decoration`互斥，`color`会产生`decoration`

#### BoxDecoration

```dart
const BoxDecoration({
    this.color, // 颜色，会和Container中的color属性冲突
    this.image, // 背景图片
    this.border, // 边框，对应类型是Border类型，里面每一个边框使用BorderSide
    this.borderRadius, // 圆角效果
    this.boxShadow, // 阴影效果
    this.gradient, // 渐变效果
    this.backgroundBlendMode, // 背景混合
    this.shape = BoxShape.rectangle, // 形变
  })
```

#### Demo

圆角图像

```dart
return Center(
    child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
            borderRadius: BOrderRadius.circular(20),
            image: DecorationImage(
                image: NetworkImage("url"),
            )
        ),
    ),
);
```
