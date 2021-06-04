import 'package:linkfy_text/src/enum.dart';
import 'package:linkfy_text/src/utils/regex.dart';
import 'package:test/test.dart';

void main() {
  group('Regular Expression', () {
    /// test values
    final _urlText =
        "My website url: https://hello.com/GOOGLE search using: www.google.com, social media is facebook.com, http://example.com/method?param=fullstackoverflow.dev";
    final _hashtagText = "#helloWorld and #dev are trending";
    final _emailText =
        "My email address is hey@stanleee.me and dev@gmail.com, yah!";
    final _text = _urlText + _hashtagText + _emailText;

    final _emails = ["hello@world.com", "foo.bar@js.com"];

    final List<String> _urls = [
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

    final List<String> _hashtags = [
      "#123",
      "#H",
      "#0",
      "#trending",
      "#_trending",
      "#TRENDING",
      "#trending_topic",
    ];

    ///
    test("Should match all emails", () {
      _emails.forEach((e) {
        bool hasMatch = RegExp(emailRegExp).hasMatch(e);
        expect(hasMatch, true);
      });
    });

    test("Should not match all emails", () {
      List<String> _emails = ["hello@world", "@js.com"];
      _emails.forEach((e) {
        bool hasMatch = RegExp(emailRegExp).hasMatch(e);
        expect(hasMatch, false);
      });
    });

    test("Should match all urls", () {
      _urls.forEach((u) {
        bool hasMatch = RegExp(urlRegExp).hasMatch(u);
        expect(hasMatch, true);
      });
    });

    test("Should match all hashtags", () {
      _hashtags.forEach((h) {
        bool hasMatch = RegExp(hashtagRegExp).hasMatch(h);
        expect(hasMatch, true);
      });
    });

    test("Should construct regex pattern from LinkTypes and match", () {
      RegExp _urlRegExp = constructRegExpFromLinkType([LinkType.url]);
      RegExp _hashtagRegExp = constructRegExpFromLinkType([LinkType.hashTag]);
      RegExp _emailRegExp = constructRegExpFromLinkType([LinkType.email]);
      RegExp _textRegExp = constructRegExpFromLinkType(
          [LinkType.url, LinkType.hashTag, LinkType.email]);
      expect(_urlRegExp.allMatches(_urlText).length, 4);
      expect(_hashtagRegExp.allMatches(_hashtagText).length, 2);
      expect(_emailRegExp.allMatches(_emailText).length, 2);
      expect(_textRegExp.allMatches(_text).length, 8);
    });
  });
}
