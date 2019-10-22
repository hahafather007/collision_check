# collision_check

[![pub package](https://img.shields.io/pub/v/collision_check.svg)](https://pub.dartlang.org/packages/collision_check)
[![GitHub](https://img.shields.io/github/license/hahafather007/collision_check.svg)](https://github.com/hahafather007/collision_check)
[![GitHub stars](https://img.shields.io/github/stars/hahafather007/collision_check.svg?style=social&label=Stars)](https://github.com/hahafather007/collision_check)

一款效率超高的轻量级2D物体碰撞检测插件，纯Dart语言编写，适用于任何Dart/Flutter项目。

An ultra-efficient lightweight 2D object collision detection plugin, written in pure Dart, for any Dart/Flutter project.

## 效率

在计算五角星的碰撞时，如下测试代码100w次检测时间为1050ms，足够在一般的场景中检测大量物体的碰撞。

```dart
void main() {
  test("碰撞测试", () {
    // 复杂几何图形（下面是一个⭐️️）
    final complex = CcComplex([
      CcOffset(25, 0),
      CcOffset(31, 18),
      CcOffset(50, 18),
      CcOffset(34, 31),
      CcOffset(40, 50),
      CcOffset(25, 38),
      CcOffset(10, 50),
      CcOffset(14, 31),
      CcOffset(0, 18),
      CcOffset(18, 18),
    ]);

    final complex2 = CcComplex([
      CcOffset(25, 0),
      CcOffset(31, 18),
      CcOffset(50, 18),
      CcOffset(34, 31),
      CcOffset(40, 50),
      CcOffset(25, 38),
      CcOffset(10, 50),
      CcOffset(14, 31),
      CcOffset(0, 18),
      CcOffset(18, 18),
    ]);
    for (var i = 0; i < 1000000; i++) {
      complex.position = CcOffset(1, 1.12312);
      complex2.position = CcOffset(4.12343, 0.2384892349);
      final value6 = CollisionUtil.isCollision(complex, complex2);
      assert(value6 == true);
    }
  });
}
```

## 安装

### pubspec.yaml

最新版本： [![pub package](https://img.shields.io/pub/v/collision_check.svg)](https://pub.dartlang.org/packages/collision_check)

```yaml
dependencies:
  photo_manager: $latest_version
```

## 使用方法

1、根据需求在创建2d图形时同时创建对应的`CcShape`对象（尽量使用`final`类型）：

```dart
final shapeA = CcComplex(points, position = initPosition);
final shapeB = CcCircle(radius, position = initPosition);
```

2、在物体移动时根据移动后的位置调用：

```dart
shapeA.position = positionA;
shapeB.position = positionB;
```

3、调用下面的方法返回两个物体是否碰撞：

```dart
final result = CollisionUtil.isCollision(shapeA, shapeB);
```

详细使用方法可在example中查看，若有疑问，欢迎提Issue。


