// ignore_for_file: non_constant_identifier_names

part of 'utils.dart';

class SmartDate {
  SmartDate._();

  static DateTime from({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
    TimeOfDay? timeOfDay,
    DateTime? date,
    DateTime? time,
  }) {
    final now = SmartDate.now;
    return DateTime(
      year ?? date?.year ?? now.year,
      month ?? date?.month ?? now.month,
      day ?? date?.day ?? now.day,
      hour ?? time?.hour ?? timeOfDay?.hour ?? now.hour,
      minute ?? time?.minute ?? timeOfDay?.minute ?? now.minute,
      second ?? time?.second ?? now.second,
      millisecond ?? time?.millisecond ?? now.millisecond,
      microsecond ?? time?.microsecond ?? now.microsecond,
    );
  }

  static DateTime get now => DateTime.now();
}

extension DateTimeUtils on DateTime {
  DateTime setting({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
    TimeOfDay? timeOfDay,
    DateTime? date,
    DateTime? time,
  }) =>
      DateTime(
        year ?? date?.year ?? this.year,
        month ?? date?.month ?? this.month,
        day ?? date?.day ?? this.day,
        hour ?? time?.hour ?? timeOfDay?.hour ?? this.hour,
        minute ?? time?.minute ?? timeOfDay?.minute ?? this.minute,
        second ?? time?.second ?? this.second,
        millisecond ?? time?.millisecond ?? this.millisecond,
        microsecond ?? time?.microsecond ?? this.microsecond,
      );

  DateTimeRange range(Duration duration) {
    final date = add(duration);
    return date > this
        ? DateTimeRange(start: this, end: date)
        : DateTimeRange(start: date, end: this);
  }

  int get inMilliseconds => millisecondsSinceEpoch;

  bool get isCurrentYear => year == SmartDate.now.year;

  bool get isCurrentMonth => month == SmartDate.now.month;

  TimeOfDay get timeOfDay => TimeOfDay.fromDateTime(this);

  DateTime get afterYear => add(365.days);

  DateTime get after3Month => add(93.days);

  DateTime get afterMonth => add(31.days);

  DateTime get startOfDay => setting(
        hour: 0,
        minute: 0,
        second: 0,
        millisecond: 0,
        microsecond: 0,
      );

  DateTime get endOfDay => setting(
        hour: 23,
        minute: 59,
        second: 59,
        millisecond: 0,
        microsecond: 0,
      );

  bool operator >(DateTime other) => isAfter(other);

  bool operator <(DateTime other) => other.isAfter(this);
}

extension DateTimeFormat on DateTime {
  String get formatY => SmartDateFormat.Y.format(this);

  String get formatEd => SmartDateFormat.Ed.format(this);

  String get formatEdHma => SmartDateFormat.EdHma.format(this);

  String get formatEMMMdy_Y => isCurrentYear ? formatEMMMd : formatEMMMdy;

  String get formatEMMMdy_YM => isCurrentYear
      ? isCurrentMonth
          ? formatEd
          : formatEMMMd
      : formatEMMMdy;

  String get formatEMMMdyHma_Y =>
      isCurrentYear ? formatEMMMdHma : formatEMMMdyHma;

  String get formatEMMMdyHma_YM => isCurrentYear
      ? isCurrentMonth
          ? formatEdHma
          : formatEMMMdHma
      : formatEMMMdyHma;

  String get formatEMMMdy => SmartDateFormat.EMMMdy.format(this);

  String get formatEMMMdyHma => SmartDateFormat.EMMMdyHma.format(this);

  String get formatEMMMd => SmartDateFormat.EMMMd.format(this);

  String get formatEMMMdHma => SmartDateFormat.EMMMdHma.format(this);

  String get formatEEEEMMMMdy_Y =>
      isCurrentYear ? formatEEEEMMMMd : formatEEEEMMMMdy;

  String get formatEEEEMMMMdyHma_Y =>
      isCurrentYear ? formatEEEEMMMMdHma : formatEEEEMMMMdyHma;

  String get formatEEEEMMMMdy => SmartDateFormat.EEEEMMMMdy.format(this);

  String get formatEEEEMMMMdyHma => SmartDateFormat.EEEEMMMMdyHma.format(this);

  String get formatEEEEMMMMd => SmartDateFormat.EEEEMMMMd.format(this);

  String get formatEEEEMMMMdHma => SmartDateFormat.EEEEMMMMdHma.format(this);

  String get formatMMMMdy_Y => isCurrentYear ? formatMMMMd : formatMMMMdy;

  String get formatMMMMdyHma_Y =>
      isCurrentYear ? formatMMMMdHma : formatMMMMdyHma;

  String get formatMMMMdy => SmartDateFormat.MMMMdy.format(this);

  String get formatMMMMdyHma => SmartDateFormat.MMMMdyHma.format(this);

  String get formatMMMMd => SmartDateFormat.MMMMd.format(this);

  String get formatMMMMdHma => SmartDateFormat.MMMMdHma.format(this);

  String get formatMMMdy_Y => isCurrentYear ? formatMMMd : formatMMMdy;

  String get formatMMMdyHma_Y => isCurrentYear ? formatMMMdHma : formatMMMdyHma;

  String get formatMMMdy => SmartDateFormat.MMMdy.format(this);

  String get formatMMMdyHma => SmartDateFormat.MMMdyHma.format(this);

  String get formatMMMd => SmartDateFormat.MMMd.format(this);

  String get formatMMMdHma => SmartDateFormat.MMMdHma.format(this);

  String get formatMdy_Y => isCurrentYear ? formatMd : formatMdy;

  String get formatMdyHma_Y => isCurrentYear ? formatMdHma : formatMdyHma;

  String get formatMdy => SmartDateFormat.Mdy.format(this);

  String get formatMdyHma => SmartDateFormat.MdyHma.format(this);

  String get formatMd => SmartDateFormat.Md.format(this);

  String get formatMdHma => SmartDateFormat.MdHma.format(this);

  /// dd-MMM-yyyy
  String get formatDMMMy => SmartDateFormat.DMMMy.format(this);

  String get formatDMMMyHm => SmartDateFormat.DMMMyHm.format(this);

  String get formatDMMy => SmartDateFormat.DMMy.format(this);

  String get formatDMMyHm => SmartDateFormat.DMMyHm.format(this);

  String get formatYMMd => SmartDateFormat.YMMd.format(this);

  String get formatYMMdHms => SmartDateFormat.YMMdHms.format(this);

  String get formatHma => SmartDateFormat.Hma.format(this);

  String get formatHm => SmartDateFormat.Hm.format(this);

  String get formatHms => SmartDateFormat.Hms.format(this);
}

extension AddInDateFormat on DateFormat {
  /// Add [format] to this stance as a pattern.
  ///
  /// If there was a previous pattern, then this appends to it, separating the
  /// two by [separator].  [format] is first looked up  our list of
  /// known skeletons.  If it's found there, then use the corresponding pattern
  /// for this locale.  If it's not, then treat [format] as an explicit
  /// pattern.
  DateFormat add(DateFormat format, [String separator = ' ']) =>
      addPattern(format.pattern, separator);
}

class SmartDateFormat {
  SmartDateFormat._();

  static DateFormat get Y => DateFormat.y();

  static DateFormat get Ed => DateFormat("E d");

  static DateFormat get EdHma => Ed.add(Hma, ", ");

  static DateFormat get EMMMdy => DateFormat.yMMMEd();

  static DateFormat get EMMMdyHma => EMMMdy.add(Hma, ", ");

  static DateFormat get EMMMd => DateFormat.MMMEd();

  static DateFormat get EMMMdHma => EMMMd.add(Hma, ", ");

  static DateFormat get EEEEMMMMdy => DateFormat.yMMMMEEEEd();

  static DateFormat get EEEEMMMMdyHma => EEEEMMMMdy.add(Hma, ", ");

  static DateFormat get EEEEMMMMd => DateFormat.MMMMEEEEd();

  static DateFormat get EEEEMMMMdHma => EEEEMMMMd.add(Hma, ", ");

  static DateFormat get MMMMdy => DateFormat.yMMMMd();

  static DateFormat get MMMMdyHma => MMMMdy.add(Hma, ", ");

  static DateFormat get MMMMd => DateFormat.MMMMd();

  static DateFormat get MMMMdHma => MMMMd.add(Hma, ", ");

  static DateFormat get MMMdy => DateFormat.yMMMd();

  static DateFormat get MMMdyHma => MMMdy.add(Hma, ", ");

  static DateFormat get MMMd => DateFormat.MMMd();

  static DateFormat get MMMdHma => MMMd.add(Hma, ", ");

  static DateFormat get Mdy => DateFormat.yMd();

  static DateFormat get MdyHma => Mdy.add(Hma, ", ");

  static DateFormat get Md => DateFormat.Md();

  static DateFormat get MdHma => Md.add(Hma, ", ");

  /// dd-MMM-yyyy
  static DateFormat get DMMMy => DateFormat("dd-MMM-yyyy");

  static DateFormat get DMMMyHm => DMMMy.add_Hm();

  static DateFormat get DMMy => DateFormat("dd-MM-yyyy");

  static DateFormat get DMMyHm => DMMy.add_Hm();

  static DateFormat get YMMd => DateFormat("yyyy-MM-dd");

  static DateFormat get YMMdHms => YMMd.add_Hms();

  static DateFormat get Hma => DateFormat("h:mma");

  static DateFormat get Hm => DateFormat.Hm();

  static DateFormat get Hms => DateFormat.Hms();
}
