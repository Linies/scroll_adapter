import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:scroll_adapter/arrange_adapter.dart';
import 'package:scroll_adapter/part.dart';

enum CheckType {
  // 单选
  singe,
  // 多选
  multi
}

abstract class CheckableAdapter<E> extends ArrangeAdapter<E> {
  /// 选中项
  var _checks = HashSet.of([]);

  /// 选中模式
  CheckType checkType;

  CheckableAdapter(
      {this.checkType = CheckType.multi,
      DataBuildState? state,
      GestureCallback? gestureCallback})
      : super(state: state, gestureCallback: gestureCallback);

  /// 可选项视图更新
  @mustCallSuper
  Widget onItemCheckedUpdate(E? item, int position, bool checked);

  @override
  Widget onItemUpdate(E? item, int position) =>
      onItemCheckedUpdate(item, position, _checks.contains(item));

  /// 选中状态
  bool checked({int? position, E? checkItem}) {
    if (null != position) {
      assert(position < size);
      checkItem = item(position);
    }
    return _checks.contains(checkItem);
  }

  /// 选中
  void check({int? position, E? checkItem}) {
    assert(null != position || null != checkItem);
    if (null != position) {
      assert(position < size);
      checkItem = item(position);
    } else {
      position = indexOfItem(checkItem!);
    }
    if (null != checkItem && !_checks.contains(checkItem)) {
      if (checkType == CheckType.singe) {
        for (var idx = _checks.length - 1; idx >= 0; idx--) {
          uncheck(checkItem: _checks.elementAt(idx));
        }
      }
      _checks.add(checkItem);
      notifyItemChanged(position);
    }
  }

  /// 取消选中
  void uncheck({int? position, E? checkItem}) {
    assert(null != position || null != checkItem);
    if (null != position) {
      assert(position < size);
      checkItem = item(position);
    } else {
      position = indexOfItem(checkItem!);
    }
    if (null != checkItem && _checks.contains(checkItem)) {
      _checks.remove(checkItem);
      notifyItemChanged(position);
    }
  }

  /// 选中范围元素
  void checkRange([int start = 0, int end = 0]) {
    for (; start < end && start < size; start++) {
      if (!_checks.contains(item(start))) {
        _checks.add(item(start));
      }
    }
    notifyDataSetChanged();
  }

  /// 取消范围元素
  void uncheckRange([int start = 0, int end = 0]) {
    for (; start <= end && start < size; start++) {
      if (_checks.contains(item(start))) {
        _checks.remove(item(start));
      }
    }
    notifyDataSetChanged();
  }
}
