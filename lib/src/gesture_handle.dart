import 'package:flutter/widgets.dart';
import 'package:scroll_adapter/core/adapter_core.dart';

/// 为[ItemView]抽象一层手势接口
abstract class GestureCallback {
  void onClick();

  void onDoubleClick();

  void onLongClick();
}

class GestureItemDetector implements GestureCallback {
  @override
  void onClick() {}

  @override
  void onDoubleClick() {}

  @override
  void onLongClick() {}
}

class GestureWrapper<E> extends StatelessWidget {
  final GestureCallback? gestureItem;

  final Widget child;

  final EventsBinder? eventsBinder;

  final OnEventListener? onEventListener;

  final E? item;

  final int position;

  GestureWrapper(
    this.item,
    this.position, {
    required this.gestureItem,
    required this.child,
    required this.eventsBinder,
  }) : onEventListener = eventsBinder?.bindGestureItem(item, position);

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () {
          gestureItem?.onClick();
          onEventListener?.onClickCallback(item, position);
        },
        onDoubleTap: () {
          gestureItem?.onDoubleClick();
          onEventListener?.onDoubleCallback(item, position);
        },
        onLongPress: () {
          gestureItem?.onLongClick();
          onEventListener?.onLongCallback(item, position);
        },
        child: child,
      );
}

/// [OnEventListener]对[item]绑定的接口
abstract class EventsBinder<E> {
  OnEventListener bindGestureItem(E? item, int position);
}
