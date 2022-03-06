import 'package:flutter/widgets.dart';
import 'package:scroll_adapter/core/base_impl.dart';

abstract class ArrangeAdapter<E> extends DataBuildAdapter<E> {
  ArrangeAdapter({DataBuildState? state}) : super(state: state);
}

abstract class ArrangeListView extends StatefulWidget {
  final ArrangeAdapter adapter;

  ArrangeListView(this.adapter);

  @override
  ArrangeListViewState createState() => ArrangeListViewState();
}

/// todo:
class ArrangeListViewState extends DataBuildState<ArrangeListView>
    with DataBuildBase {

  @override
  void initState() {
    widget.adapter.state = this;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (item, position) =>
            widget.adapter.bindItemView(item, position));
  }
}
