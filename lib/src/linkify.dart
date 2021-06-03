import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

enum LinkOptions { url, email, hashTag }

TextSpan formatText(
    {required String text, TextStyle? textStyle, TextStyle? linkStyle}) {
  RegExp re = RegExp(
      r"(((ht|f)tp(s?)://)|www.)[0-9a-zA-Z]([-.\w]*[0-9a-zA-Z])*(:(0-9)*)*/?([a-zA-Z0-9\-.\?,'/\\\+&amp;%\$#_=]*)?");

  //  return the full text if there's no match
  if (!re.hasMatch(text)) {
    return TextSpan(text: text, style: textStyle);
  }

  List<String> texts = text.split(re);
  List<TextSpan> spans = [];
  List<RegExpMatch> links = re.allMatches(text).toList();

  for (String text in texts) {
    spans.add(TextSpan(text: text, style: textStyle));
    if (links.length > 0) {
      RegExpMatch match = links.removeAt(0);
      String link = match.input.substring(match.start, match.end);

      // add the link
      spans.add(
        TextSpan(
          text: link,
          style: linkStyle,
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              String l = link.startsWith('www') ? 'http://$link' : link;
              if (l.endsWith('.') || l.endsWith(',') || l.endsWith(';')) {
                l = l.substring(0, l.length - 1);
              }
            },
        ),
      );
    }
  }

  return TextSpan(children: spans);
}
