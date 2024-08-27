import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:smart_flutter_utils/smart_flutter_utils.dart';

extension DateTimePickerContext on BuildContext {
  Future<void> timePicker({
    DateTime? withTime,
    String? cancelText,
    String? confirmText,
    String? helpText,
    TimePickerEntryMode entryMode = TimePickerEntryMode.input,
    TransitionBuilder? builder,
    bool useRootNavigator = true,
    RouteSettings? routeSettings,
    required void Function(DateTime time) onPick,
    VoidCallback? onCancel,
  }) async {
    final time = await showTimePicker(
      context: this,
      initialTime: withTime?.timeOfDay ?? TimeOfDay.now(),
      cancelText: cancelText,
      confirmText: confirmText,
      helpText: helpText,
      initialEntryMode: entryMode,
      builder: builder,
      useRootNavigator: useRootNavigator,
      routeSettings: routeSettings,
    );
    if (time != null) {
      onPick(
        withTime?.setting(timeOfDay: time) ?? SmartDate.from(timeOfDay: time),
      );
    } else {
      onCancel?.call();
    }
  }

  Future<void> datePicker({
    DateTime? withDate,
    DateTime? minDate,
    DateTime? maxDate,
    DateTime? currentDate,
    String? cancelText,
    String? confirmText,
    String? helpText,
    String? errorFormatText,
    String? errorInvalidText,
    String? fieldHintText,
    String? fieldLabelText,
    DatePickerEntryMode entryMode = DatePickerEntryMode.calendar,
    DatePickerMode calenderMode = DatePickerMode.day,
    SelectableDayPredicate? selectableDayPredicate,
    Locale? locale,
    bool useRootNavigator = true,
    RouteSettings? routeSettings,
    TransitionBuilder? builder,
    required void Function(DateTime date) onPick,
    VoidCallback? onCancel,
  }) async {
    final date = await showDatePicker(
      context: this,
      initialDate: withDate ?? SmartDate.now,
      firstDate: minDate ?? SmartDate.from(year: 2000),
      lastDate: maxDate ?? SmartDate.now,
      currentDate: currentDate,
      cancelText: cancelText,
      confirmText: confirmText,
      helpText: helpText,
      errorFormatText: errorFormatText,
      errorInvalidText: errorInvalidText,
      fieldHintText: fieldHintText,
      fieldLabelText: fieldLabelText,
      initialEntryMode: entryMode,
      initialDatePickerMode: calenderMode,
      selectableDayPredicate: selectableDayPredicate,
      locale: locale,
      useRootNavigator: useRootNavigator,
      routeSettings: routeSettings,
      builder: builder,
    );
    if (date != null) {
      onPick(withDate?.setting(date: date) ?? date);
    } else {
      onCancel?.call();
    }
  }

  Future<void> dateRangePicker({
    DateTimeRange? withRange,
    DateTime? minDate,
    DateTime? maxDate,
    DateTime? currentDate,
    String? cancelText,
    String? confirmText,
    String? saveText,
    String? helpText,
    String? errorFormatText,
    String? errorInvalidText,
    String? errorInvalidRangeText,
    String? fieldEndHintText,
    String? fieldEndLabelText,
    String? fieldStartHintText,
    String? fieldStartLabelText,
    DatePickerEntryMode entryMode = DatePickerEntryMode.calendar,
    ui.TextDirection? textDirection,
    Locale? locale,
    bool useRootNavigator = true,
    RouteSettings? routeSettings,
    TransitionBuilder? builder,
    required void Function(DateTimeRange range) onPick,
    VoidCallback? onCancel,
  }) async {
    final range = await showDateRangePicker(
      context: this,
      initialDateRange: withRange,
      firstDate: minDate ?? SmartDate.from(year: 2000),
      lastDate: maxDate ?? SmartDate.now,
      currentDate: currentDate,
      cancelText: cancelText,
      confirmText: confirmText,
      saveText: saveText,
      helpText: helpText,
      errorFormatText: errorFormatText,
      errorInvalidText: errorInvalidText,
      errorInvalidRangeText: errorInvalidRangeText,
      initialEntryMode: entryMode,
      fieldEndHintText: fieldEndHintText,
      fieldEndLabelText: fieldEndLabelText,
      fieldStartHintText: fieldStartHintText,
      fieldStartLabelText: fieldStartLabelText,
      textDirection: textDirection,
      locale: locale,
      useRootNavigator: useRootNavigator,
      routeSettings: routeSettings,
      builder: builder ??
          (context, child) => Theme(
                data: context.theme.copyWith(brightness: Brightness.dark),
                child: child!,
              ),
    );
    if (range != null) {
      onPick(
        withRange?.apply(
              () => withRange
                ..start.setting(date: range.start)
                ..end.setting(date: range.end),
            ) ??
            range,
      );
    } else {
      onCancel?.call();
    }
  }
}
