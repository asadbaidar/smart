// ignore_for_file: avoid_print
part of 'utils.dart';

abstract class SmartLogger {
  static bool enableLogs = kDebugMode;
  static bool enableEvents = kReleaseMode;

  static SmartLogger? instance;

  void logEvent({required String name, Map<String, Object?>? parameters});

  void _logEvent(info, tag, Object? name, {bool debug = false}) => logEvent(
        name: name?.toString().notEmpty ?? (debug ? "DebugEvent" : "Event"),
        parameters: {
          "time": DateTime.now(),
          "tag": tag?.toString() ?? "null",
          "info": info?.toString().trim() ?? "null",
        },
      );
}

void $logDebug([info, tag, Object? name = ""]) {
  if (SmartLogger.enableLogs) {
    _logDebug(info, tag, name);
  }
  if (SmartLogger.enableEvents) {
    SmartLogger.instance?._logEvent(info, tag, name, debug: true);
  }
}

void $logPrint([info, tag, Object? name]) {
  if (SmartLogger.enableLogs) {
    _logPrint(info, tag, name);
  }
  if (SmartLogger.enableEvents) {
    SmartLogger.instance?._logEvent(info, tag, name);
  }
}

extension SmartLoggerX<T> on T {
  void $debugPrint([info, tag]) {
    $logDebug(
      info ?? toString(),
      tag,
      runtimeType.toString(),
    );
  }

  void $print([info, tag]) => $logPrint(
        info ?? toString(),
        tag,
        runtimeType.toString(),
      );
}

void _logDebug([info, tag, Object? name = ""]) {
  final vTag = tag == null ? "" : "$tag: ";
  developer.log(
    "$vTag${info ?? ""}".trim(),
    time: DateTime.now(),
    name: name?.toString() ?? "",
  );
}

void _logPrint([info, tag, Object? name]) {
  final vName = name == null ? "" : "[$name] ";
  final vTag = tag == null ? "" : "$tag: ";
  print("$vName$vTag${info ?? ""}".trim());
}
