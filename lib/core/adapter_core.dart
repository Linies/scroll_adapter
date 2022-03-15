part of '../part.dart';

/// 数据操作接口
abstract class DataBuildInterface<E> {
  /// 新增[item]
  void addItem(E item);

  /// 新增数组[items]
  void addItems(List<E?> items);

  /// 插入[item]到指定下标
  void insert(int position, E item);

  /// 移除[item]
  void remove(E item);

  /// 移除下标[position]
  void removeAt(int position);

  /// 清除列表
  void clear();

  /// 交换下标位置
  void swap(int current, int next);

  /// 获取下标[position]数据项
  E? item(int position);

  /// 数据长度
  int get size;
}

/// 回调注册以及数据监听接口
abstract class DataNotifyInterface<E> {
  /// 注册数据变化监听器
  void registerCallback(DataSetCallback onDataSetChanged);

  /// 移除数据变化监听器
  void removeCallback(DataSetCallback? onDataSetChanged);

  /// 通知已注册的监听器数据集已更改
  void notifyDataSetChanged();

  /// 通知指定下标的监听器数据集已更改
  void notifyItemChanged(int position);
}

/// 回调接口通知外部[ListView]更新视图
abstract class DataSetCallback {
  /// 所有数据更新
  void onDataSetChanged();

  /// 指定item范围数据更新
  void onItemsChanged(int start, int end);
}

/// [ItemDataManager]实现类：
/// 维护[_dataList]数据列表对[DataBuildInterface]接口实现，
/// 维护[_dataSetCallbacks]回调列表对[DataNotifyInterface]接口实现
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
  void addItem(E item) {
    _dataList.add(item);
    notifyDataSetChanged();
  }

  @override
  void addItems(List<E?> items) {
    _dataList.addAll(items);
    notifyDataSetChanged();
  }

  @override
  void insert(int position, E item) {
    _dataList.insert(position, item);
    notifyDataSetChanged();
  }

  @override
  void remove(E item) {
    _dataList.remove(item);
    notifyDataSetChanged();
  }

  @override
  void removeAt(int position) {
    _dataList.removeAt(position);
    notifyDataSetChanged();
  }

  @override
  void swap(int current, int next) {
    var tmp = _dataList[current];
    _dataList[current] = _dataList[next];
    _dataList[next] = tmp;
    notifyDataSetChanged();
  }

  @override
  void clear() {
    _dataList.clear();
    notifyDataSetChanged();
  }

  @override
  int get size => _dataList.length;
}

/// 事件调用
abstract class OnEventListener<E> implements EventsListenerManage {
  /// 点击事件回调触发
  void onClickCallback(E? item, int position);

  /// 双击事件回调触发
  void onDoubleCallback(E? item, int position);

  /// 长按事件回调触发
  void onLongCallback(E? item, int position);
}

/// 事件总线管理
abstract class EventsListenerManage {
  /// 添加监听事件
  void addItemClickListener(OnItemClickListener listener);

  void addItemLongClickListener(OnItemLongClickListener listener);

  /// 移除监听事件
  void removeItemClickListener(OnItemClickListener listener);

  void removeItemLongClickListener(OnItemLongClickListener listener);
}

/// [OnEventWrapper]对[item]点击事件的包装实现
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
    for (var listener in onItemDoubleClickListeners) {
      listener(item, position);
    }
  }

  @override
  void onLongCallback(item, int position) {
    for (var listener in onItemLongClickListeners) {
      listener(item, position);
    }
  }

  /// 添加监听事件
  void addItemClickListener(OnItemClickListener listener) {
    onItemClickListeners.add(listener);
  }

  void addItemLongClickListener(OnItemLongClickListener listener) {
    onItemLongClickListeners.add(listener);
  }

  /// 移除监听事件
  void removeItemClickListener(OnItemClickListener listener) {
    onItemClickListeners.remove(listener);
  }

  void removeItemLongClickListener(OnItemLongClickListener listener) {
    onItemClickListeners.remove(listener);
  }
}

/// 事件绑定器
abstract class EventsBinder {
  /// [OnEventListener]总线绑定[itemView]
  OnEventListener get bindEventListener;
}

/// 点击事件监听
typedef OnItemClickListener<E> = void Function(E item, int position);

/// 长按事件监听
typedef OnItemLongClickListener<E> = void Function(E item, int position);

/// 双击事件监听
typedef OnItemDoubleClickListener<E> = void Function(E item, int position);
