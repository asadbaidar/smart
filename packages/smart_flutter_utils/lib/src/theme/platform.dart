part of 'theme.dart';

extension PlatformContext on BuildContext {
  ThemeData get theme => Theme.of(this);

  TargetPlatform get platform => theme.platform;

  bool get isIOS => platform == TargetPlatform.iOS;

  bool get isAndroid => platform == TargetPlatform.android;

  bool get isIOSWeb => isWeb && isIOS;

  bool get isAndroidWeb => isWeb && isAndroid;

  bool get isLinux => platform == TargetPlatform.linux;

  bool get isMacOS => platform == TargetPlatform.macOS;

  bool get isWindows => platform == TargetPlatform.windows;

  bool get isFuchsia => platform == TargetPlatform.fuchsia;

  bool get isWeb => kIsWeb;
}
