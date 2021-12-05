import 'package:flutter/widgets.dart';
import 'package:scroll_adapter/core/adapter_core.dart';
import 'package:scroll_adapter/src/build_handle.dart';
import 'package:scroll_adapter/src/gesture_handle.dart';

/// base View
abstract class DataBuildView extends State implements DataSetCallback {
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

// @override
// Widget build(BuildContext context) {
//   ListView.builder(
//   itemBuilder: (context, position) {
//     adapter.onItemBuild(item, position);
//   });
// }
}

/// base Adapter
abstract class DataBuildAdapter<E>
    with
        ItemDataManager,
        ItemViewBinder<E>,
        ItemBuildInterface<E>,
        GestureBinder<E> {
  DataBuildAdapter({GestureItemDetector? detector})
      : _gestureCallback = detector;

  GestureCallback? _gestureCallback;

  @override
  HolderPort onItemBuild(E? item, int position) =>
      ItemHolder(item, position, this);

  @mustCallSuper
  @override
  Widget onItemUpdate(E? item, int position);

  @override
  Widget bindItemView(E? item, int position) => GestureWrapper(
        item,
        position,
        gestureItem: _gestureCallback,
        child: onItemUpdate(item, position),
        gestureBinder: this,
      );

  @override
  OnEventListener bindGestureItem(E? item, int position) => OnEventWrapper();
}
