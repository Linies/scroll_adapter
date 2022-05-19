part of '../part.dart';

/// 为[ItemView]抽象一层手势接口
/// 区别于[OnEventListener]，为手势处理器[GestureDetector]提供接口
/// 可接受对应[DragDetail]手势信息
abstract class GestureCallback {
  /// 点击
  void onTapDown(TapDownDetails details);

  /// 双击
  void onDoubleTapDown(TapDownDetails details);

  /// 长按
  void onLongPressStart(LongPressStartDetails details);

  void onVerticalDragDown(DragDownDetails details);

  void onVerticalDragStart(DragStartDetails details);

  void onVerticalDragEnd(DragEndDetails details);

  void onHorizontalDragDown(DragDownDetails details);

  void onHorizontalDragStart(DragStartDetails details);

  void onHorizontalDragEnd(DragEndDetails details);
}

/// 代理实现类
class GestureItemDetector implements GestureCallback {
  @override
  void onTapDown(TapDownDetails details) {}

  @override
  void onDoubleTapDown(TapDownDetails details) {}

  @override
  void onLongPressStart(LongPressStartDetails details) {}

  @override
  void onVerticalDragDown(DragDownDetails details) {}

  @override
  void onVerticalDragEnd(DragEndDetails details) {}

  @override
  void onVerticalDragStart(DragStartDetails details) {}

  @override
  void onHorizontalDragDown(DragDownDetails details) {}

  @override
  void onHorizontalDragEnd(DragEndDetails details) {}

  @override
  void onHorizontalDragStart(DragStartDetails details) {}
}
