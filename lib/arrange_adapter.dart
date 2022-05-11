import 'package:flutter/widgets.dart';
import 'package:scroll_adapter/part.dart';

/// 滑动适配器业务层接口
abstract class ArrangeAdapter<E> extends DataBuildAdapter<E> {
  ArrangeAdapter({DataBuildState? state, GestureCallback? gestureCallback})
      : super(state: state, gestureCallback: gestureCallback);
}

/// 索引项构建以回调方式给外部的滑动生成函数
typedef ScrollWithIndexedBuilder = Widget Function(
    IndexedWidgetBuilder indexedWidgetBuilder);

/// 外部继承独立实现滑动视图的可适配类
abstract class AdaptableScroll<T extends ArrangeAdapter>
    extends StatefulWidget {
  final T adapter;

  AdaptableScroll(this.adapter);

  /// [buildScroll]被外部直接实现，在该方法实现具体滑动视图
  /// [indexedWidgetBuilder]回调构建[itemView]方法
  Widget buildScroll(IndexedWidgetBuilder indexedWidgetBuilder);

  @override
  _ArrangeState createState() => _ArrangeState();
}

class _ArrangeState extends DataBuildState<AdaptableScroll> with DataBuildBase {
  @override
  void initState() {
    widget.adapter
      ..state = this
      ..registerCallback(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => widget.buildScroll((_, position) =>
      widget.adapter.buildItemView(widget.adapter.item(position), position));

  @override
  void dispose() {
    super.dispose();
    widget.adapter
      ..removeCallback(this)
      ..state = null;
  }
}
