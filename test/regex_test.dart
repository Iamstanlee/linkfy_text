import 'package:flutter_test/flutter_test.dart';
import 'package:linkify_text/src/utils/regex.dart';

//   final text =
//       "My website url: https://blasanka.github.io/Google search using: www.google.com, social media is facebook.com, http://example.com/method?param=flutterstackoverflow.com is my greatest website. DartPad share: https://github.com/dart-lang/dart-pad/wiki/Sharing-Guide, see this example and edit it here";

void main() {
  group('Regular Expression', () {
    test("Should match all emails", () {
      List<String> _emails = ["hello@world.com", "foo.bar@js.com"];
      _emails.forEach((e) {
        bool hasMatch = emailRegex.hasMatch(e);
        expect(hasMatch, true);
      });
    });
    test("Should match all urls", () {
      List<String> _urls = [
        "http://domain.com",
        "http://domain.com/",
        "https://domain.com",
        "https://domain.com/",
        "https://www.domain.com",
        "www.domain.com",
        "https://domain.com/Google?",
        "https://domain.com/Google/search",
        "https://domain.com/Google?param=",
        "https://domain.com/Google?param=helloworld",
        "https://sub.domain.com/Google?param=helloworld#hash",
      ];
      _urls.forEach((u) {
        bool hasMatch = emailRegex.hasMatch(u);
        expect(hasMatch, true);
      });
    });
    test("Should match all hashtags", () {
      List<String> _hashtags = [
        "#1",
        "#trending",
        "#_trending",
        "#TRENDING",
        "#trending_topic",
      ];
      _hashtags.forEach((h) {
        bool hasMatch = emailRegex.hasMatch(h);
        expect(hasMatch, true);
      });
    });
  });
}
