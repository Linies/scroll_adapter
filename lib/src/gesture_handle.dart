part of '../part.dart';

/// 为[ItemView]抽象一层手势接口
/// 区别于[OnEventListener]，为手势处理器[GestureDetector]提供接口
/// 可接受对应[DragDetail]手势信息
abstract class GestureCallback {
  /// 点击
  void onTapDown(TapEvent event);

  /// 双击
  void onDoubleTapDown(TapEvent event);

  /// 长按
  void onLongPressEnd();

  void onMoveStart(MoveEvent event);

  void onMoveEnd(MoveEvent event);

  void onScrollEvent(ScrollEvent event);
}

/// 代理实现类
class GestureItemDetector implements GestureCallback {
  @override
  void onTapDown(TapEvent event) {}

  @override
  void onDoubleTapDown(TapEvent event) {}

  @override
  void onLongPressEnd() {}

  @override
  void onMoveEnd(MoveEvent event) {}

  @override
  void onMoveStart(MoveEvent event) {}

  @override
  void onScrollEvent(ScrollEvent event) {}
}
