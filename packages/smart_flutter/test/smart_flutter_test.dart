import 'package:flutter_test/flutter_test.dart';

import 'package:smart_flutter/smart_flutter.dart';

/// smart_flutter_test
void main() {
  group("StringConcatenation extension", () {
    const text = "hello";
    const textBlank = " ";
    const affix = "*";

    test("String.prefix()", () {
      expect(text.prefix(affix), "*hello");
      expect(text.prefix(affix, doFor: 2), "**hello");
      expect(text.prefix(affix, doFor: 3), "***hello");

      expect(text.prefix(affix, infix: " "), "* hello");
      expect(text.prefix(affix, infix: " ", doFor: 2), "* * hello");

      expect(
        text.prefix(affix, infix: " ", suffix: "+"),
        "* hello+",
      );
      expect(
        text.prefix(affix, infix: " ", suffix: "+", doFor: 2),
        "* * hello++",
      );

      expect(text.prefix(affix, doIf: false), text);
      expect(text.prefix(null), text);
      expect(text.prefix(" "), text);
      expect(textBlank.prefix(affix), textBlank);
      expect(textBlank.prefix(affix, notBlank: false), "* ");
    });

    test("String.suffix()", () {
      expect(text.suffix(affix), "hello*");
      expect(text.suffix(affix, doFor: 2), "hello**");
      expect(text.suffix(affix, doFor: 3), "hello***");

      expect(text.suffix(affix, infix: " "), "hello *");
      expect(text.suffix(affix, infix: " ", doFor: 2), "hello * *");

      expect(
        text.suffix(affix, infix: " ", prefix: "+"),
        "+hello *",
      );
      expect(
        text.suffix(affix, infix: " ", prefix: "+", doFor: 2),
        "++hello * *",
      );

      expect(text.suffix(affix, doIf: false), text);
      expect(text.suffix(null), text);
      expect(text.suffix(" "), text);
      expect(textBlank.suffix(affix), textBlank);
      expect(textBlank.suffix(affix, notBlank: false), " *");
    });

    test("String.confix()", () {
      expect(text.confix(affix), "*hello*");
      expect(text.confix(affix, doFor: 2), "**hello**");
      expect(text.confix(affix, doFor: 3), "***hello***");

      expect(text.confix(affix, infix: " "), "* hello *");
      expect(text.confix(affix, infix: " ", doFor: 2), "* * hello * *");

      expect(
        text.confix(affix, infix: " ", prefix: "+"),
        "+* hello *",
      );
      expect(
        text.confix(affix, infix: " ", prefix: "+", doFor: 2),
        "++* * hello * *",
      );

      expect(
        text.confix(affix, infix: " ", prefix: "+", suffix: "-"),
        "+* hello *-",
      );
      expect(
        text.confix(affix, infix: " ", prefix: "+", suffix: "-", doFor: 2),
        "++* * hello * *--",
      );

      expect(text.confix(affix, doIf: false), text);
      expect(text.confix(null), text);
      expect(text.confix(" "), text);
      expect(textBlank.confix(affix), textBlank);
      expect(textBlank.confix(affix, notBlank: false), "* *");
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
