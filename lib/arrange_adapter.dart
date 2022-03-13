import 'package:flutter/widgets.dart';
import 'package:scroll_adapter/core/base_impl.dart';

/// 滑动适配器业务层接口
abstract class ArrangeAdapter<E> extends DataBuildAdapter<E> {
  ArrangeAdapter({DataBuildState? state}) : super(state: state);
}

/// 索引项构建以回调方式给外部的滑动生成函数
typedef ScrollWithIndexedBuilder = Widget Function(IndexedWidgetBuilder indexedWidgetBuilder);

/// 外部继承独立实现滑动视图的可适配类
/// [buildScroll]外部在该方法实现具体滑动视图
abstract class AdaptableScroll extends StatelessWidget {

  final ArrangeAdapter adapter;

  AdaptableScroll(this.adapter);

  Widget buildScroll(IndexedWidgetBuilder indexedWidgetBuilder);

  @override
  Widget build(BuildContext context) => _ArrangeView(adapter, (builder) => buildScroll(builder));
}

class _ArrangeView extends StatefulWidget {
  final ArrangeAdapter adapter;

  final ScrollWithIndexedBuilder scrollvIdxBuilder;

  _ArrangeView(this.adapter, this.scrollvIdxBuilder);

  @override
  _ArrangeState createState() => _ArrangeState();
}

class _ArrangeState extends DataBuildState<_ArrangeView>
    with DataBuildBase {

  @override
  void initState() {
    widget.adapter.state = this;
    super.initState();
  }

  @override
  Widget build(BuildContext context) => widget.scrollvIdxBuilder(widget.adapter.bindItemView);
}
