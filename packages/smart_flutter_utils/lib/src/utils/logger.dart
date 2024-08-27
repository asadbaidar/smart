// ignore_for_file: avoid_print, no_runtimetype_tostring
import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:smart_flutter_utils/smart_flutter_utils.dart';

abstract class SmartLogger {
  static bool enableLogs = kDebugMode;
  static bool enableEvents = kReleaseMode;

  static SmartLogger? instance;

  void eventLog({required String name, Map<String, Object?>? parameters});

  void _eventLog(
    dynamic info, {
    String? tag,
    StackTrace? stackTrace,
    bool debug = false,
  }) =>
      eventLog(
        name: tag?.notEmpty ?? (debug ? 'DebugEvent' : 'Event'),
        parameters: {
          'time': DateTime.now(),
          'info': info?.toString().trim() ?? 'null',
          'stackTrace': stackTrace?.toString() ?? 'null',
        },
      );
}

void $debugLog(dynamic info, {String? tag, StackTrace? stackTrace}) {
  if (SmartLogger.enableLogs) {
    _debuglog(info, tag: tag, stackTrace: stackTrace);
  }
  if (SmartLogger.enableEvents) {
    SmartLogger.instance?._eventLog(info, tag: tag, debug: true);
  }
}

void $printLog(dynamic info, {String? tag, StackTrace? stackTrace}) {
  if (SmartLogger.enableLogs) {
    _printLog(info, tag: tag, stackTrace: stackTrace);
  }
  if (SmartLogger.enableEvents) {
    SmartLogger.instance?._eventLog(
      info,
      tag: tag,
      stackTrace: stackTrace,
      debug: true,
    );
  }
}

extension SmartLoggerX<T> on T {
  void $debugPrint(dynamic info, {String? tag, StackTrace? stackTrace}) {
    $debugLog(
      info,
      tag: '${tag ?? runtimeType}',
      stackTrace: stackTrace,
    );
  }

  void $debugSelf({String? tag, StackTrace? stackTrace}) {
    $debugLog(
      this,
      tag: '${tag ?? runtimeType}',
      stackTrace: stackTrace,
    );
  }

  void $print(dynamic info, {String? tag, StackTrace? stackTrace}) => $printLog(
        info,
        tag: '${tag ?? runtimeType}',
        stackTrace: stackTrace,
      );

  void $printSelf({String? tag, StackTrace? stackTrace}) => $printLog(
        this,
        tag: '${tag ?? runtimeType}',
        stackTrace: stackTrace,
      );
}

void _debuglog(dynamic info, {String? tag, StackTrace? stackTrace}) {
  developer.log(
    info.toString().trim(),
    time: DateTime.now(),
    name: tag ?? 'debug.log',
    stackTrace: stackTrace,
  );
}

void _printLog(dynamic info, {String? tag, StackTrace? stackTrace}) {
  print(
    '[${tag ?? 'print.log'}] '
    '${info?.toString().trim() ?? ''}'
    '${stackTrace == null ? '' : '\n$stackTrace'}',
  );
}
