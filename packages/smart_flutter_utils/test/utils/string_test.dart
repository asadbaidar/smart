import 'package:flutter_test/flutter_test.dart';

import 'package:smart_flutter_utils/smart_flutter_utils.dart';

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

    test("String.post()", () {
      expect(text.post("*"), "hello*");
      expect(text.post("*", doFor: 2), "hello**");
      expect(text.post("*", doFor: 3), "hello***");
      expect(text.post("*", between: " "), "hello *");
      expect(text.post(null), "hello");
      expect(text.post("*", doIf: false), "hello");
    });

    test("String.surround()", () {
      expect(text.surround("*"), "*hello*");
      expect(text.surround("*", doFor: 2), "**hello**");
      expect(text.surround("*", doFor: 3), "***hello***");
      expect(text.surround("*", between: " "), "* hello *");
      expect(text.surround(null), "hello");
      expect(text.surround("*", doIf: false), "hello");
    });
  });

  group("StringIntials extension", () {
    const text1 = "Hello   World  (   Greetings )   -    Program";
    const text2 = "Text 2";

    test("String.takeInitials()", () {
      expect(text1.takeInitials(1), "H");
      expect(text1.takeInitials(2), "HW");
      expect(text1.takeInitials(4), "HW(G");

      expect(text2.takeInitials(5, fill: true), "TEXT");
      expect(text2.takeInitials(5), "T2");
    });

    test("String.takeInitialsWithoutGarbage()", () {
      expect(text1.takeInitialsWithoutGarbage(3), "HWG");
      expect(text1.takeInitialsWithoutGarbage(5), "HWGP");
      expect(text1.takeInitialsWithoutGarbage(5, fill: true), "HELLO");
    });
  });
}
