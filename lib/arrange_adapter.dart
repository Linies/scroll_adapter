import 'package:scroll_adapter/core/base_impl.dart';

abstract class ArrangeAdapter<E> extends DataBuildAdapter<E> {
  ArrangeAdapter({required DataBuildState? state}) : super(state: state);
}

abstract class ArrangeListView extends DataBuildState with DataBuildBase {}