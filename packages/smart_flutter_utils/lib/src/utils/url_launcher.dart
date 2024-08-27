import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smart_flutter_utils/smart_flutter_utils.dart';

extension LaunchUrlNullableString on String? {
  Future<void> launchURL({
    BuildContext? context,
    String error = 'Something went wrong while opening the url.',
    LaunchMode mode = LaunchMode.externalApplication,
    bool httpOnly = false,
    VoidCallback? onError,
  }) async {
    $debugLog(this);
    final vUrl = this;
    if (vUrl == null) {
      if (context != null) context.errorSnackbar(error);
      return;
    }
    final url = !httpOnly || vUrl.startsWith(RegExp('^(http|https)://'))
        ? vUrl
        : 'http://$vUrl';
    final uri = Uri.tryParse(url);
    if (uri != null && await canLaunchUrl(uri)) {
      try {
        await launchUrl(uri, mode: mode);
      } catch (e) {
        $debugLog(e, tag: this);
        if (context?.mounted == true) context?.errorSnackbar(error);

        onError?.call();
      }
    } else {
      $debugLog(error, tag: this);
      if (context?.mounted == true) context?.errorSnackbar(error);

      onError?.call();
    }
  }

  Future<void> launchInBrowser(BuildContext context) => launchURL(
        context: context,
        mode: LaunchMode.inAppBrowserView,
        httpOnly: true,
      );
}

extension LaunchUrlString on String {
  Future<void> launchMailto([BuildContext? context]) =>
      'mailto:$this'.launchURL(
        context: context,
        error: 'No mailing app installed.',
      );

  Future<void> launchTel([BuildContext? context]) => 'tel:$this'.launchURL(
        context: context,
        error: 'Unable to make a call.',
      );
}
