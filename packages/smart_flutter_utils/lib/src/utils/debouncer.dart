part of 'utils.dart';

/// {@template debouncer}
/// Creates a debouncer that will [run] a callback after [duration] has passed
/// and will cancel any previous pending calls.
/// {@endtemplate}
class Debouncer {
  /// {@macro debouncer}
  Debouncer({this.duration = const Duration(milliseconds: 500)});

  /// The duration to wait before running the callback.
  final Duration duration;

  Timer? _timer;

  /// Cancels any pending calls and runs an [action] callback after
  /// [duration] has passed.
  void run(VoidCallback action) {
    if (_timer != null) {
      _timer?.cancel();
    }
    _timer = Timer(duration, action);
  }
}
