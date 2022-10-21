part of 'utils.dart';

mixin MockCallback {
  int _counter = 0;

  bool called(int expected) => _counter == expected;
}

class MockValueCallBack with MockCallback {
  call(String value) => _counter += 1;
}

class MockVoidCallBack with MockCallback {
  call() => _counter += 1;
}

class MockFutureCallBack with MockCallback {
  Future call() async => _counter += 1;
}
