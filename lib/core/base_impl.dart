part of '../part.dart';

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
        ItemDataManager<E>,
        ItemViewBinder<E>,
        ItemBuildInterface<E>,
        EventsBinder,
        EventsListenerManage {
  DataBuildAdapter({this.state, GestureCallback? gestureCallback})
      : _gestureCallback = gestureCallback;

  GestureCallback? _gestureCallback;

  DataBuildState? state;

  OnEventListener<E> _onEventListener = OnEventWrapper<E>();

  @override
  HolderPort onItemHolderBuild(E? item, int position) =>
      ItemHolder(item, position, this);

  @mustCallSuper
  @override
  Widget onItemUpdate(E? item, int position);

  @override
  Widget bindItemView(E? item, int position) {
    // [HolderPort]与上层建立视图进行绑定
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
  OnEventListener get bindEventListener => _onEventListener;

  @override
  void addItemClickListener(OnItemClickListener<E?> listener) =>
      _onEventListener.addItemClickListener(listener);

  @override
  void addItemLongClickListener(OnItemLongClickListener<E?> listener) =>
      _onEventListener.addItemLongClickListener(listener);

  @override
  void removeItemClickListener(OnItemClickListener<E?> listener) =>
      _onEventListener.removeItemClickListener(listener);

  @override
  void removeItemLongClickListener(OnItemClickListener<E?> listener) =>
      _onEventListener.removeItemLongClickListener(listener);
}

/// 手势和事件监听包装器
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
  }) : onEventListener = eventsBinder?.bindEventListener;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () {
          onEventListener?.onClickCallback(item, position);
        },
        // onDoubleTap: () {
        //   onEventListener?.onDoubleCallback(item, position);
        // },
        onLongPress: () {
          onEventListener?.onLongCallback(item, position);
        },
        onTapDown: (detail) {
          gestureItem?.onTap(detail);
        },
        onDoubleTapDown: (detail) {
          gestureItem?.onDoubleTap(detail);
        },
        onLongPressStart: (detail) {
          gestureItem?.onLongPress(detail);
        },
        child: child,
      );
}
