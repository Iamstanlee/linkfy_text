import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:linkify_text/src/enum.dart';
import 'package:linkify_text/src/model/link.dart';
import 'package:linkify_text/src/utils/regex.dart';

/// Linkify [text] containing urls, emails or hashtag
class LinkifyText extends StatelessWidget {
  const LinkifyText(this.text,
      {this.textStyle, this.linkStyle, this.linkTypes, this.onTap, Key? key})
      : super(key: key);

  /// text to be linkified
  final String text;

  /// [textStyle] applied the text
  final TextStyle? textStyle;

  /// [textStyle] added to the formatted links in the text
  final TextStyle? linkStyle;

  /// called when a formatted link is pressed, it returns the link as a parameter
  /// ```dart
  ///   LinkifyText("#helloWorld", onTap: (link) {
  ///       // do stuff with link
  ///       print("${link.value} hashtag was tapped");
  ///   });
  /// ```
  final void Function(Link)? onTap;

  /// option to override the links to be formatted in the text, defaults to `[LinkType.url]`
  /// so only urls are being linkified in the text
  final List<LinkType>? linkTypes;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      linkify(
        text: text,
        linkStyle: linkStyle,
        onTap: onTap,
        linkTypes: linkTypes,
      ),
      key: key,
      style: textStyle,
    );
  }
}

TextSpan linkify({
  String text = '',
  TextStyle? linkStyle,
  List<LinkType>? linkTypes,
  Function(Link)? onTap,
}) {
  RegExp _regExp = constructRegExpFromLinkType(linkTypes ?? [LinkType.url]);

  //  return the full text if there's no match or if empty
  if (!_regExp.hasMatch(text) || text.isEmpty) return TextSpan(text: text);

  List<String> texts = text.split(_regExp);
  List<TextSpan> spans = [];
  List<RegExpMatch> links = _regExp.allMatches(text).toList();

  for (String text in texts) {
    spans.add(TextSpan(
      text: text,
    ));
    if (links.length > 0) {
      RegExpMatch match = links.removeAt(0);
      Link link = Link.fromMatch(match);
      // add the link
      spans.add(
        TextSpan(
          text: link.value,
          style: linkStyle,
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              onTap!(link);
            },
        ),
      );
    }
  }
  return TextSpan(children: spans);
}
