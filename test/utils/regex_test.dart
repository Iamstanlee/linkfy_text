import 'package:linkfy_text/src/enum.dart';
import 'package:linkfy_text/src/utils/regex.dart';
import 'package:test/test.dart';

void main() {
  group('Regular Expression', () {
    // test values
    const urlText =
        "My website url: https://hello.com/GOOGLE search using: www.google.com, social media is facebook.com, http://example.com/method?param=fullstackoverflow.dev";
    const hashtagText = "#helloWorld and #dev are trending";
    const emailText =
        "My email address is hey@stanleee.me and dev@gmail.com, yah!";
    const text = urlText + hashtagText + emailText;

    const emails = ["hello@world.com", "foo.bar@js.com"];

    const urls = [
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

    const hashtags = [
      "#123",
      "#H",
      "#0",
      "#trending",
      "#_trending",
      "#TRENDING",
      "#trending_topic",
    ];

    const userTags = [
      '@helloWorld',
      '@helloWorld123',
      '@hello_world',
      '@hello_world123',
      '@hello_world_123'
    ];

    ///
    test("Should match all emails", () {
      for (final email in emails) {
        expect(RegExp(emailRegExp).hasMatch(email), isTrue);
      }
    });

    test("Should match all urls", () {
      for (final url in urls) {
        expect(RegExp(urlRegExp).hasMatch(url), isTrue);
      }
    });

    test("Should match all hashtags", () {
      for (final tag in hashtags) {
        expect(RegExp(hashtagRegExp).hasMatch(tag), isTrue);
      }
    });
    test("Should match all usertags", () {
      for (final tag in userTags) {
        expect(RegExp(userTagRegExp).hasMatch(tag), isTrue);
      }
    });

    test(
        "Should construct regex pattern from LinkTypes and match required output",
        () {
      final urlRegExp = constructRegExpFromLinkType([LinkType.url]);
      final hashtagRegExp = constructRegExpFromLinkType([LinkType.hashTag]);
      final emailRegExp = constructRegExpFromLinkType([LinkType.email]);
      final textRegExp = constructRegExpFromLinkType(
          [LinkType.url, LinkType.hashTag, LinkType.email]);

      expect(urlRegExp.allMatches(urlText).length, 4);
      expect(hashtagRegExp.allMatches(hashtagText).length, 2);
      expect(emailRegExp.allMatches(emailText).length, 2);
      expect(textRegExp.allMatches(text).length, 8);
    });
  });
}
