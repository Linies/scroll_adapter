import 'package:flutter/widgets.dart';
import 'package:scroll_adapter/core/adapter_core.dart';
import 'package:scroll_adapter/src/build_handle.dart';
import 'package:scroll_adapter/src/gesture_handle.dart';

/// 基于[StatefulWidget]、[State]使用的[List]数据构建接口
abstract class DataBuildState<T extends StatefulWidget> extends State<T>
    implements DataSetCallback {
  @protected
  void _addHolder(int position, HolderPort port);
}

/// 提供一个可直接继承使用的[mixin]类
mixin DataBuildBase<T extends StatefulWidget> on DataBuildState<T> {
  final Map<int, HolderPort> _holders = {};

  @override
  void onDataSetChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void onItemsChanged(int start, int end) {
    for (; start <= end; start++) {
      if (mounted) {
        _holders[start]?.notify();
      }
    }
  }

  @override
  void _addHolder(int position, HolderPort port) {
    _holders[position] = port;
  }
}

/// [DataBuildAdapter]适配器集合接口
/// 数据和状态控制: [ItemDataManager]
/// 视图构建: [ItemBuildInterface]
/// 视图绑定器: [ItemViewBinder]
/// 事件回调队列绑定器: [EventsBinder]
abstract class DataBuildAdapter<E>
    with
        ItemDataManager,
        ItemViewBinder<E>,
        ItemBuildInterface<E>,
        EventsBinder<E> {
  DataBuildAdapter({required this.state, GestureItemDetector? detector})
      : _gestureCallback = detector;

  GestureCallback? _gestureCallback;

  DataBuildState? state;

  @override
  HolderPort onItemHolderBuild(E? item, int position) =>
      ItemHolder(item, position, this);

  @mustCallSuper
  @override
  Widget onItemUpdate(E? item, int position);

  @override
  Widget bindItemView(E? item, int position) {
    state?._addHolder(position, onItemHolderBuild(item, position));
    return GestureWrapper(
      item,
      position,
      gestureItem: _gestureCallback,
      child: onItemUpdate(item, position),
      eventsBinder: this,
    );
  }

  @override
  OnEventListener bindGestureItem(E? item, int position) => OnEventWrapper();
}
