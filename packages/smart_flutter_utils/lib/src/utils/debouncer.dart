import 'dart:async';

import 'package:smart_flutter_utils/smart_flutter_utils.dart';

/// {@template debouncer}
/// Creates a debouncer that will [run] a callback after [duration] has passed
/// and will cancel any previous pending calls.
/// {@endtemplate}
class Debouncer {
  /// {@macro debouncer}
  Debouncer({this.duration = const Duration(milliseconds: 500)});

  /// The duration to wait before running the callback.
  final Duration duration;

  // Completer to handle the completion of the Future
  Completer<void>? _completer;

  /// Timer to trigger the callback after [duration] has passed.
  Timer? _timer;

  /// Cancels any pending calls and runs an [action] callback after
  /// [duration] has passed.
  Future<void> run(FutureOrCallback<void> action) {
    cancel();
    _completer = Completer<void>();

    _timer = Timer(duration, () async {
      await action();
      _complete();
    });
    return _completer!.future;
  }

  /// Cancels any pending calls.
  void cancel() {
    _timer?.cancel();
    _complete();
  }

  void _complete() {
    if (!(_completer?.isCompleted ?? false)) _completer?.complete();
  }
}
