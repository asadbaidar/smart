part of 'utils.dart';

extension StringConcatenation on String {
  String prefix(
    prefix, {
    int doFor = 1,
    bool doIf = true,
    bool notBlank = true,
    infix,
    suffix,
  }) {
    final vPrefix = prefix?.toString() ?? "";
    final vInfix = infix?.toString() ?? "";
    final vSuffix = suffix?.toString() ?? "";
    final vDoIf = doIf && (!notBlank || isNotBlank) && vPrefix.isNotBlank;
    return applyFor(
      vDoIf ? doFor : 0,
      (s) => vPrefix + vInfix + s + vSuffix,
    );
  }

  String suffix(
    suffix, {
    int doFor = 1,
    bool doIf = true,
    bool notBlank = true,
    infix,
    prefix,
  }) {
    final vSuffix = suffix?.toString() ?? "";
    final vInfix = infix?.toString() ?? "";
    final vPrefix = prefix?.toString() ?? "";
    final vDoIf = doIf && (!notBlank || isNotBlank) && vSuffix.isNotBlank;
    return applyFor(
      vDoIf ? doFor : 0,
      (s) => vPrefix + s + vInfix + vSuffix,
    );
  }

  String confix(
    confix, {
    int doFor = 1,
    bool doIf = true,
    bool notBlank = true,
    infix,
    prefix,
    suffix,
  }) =>
      this
          .prefix(
            confix,
            doFor: doFor,
            doIf: doIf,
            notBlank: notBlank,
            infix: infix,
          )
          .suffix(
            confix,
            doFor: doFor,
            doIf: doIf,
            notBlank: notBlank,
            infix: infix,
          )
          .prefix(
            prefix,
            doFor: doFor,
            doIf: doIf,
            notBlank: notBlank,
            suffix: suffix,
          );
}

extension StringIntials on String {
  static const garbage = ["(", ")", "-", "&", "/", "."];

  String takeInitialsWithoutGarbage(
    int count, {
    bool fill = false,
    List<String> garbage = garbage,
  }) =>
      takeInitials(
        count,
        fill: fill,
        withoutGarbage: true,
        garbage: garbage,
      );

  String takeInitials(
    int count, {
    bool fill = false,
    bool withoutGarbage = false,
    List<String> garbage = garbage,
  }) {
    var source = replaceAll(RegExp(r"\s+"), " ").trim();
    if (source.isNotEmpty) {
      if (withoutGarbage) {
        source = source
            .applyForIndexed<String>(
                garbage.length,
                (s, i) => s.replaceAll(
                      RegExp(r"\s*\" + garbage[i] + r"\s*",
                          caseSensitive: false),
                      " ",
                    ))
            .trim();
      }
      if (!source.contains(" ")) {
        return source.take(fill ? count : 1).trim().uppercase;
      }
      final initials = StringBuffer("");
      final sourceParts = source.split(" ");
      for (int i = 0; i < sourceParts.length; i++) {
        if (i == count) break;
        try {
          initials.write(sourceParts[i].trim().take());
        } catch (e) {
          $debugPrint(e, source);
        }
      }
      final vInitials = initials.toString();
      return (fill && vInitials.length < count
              ? source.take(count).trim()
              : vInitials)
          .uppercase;
    }
    return source;
  }
}

extension StringCharacters on String {
  String take([int count = 1]) => characters.take(count).toString();

  String takeWhile(bool Function(String) predicate) =>
      characters.takeWhile(predicate).toString();

  String takeLast([int count = 1]) => characters.takeLast(count).toString();

  String takeLastWhile(bool Function(String) predicate) =>
      characters.takeLastWhile(predicate).toString();

  String skip([int count = 1]) => characters.skip(count).toString();

  String skipWhile(bool Function(String) predicate) =>
      characters.skipWhile(predicate).toString();

  String skipLast([int count = 1]) => characters.skipLast(count).toString();

  String skipLastWhile(bool Function(String) predicate) =>
      characters.skipLastWhile(predicate).toString();

  String get afterDot => takeLastWhile((s) => s != ".");
}

extension StringConditionals on String {
  String? get notEmpty => isEmpty ? null : this;

  String? get notBlank => isBlank ? null : this;

  bool get isBlank => isEmpty || trim().isEmpty;

  bool get isNotBlank => !isBlank;

  bool equalsIgnoreCase(String? s) => lowercase == s?.lowercase;

  bool containsIgnoreCase(String? s) =>
      s == null ? false : lowercase.contains(s.lowercase);

  bool isPasswordStrong({int min = 8}) {
    if (isBlank) return false;

    bool hasUppercase = contains(RegExp(r'[A-Z]'));
    bool hasLowercase = contains(RegExp(r'[a-z]'));
    bool hasDigits = contains(RegExp(r'[0-9]'));
    bool hasSpecialCharacters = contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    bool hasNoWhitespace = !contains(RegExp(r'[\s]'));
    bool hasMinLength = length >= min;

    return hasUppercase &&
        hasLowercase &&
        hasDigits &&
        hasSpecialCharacters &&
        hasNoWhitespace &&
        hasMinLength;
  }
}

extension StringConversions on String {
  /// Uppercase each word inside string
  /// Example: your name => YOUR NAME
  String get uppercase => toUpperCase();

  /// Lowercase each word inside string
  /// Example: Your Name => your name
  String get lowercase => toLowerCase();

  /// Lowercase first letter of string
  /// Example: Your Name => your Name
  String get lowercaseFirst => isBlank == true
      ? ""
      : length == 1
          ? lowercase
          : this[0].lowercase + substring(1);

  /// Capitalize each word inside string
  /// Example: your name => Your Name
  String get capitalized => isBlank
      ? ""
      : length == 1
          ? uppercase
          : split(" ").map((s) => s.capitalizedFirst).join(" ");

  /// Uppercase first letter inside string and let the others lowercase
  /// Example: your name => Your name
  String get capitalizedFirst => isBlank == true
      ? ""
      : length == 1
          ? uppercase
          : this[0].uppercase + substring(1).lowercase;

  int toInt() => int.tryParse(this) ?? 0;

  int? toIntOrNull() => int.tryParse(this);

  double toDouble() => double.tryParse(this) ?? 0.0;

  double? toDoubleOrNull() => double.tryParse(this);

  Uri? get uri => Uri.tryParse(this);

  get json => jsonDecode(this);

  get jsonOrString {
    try {
      return jsonDecode(this);
    } catch (e) {
      return this;
    }
  }
}

extension StringBase64 on String {
  Uint8List? get base64Decoded {
    try {
      return isEmpty ? null : base64Decode(this);
    } catch (e) {
      $debugPrint(e, "base64Decoded");
      return null;
    }
  }

  String get base64Encoded {
    try {
      final bytes = toBytes();
      return bytes == null ? this : base64Encode(bytes);
    } catch (e) {
      $debugPrint(e, "base64Encoded");
      return this;
    }
  }
}

extension StringToBytes on String {
  Uint8List? toBytes() {
    try {
      return utf8.encoder.convert(this);
    } catch (e) {
      $debugPrint(e, "toBytes");
      return null;
    }
  }

  List<int>? toUTF8() {
    try {
      return utf8.encode(this);
    } catch (e) {
      $debugPrint(e, "toUTF8");
      return null;
    }
  }
}

extension StringFromBytes on Uint8List {
  String? get base64Encoded {
    try {
      return isEmpty ? null : base64Encode(this);
    } catch (e) {
      $debugPrint(e, "base64Encoded");
      return null;
    }
  }

  String? toUTF8() {
    try {
      return utf8.decoder.convert(this);
    } catch (e) {
      $debugPrint(e, "toUTF8");
      return null;
    }
  }
}

extension StringToColor on String {
  Color? toColor() {
    try {
      final hex = replaceAll("#", "");
      if (hex.length == 6) {
        return Color(int.parse("FF$hex", radix: 16));
      } else if (hex.length == 8) {
        return Color(int.parse(hex, radix: 16));
      }
    } catch (e) {
      $debugPrint(e, "toColor");
    }
    return null;
  }
}

extension StringToImageProvider on String {
  AssetImage assetImage({
    AssetBundle? bundle,
    String? package,
  }) =>
      AssetImage(this, bundle: bundle, package: package);

  NetworkImage networkImage({
    double scale = 1.0,
    Map<String, String>? headers,
  }) =>
      NetworkImage(this, scale: scale, headers: headers);
}
