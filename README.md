## scroll_adapter

* 提供给滑动列表视图和数据项构建的适配器

```dart
/// 滑动适配器业务层接口
abstract class ArrangeAdapter<E> {}

/// 外部继承独立实现滑动视图的可适配类
abstract class AdaptableScroll {
  /// 基类内部实现类内部数据的处理，外部仅需要实现具体[ScrollView]
  Widget buildScroll(IndexedWidgetBuilder indexedWidgetBuilder);
}
```
