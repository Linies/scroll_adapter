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

  void onPointerDown(PointerDownEvent event);

  void onPointerUp(PointerUpEvent event);

  void onPointerCancel(PointerCancelEvent event);

  void onPointerMove(PointerMoveEvent event);

  void onPointerHover(PointerHoverEvent event);

  void onPointerSignal(PointerSignalEvent event);
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
  void onPointerCancel(PointerCancelEvent event) {}

  @override
  void onPointerDown(PointerDownEvent event) {}

  @override
  void onPointerUp(PointerUpEvent event) {}

  @override
  void onPointerHover(PointerHoverEvent event) {}

  @override
  void onPointerMove(PointerMoveEvent event) {}

  @override
  void onPointerSignal(PointerSignalEvent event) {}
}
