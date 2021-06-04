import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:linkify_text/src/utils/regex.dart';

enum LinkOption { url, email, hashTag }

/// Linkify [text] containing urls, emails or hashtag
class LinkifyText extends StatelessWidget {
  const LinkifyText(this.text,
      {this.textStyle, this.linkStyle, this.options, this.onTap, Key? key})
      : super(key: key);

  /// text to be linkified
  final String text;

  /// [textStyle] applied the text
  final TextStyle? textStyle;

  /// [textStyle] added to the formatted links in the text
  final TextStyle? linkStyle;

  /// called when a formatted link is pressed, it returns the link as a parameter
  /// ```dart
  ///   LinkifyText("#helloWorld", onTap: (value) {
  ///       // do stuff with value
  ///       print("$value hashtag was tapped");
  ///   });
  /// ```
  final void Function(String)? onTap;

  /// option to override the links to be formatted in the text, defaults to `[LinkOption.url]`
  /// so only urls are being linkified in the text
  final List<LinkOption>? options;

  @override
  Widget build(BuildContext context) {
    //   TODO: add all Text properties
    return Text.rich(
      linkify(
        text: text,
        linkStyle: linkStyle,
        onTap: onTap,
        options: options,
      ),
      key: key,
      style: linkStyle,
    );
  }
}

TextSpan linkify({
  String text = '',
  TextStyle? linkStyle,
  List<LinkOption>? options = const [LinkOption.url],
  Function(String)? onTap,
}) {
  RegExp _regExp = constructRegExpFromOptions(options!);

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
      String link = match.input.substring(match.start, match.end);

      // add the link
      spans.add(
        TextSpan(
          text: link,
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
