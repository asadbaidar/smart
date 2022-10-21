part of 'utils.dart';

class TimeAgo {
  static String _default = 'en-US';

  /// Sets the default [locale]. By default it is `en-US`.
  ///
  /// Example
  /// ```
  /// setLocaleMessages('fr', FrMessages());
  /// setDefaultLocale('fr');
  /// ```
  static void setDefaultLocale(String locale) {
    timeago.setDefaultLocale(locale);
    _default = locale;
    $logDebug(locale, 'Default locale set to', TimeAgo);
  }

  /// Sets a [locale] with the provided [lookupMessages] to be available when
  /// using the [format] function.
  ///
  /// Example:
  /// ```dart
  /// setLocaleMessages('fr', FrMessages());
  /// ```
  ///
  /// If you want to define locale message implement [LookupMessages] interface
  /// with the desired messages
  ///
  static void setLocaleMessages(String locale, LookupMessages lookupMessages) {
    $logDebug(locale, 'Added ${lookupMessages.runtimeType} to', TimeAgo);
    timeago.setLocaleMessages(locale, lookupMessages);
  }

  /// Formats provided [date] to a fuzzy time like 'a moment ago'
  ///
  /// - If [locale] is passed will look for message for that locale, if you want
  ///   to add or override locales use [setLocaleMessages]. Defaults to 'en'
  /// - If [now] is passed this will be the point of reference for calculating
  ///   the elapsed time. Defaults to DateTime.now()
  /// - If [max] is passed, format will only happen between that duration and
  ///   beyond that simple date format will be shown. To avoid format limits,
  ///   Pass `null`.
  /// - If [short] is passed, format will use the short version of locale. i.e.
  ///   for `en_short` locale 5 minute ago will format as `5m`
  /// - If [withFuture] is passed, format will use the From prefix, ie. a date
  ///   5 minutes from now in 'en' locale will display as "5 minutes from now"
  static String format(
    DateTime date, {
    String? locale,
    DateTime? now,
    Duration? max,
    bool short = false,
    bool withFuture = false,
  }) =>
      max != null && (now ?? SmartDate.now).difference(date) > max
          ? short
              ? date.formatMMMdy_Y
              : date.formatMMMMdy_Y
          : timeago.format(
              date,
              locale: (locale ?? _default).post("_short", doIf: short),
              clock: now,
              allowFromNow: withFuture,
            );

  /// Formats provided [date] to a fuzzy time like `5m`
  ///
  /// - If [locale] is passed will look for message for that locale, if you want
  ///   to add or override locales use [setLocaleMessages].
  ///   Defaults to `en_short`
  /// - If [now] is passed this will be the point of reference for calculating
  ///   the elapsed time. Defaults to DateTime.now()
  /// - If [max] is passed, format will only happen between that duration and
  ///   beyond that simple date format will be shown. To avoid format limits,
  ///   Pass `null`.
  /// - If [withFuture] is passed, format will use the From prefix. ie. `5m`
  static String formatShort(
    DateTime date, {
    String? locale,
    DateTime? now,
    Duration? max,
    bool withFuture = false,
  }) =>
      format(
        date,
        locale: locale,
        now: now,
        max: max,
        short: true,
        withFuture: withFuture,
      );
}

extension DateTimeAgo on DateTime {
  /// Formats date to a fuzzy time like 'a moment ago'
  ///
  /// - If [locale] is passed will look for message for that locale, if you want
  ///   to add or override locales use [TimeAgo.setLocaleMessages].
  ///   Defaults to 'en'
  /// - If [now] is passed this will be the point of reference for calculating
  ///   the elapsed time. Defaults to DateTime.now()
  /// - If [max] is passed, format will only happen between that duration and
  ///   beyond that simple date format will be shown. To avoid format limits,
  ///   Pass `null`.
  /// - If [short] is passed, format will use the short version of locale. i.e.
  ///   for `en_short` locale 5 minute ago will format as `5m`
  /// - If [withFuture] is passed, format will use the From prefix, ie. a date
  ///   5 minutes from now in 'en' locale will display as "5 minutes from now"
  String formatAgo({
    String? locale,
    DateTime? now,
    Duration? max,
    bool short = false,
    bool withFuture = false,
  }) =>
      TimeAgo.format(
        this,
        locale: locale,
        now: now,
        max: max,
        short: short,
        withFuture: withFuture,
      );

  /// Formats date to a fuzzy time like `5m`
  ///
  /// - If [locale] is passed will look for message for that locale, if you want
  ///   to add or override locales use [TimeAgo.setLocaleMessages].
  ///   Defaults to `en_short`
  /// - If [now] is passed this will be the point of reference for calculating
  ///   the elapsed time. Defaults to DateTime.now()
  /// - If [max] is passed, format will only happen between that duration and
  ///   beyond that simple date format will be shown. To avoid format limits,
  ///   Pass `null`.
  /// - If [withFuture] is passed, format will use the From prefix. ie. `5m`
  String formatAgoShort({
    String? locale,
    DateTime? now,
    Duration? max,
    bool withFuture = false,
  }) =>
      TimeAgo.formatShort(
        this,
        locale: locale,
        now: now,
        max: max,
        withFuture: withFuture,
      );
}

extension DateTimeLeft on DateTime {
  /// Formats date to a fuzzy time like 'a moment from now'
  ///
  /// - If [locale] is passed will look for message for that locale, if you want
  ///   to add or override locales use [TimeAgo.setLocaleMessages].
  ///   Defaults to 'en'
  /// - If [now] is passed this will be the point of reference for calculating
  ///   the elapsed time. Defaults to DateTime.now()
  /// - If [max] is passed, format will only happen between that duration and
  ///   beyond that simple date format will be shown. To avoid format limits,
  ///   Pass `null`.
  /// - If [short] is passed, format will use the short version of locale. i.e.
  ///   for `en_short` locale 5 minute ago will format as `5m`
  String formatLeft({
    String? locale,
    DateTime? now,
    Duration? max,
    bool short = false,
  }) =>
      TimeAgo.format(
        this,
        locale: locale,
        now: now,
        max: max,
        short: short,
        withFuture: true,
      );

  /// Formats date to a fuzzy time like `5m`
  ///
  /// - If [locale] is passed will look for message for that locale, if you want
  ///   to add or override locales use [TimeAgo.setLocaleMessages].
  ///   Defaults to `en_short`
  /// - If [now] is passed this will be the point of reference for calculating
  ///   the elapsed time. Defaults to DateTime.now()
  /// - If [max] is passed, format will only happen between that duration and
  ///   beyond that simple date format will be shown. To avoid format limits,
  ///   Pass `null`.
  String formatLeftShort({
    String? locale,
    DateTime? now,
    Duration? max,
  }) =>
      TimeAgo.formatShort(
        this,
        locale: locale,
        now: now,
        max: max,
        withFuture: true,
      );
}

/// English Messages
class EnMessages implements LookupMessages {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => 'ago';
  @override
  String suffixFromNow() => 'left';
  @override
  String lessThanOneMinute(int seconds) => 'few seconds';
  @override
  String aboutAMinute(int minutes) => '1 min';
  @override
  String minutes(int minutes) => '$minutes mins';
  @override
  String aboutAnHour(int minutes) => '1 hr';
  @override
  String hours(int hours) => '$hours hrs';
  @override
  String aDay(int hours) => '1 day';
  @override
  String days(int days) => '$days days';
  @override
  String aboutAMonth(int days) => '1 month';
  @override
  String months(int months) => '$months months';
  @override
  String aboutAYear(int year) => '1 year';
  @override
  String years(int years) => '$years years';
  @override
  String wordSeparator() => ' ';
}

typedef LookupMessages = timeago.LookupMessages;
typedef ArMessages = timeago.ArMessages;
typedef AzMessages = timeago.AzMessages;
typedef CaMessages = timeago.CaMessages;
typedef CsMessages = timeago.CsMessages;
typedef DaMessages = timeago.DaMessages;
typedef DeMessages = timeago.DeMessages;
typedef DvMessages = timeago.DvMessages;
// typedef EnMessages = timeago.EnMessages;
typedef EsMessages = timeago.EsMessages;
typedef FaMessages = timeago.FaMessages;
typedef FrMessages = timeago.FrMessages;
typedef GrMessages = timeago.GrMessages;
typedef HeMessages = timeago.HeMessages;
typedef HiMessages = timeago.HiMessages;
typedef IdMessages = timeago.IdMessages;
typedef ItMessages = timeago.ItMessages;
typedef JaMessages = timeago.JaMessages;
typedef KmMessages = timeago.KmMessages;
typedef KoMessages = timeago.KoMessages;
typedef KuMessages = timeago.KuMessages;
typedef MnMessages = timeago.MnMessages;
typedef MsMyMessages = timeago.MsMyMessages;
typedef NbNoMessages = timeago.NbNoMessages;
typedef NlMessages = timeago.NlMessages;
typedef NnNoMessages = timeago.NnNoMessages;
typedef PlMessages = timeago.PlMessages;
typedef PtBrMessages = timeago.PtBrMessages;
typedef RoMessages = timeago.RoMessages;
typedef RuMessages = timeago.RuMessages;
typedef RwMessages = timeago.RwMessages;
typedef SvMessages = timeago.SvMessages;
typedef TaMessages = timeago.TaMessages;
typedef ThMessages = timeago.ThMessages;
typedef TrMessages = timeago.TrMessages;
typedef UkMessages = timeago.UkMessages;
typedef ViMessages = timeago.ViMessages;
typedef ZhCnMessages = timeago.ZhCnMessages;
typedef ZhMessages = timeago.ZhMessages;
