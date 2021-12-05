import 'package:flutter/widgets.dart';

/// 抽象数据构建[holder] extends [View]
/// [ItemHolder]需要是一个视图或者持有视图的对象，【设计考虑后者】
/// [item]
/// [itemBinder]外部构建的视图
/// [position]对应数据项目
class ItemHolder<E> extends StatelessWidget implements HolderPort {
  final E? item;
  final int position;
  final ItemViewBinder itemBinder;

  ItemHolder(this.item, this.position, this.itemBinder, {Key? key})
      : super(key: key);

  @override
  void notify() {
    // TODO: implement call
  }

  // fixme: add Reaction
  @override
  Widget build(_) => itemBinder.bindItemView(item, position);
}

/// [item]绑定器
mixin ItemViewBinder<E> {
  // 将[Item]绑定对应[ItemHolder]
  Widget bindItemView(E? item, int position);
}

abstract class HolderPort {
  /// [ItemHolder]刷新
  void notify();
}

abstract class ItemBuildInterface<E> {
  // 构建holder建立与[onItemUpdate]的视图绑定
  HolderPort onItemBuild(E? item, int position);

  Widget onItemUpdate(E? item, int position);
}