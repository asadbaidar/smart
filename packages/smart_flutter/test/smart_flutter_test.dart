import 'package:flutter_test/flutter_test.dart';

import 'package:smart_flutter/smart_flutter.dart';

void main() {
  group("StringConcatenation extension", () {
    const text = "hello";

    test("String.pre()", () {
      expect(text.pre("*"), "*hello");
      expect(text.pre("*", doFor: 2), "**hello");
      expect(text.pre("*", doFor: 3), "***hello");
      expect(text.pre("*", between: " "), "* hello");
      expect(text.pre(null), "hello");
      expect(text.pre("*", doIf: false), "hello");
    });
  });
}
