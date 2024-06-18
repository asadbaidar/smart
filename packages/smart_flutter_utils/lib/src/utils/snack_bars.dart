part of 'utils.dart';

class Snackbars {
  const Snackbars._();

  static SnackBar success(
    BuildContext context, {
    required String text,
  }) =>
      _snackbar(context, text, Icons.check_rounded);

  static SnackBar error(
    BuildContext context, {
    required String text,
  }) =>
      _snackbar(context, text, Icons.warning_amber_rounded);

  static SnackBar info(
    BuildContext context, {
    required String text,
  }) =>
      _snackbar(context, text, Icons.info_outline_rounded);

  static SnackBar _snackbar(
    BuildContext context,
    String text,
    IconData icon,
  ) {
    final foregroundColor =
        context.theme.snackBarTheme.backgroundColor?.contrast ?? Colors.white;
    return SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Row(
        children: [
          Icon(
            icon,
            color: foregroundColor,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: context.bodyLarge?.copyWith(color: foregroundColor),
            ),
          ),
        ],
      ),
    );
  }
}

extension SnackbarContext on BuildContext {
  ScaffoldMessengerState successSnackbar(String text) =>
      ScaffoldMessenger.of(this)
        ..hideCurrentSnackBar()
        ..showSnackBar(Snackbars.success(this, text: text));

  ScaffoldMessengerState errorSnackbar(String? text) =>
      ScaffoldMessenger.of(this)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          Snackbars.error(
            this,
            text: text ?? 'Something went wrong',
          ),
        );

  ScaffoldMessengerState infoSnackbar(String text) => ScaffoldMessenger.of(this)
    ..hideCurrentSnackBar()
    ..showSnackBar(Snackbars.info(this, text: text));
}
