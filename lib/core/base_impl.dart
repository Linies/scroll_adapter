import 'package:flutter/widgets.dart';
import 'package:scroll_adapter/core/adapter_core.dart';
import 'package:scroll_adapter/src/build_handle.dart';
import 'package:scroll_adapter/src/gesture_handle.dart';

abstract class DataBuildState<T extends StatefulWidget> extends State<T>
    implements DataSetCallback {
  @protected
  void _addHolder(int position, HolderPort port);
}

mixin DataBuildView on DataBuildState {
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

/// base Adapter
abstract class DataBuildAdapter<E>
    with
        ItemDataManager,
        ItemViewBinder<E>,
        ItemBuildInterface<E>,
        GestureBinder<E> {
  DataBuildAdapter({required this.state, GestureItemDetector? detector})
      : _gestureCallback = detector;

  GestureCallback? _gestureCallback;

  DataBuildState? state;

  @override
  HolderPort onItemBuild(E? item, int position) =>
      ItemHolder(item, position, this);

  @mustCallSuper
  @override
  Widget onItemUpdate(E? item, int position);

  @override
  Widget bindItemView(E? item, int position) {
    state?._addHolder(position, onItemBuild(item, position));
    return GestureWrapper(
      item,
      position,
      gestureItem: _gestureCallback,
      child: onItemUpdate(item, position),
      gestureBinder: this,
    );
  }

  @override
  OnEventListener bindGestureItem(E? item, int position) => OnEventWrapper();
}
