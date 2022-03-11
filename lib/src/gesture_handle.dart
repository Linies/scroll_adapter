import 'package:flutter/widgets.dart';
import 'package:scroll_adapter/core/adapter_core.dart';

/// 为[ItemView]抽象一层手势接口
/// 区别于[OnEventListener]，为手势处理器[GestureDetector]提供接口
/// 可接受对应[DragDetail]手势信息
abstract class GestureCallback {
  /// 点击
  void onTap(TapDownDetails details);

  /// 双击
  void onDoubleTap(TapDownDetails details);

  /// 长按
  void onLongPress(LongPressStartDetails details);
}

/// 代理实现类
class GestureItemDetector implements GestureCallback {
  @override
  void onTap(TapDownDetails details) {}

  @override
  void onDoubleTap(TapDownDetails details) {}

  @override
  void onLongPress(LongPressStartDetails details) {}
}