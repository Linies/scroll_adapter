/// to: [BaseAdapter]
/// 上层数据更新接口
abstract class DataBuildInterface<E> {
  void add(E item);

  void addAll(List<E?> items);

  void insert(int position, E item);

  void remove(E item);

  void removeAt(int position);

  void clear();

  void swap(int current, int next);

  E? item(int position);

  int get size;
}

abstract class DataNotifyInterface<E> {
  void registerCallback(DataSetCallback onDataSetChanged);

  void removeCallback(DataSetCallback? onDataSetChanged);

  void notifyDataSetChanged();

  void notifyItemChanged(int position);
}

mixin ItemDataManager<E>
    implements DataBuildInterface<E>, DataNotifyInterface<E> {
  var _dataList = <E?>[];

  List<DataSetCallback> _dataSetCallbacks = [];

  @override
  void registerCallback(DataSetCallback onDataSetChanged) =>
      _dataSetCallbacks.add(onDataSetChanged);

  @override
  void removeCallback(DataSetCallback? onDataSetChanged) {
    if (null == onDataSetChanged) {
      _dataSetCallbacks.clear();
    } else {
      _dataSetCallbacks.remove(onDataSetChanged);
    }
  }

  @override
  void notifyDataSetChanged() {
    _dataSetCallbacks.forEach((callback) {
      callback.onDataSetChanged();
    });
  }

  @override
  void notifyItemChanged(int position) {
    _dataSetCallbacks.forEach((callback) {
      callback.onItemsChanged(position, position);
    });
  }

  @override
  E? item(int position) => _dataList[position];

  @override
  void add(E item) {
    _dataList.add(item);
  }

  @override
  void addAll(List<E?> items) {
    _dataList.addAll(items);
  }

  @override
  void insert(int position, E item) {
    _dataList.insert(position, item);
  }

  @override
  void remove(E item) {
    _dataList.remove(item);
  }

  @override
  void removeAt(int position) {
    _dataList.removeAt(position);
  }

  @override
  void swap(int current, int next) {
    var tmp = _dataList[current];
    _dataList[current] = _dataList[next];
    _dataList[next] = tmp;
  }

  @override
  void clear() {
    _dataList.clear();
    notifyDataSetChanged();
  }

  @override
  int get size => _dataList.length;
}

abstract class OnEventListener<E> {
  void onClickCallback(E? item, int position);

  void onDoubleCallback(E? item, int position);

  void onLongCallback(E? item, int position);
}

class OnEventWrapper implements OnEventListener {
  var onItemClickListeners = <OnItemClickListener>[];
  var onItemLongClickListeners = <OnItemLongClickListener>[];
  var onItemDoubleClickListeners = <OnItemDoubleClickListener>[];

  @override
  void onClickCallback(item, int position) {
    for (var listener in onItemClickListeners) {
      listener(item, position);
    }
  }

  @override
  void onDoubleCallback(item, int position) {
    for (var listener in onItemLongClickListeners) {
      listener(item, position);
    }
  }

  @override
  void onLongCallback(item, int position) {
    for (var listener in onItemDoubleClickListeners) {
      listener(item, position);
    }
  }
}

typedef OnItemClickListener<E> = void Function(E item, int postion);

typedef OnItemLongClickListener<E> = void Function(E item, int postion);

typedef OnItemDoubleClickListener<E> = void Function(E item, int postion);

/// 回调接口通知外部[View]setState
abstract class DataSetCallback {
  /// 所有数据更新
  void onDataSetChanged();

  /// 指定item范围数据更新
  void onItemsChanged(int start, int end);
}
