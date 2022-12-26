part of 'theme.dart';

extension PlatformContext on BuildContext {
  TargetPlatform get platform => theme.platform;

  bool get isIOS => platform.isIOS;

  bool get isAndroid => platform.isAndroid;

  bool get isIOSWeb => platform.isIOSWeb;

  bool get isAndroidWeb => platform.isAndroidWeb;

  bool get isLinux => platform.isLinux;

  bool get isMacOS => platform.isMacOS;

  bool get isWindows => platform.isWindows;

  bool get isFuchsia => platform.isFuchsia;

  bool get isWeb => platform.isWeb;
}

extension TargetPlatformX on TargetPlatform {
  bool get isIOS => this == TargetPlatform.iOS;

  bool get isAndroid => this == TargetPlatform.android;

  bool get isIOSWeb => isWeb && isIOS;

  bool get isAndroidWeb => isWeb && isAndroid;

  bool get isLinux => this == TargetPlatform.linux;

  bool get isMacOS => this == TargetPlatform.macOS;

  bool get isWindows => this == TargetPlatform.windows;

  bool get isFuchsia => this == TargetPlatform.fuchsia;

  bool get isWeb => kIsWeb;
}
