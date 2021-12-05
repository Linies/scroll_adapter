part of rc_core;

mixin NotifyManager implements ReactInterface {
  @override
  // TODO: implement canUpdate
  bool get canUpdate => throw UnimplementedError();

  @override
  void addListener() {
    // TODO: implement addListener
  }

  @override
  void notify() {
    // TODO: implement notify
  }

  @override
  void close() {
    // TODO: implement close
  }
}

abstract class ReactNotifier implements ReactInterface {}

class _ReactImpl extends ReactNotifier with NotifyManager {

}