part of rc_core;
/// 可提供给Item的响应式包装

/// interface
abstract class ReactInterface {
  bool get canUpdate;

  void addListener();

  void notify();

  void close();
}