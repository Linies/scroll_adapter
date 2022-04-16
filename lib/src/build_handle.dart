part of '../part.dart';

/// [item]
/// [itemBinder]外部构建的视图
/// [position]对应数据项目
/// [_weakState]弱引用[state]
class ItemHolder<E> extends StatefulWidget implements HolderPort {
  final E? item;
  final int position;
  final ItemViewBinder itemBinder;

  final Expando<ItemHolderState> _weakState = Expando<ItemHolderState>();

  ItemHolder(this.item, this.position, this.itemBinder, {Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => ItemHolderState<E>();

  @override
  void notify() {
    // ignore: invalid_use_of_protected_member
    _weakState[this]?.setState(() {});
  }
}

class ItemHolderState<E> extends State<ItemHolder> {
  @override
  void initState() {
    widget._weakState[widget] = this;
    widget.itemBinder.onInitItemView(widget.item, widget.position);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ItemHolder oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget._weakState[widget] = this;
  }

  @override
  Widget build(BuildContext context) =>
      widget.itemBinder.bindItemView(widget.item, widget.position);
}

/// [item]绑定器
mixin ItemViewBinder<E> {
  // 将[Item]绑定对应[ItemHolder]
  Widget bindItemView(E? item, int position);

  // 外层[ItemView]构建方法
  Widget buildItemView(E? item, int position);

  // [ItemView]初始化调用
  void onInitItemView(E? item, int position);
}

/// [itemView]刷新回调接口
abstract class HolderPort {
  /// [ItemHolder]刷新
  void notify();
}

/// [itemView]构建器
abstract class ItemBuildInterface<E> {
  /// 上层视图构建方法
  Widget onItemUpdate(E? item, int position);
}
