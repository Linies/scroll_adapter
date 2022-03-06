import 'package:flutter/widgets.dart';

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
  State<StatefulWidget> createState() => ItemHolderState();

  @override
  void notify() {
    _weakState[this]?.setState(() {});
  }
}

class ItemHolderState extends State<ItemHolder> {

  @override
  void initState() {
    widget._weakState[widget] = this;
    super.initState();
  }

  @override
  Widget build(BuildContext context) => widget.itemBinder.bindItemView(widget.item, widget.position);
}

/// [item]绑定器
mixin ItemViewBinder<E> {
  // 将[Item]绑定对应[ItemHolder]
  Widget bindItemView(E? item, int position);
}

/// [itemView]刷新回调
abstract class HolderPort {
  /// [ItemHolder]刷新
  void notify();
}

/// [itemView]构建器
abstract class ItemBuildInterface<E> {
  // 构建holder建立与[onItemUpdate]的视图绑定
  HolderPort onItemHolderBuild(E? item, int position);

  Widget onItemUpdate(E? item, int position);
}
