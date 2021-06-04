import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:linkfy_text/src/enum.dart';
import 'package:linkfy_text/src/model/link.dart';
import 'package:linkfy_text/src/utils/regex.dart';

/// Linkify [text] containing urls, emails or hashtag
class LinkifyText extends StatelessWidget {
  const LinkifyText(this.text,
      {this.textStyle,
      this.linkStyle,
      this.linkTypes,
      this.onTap,
      this.strutStyle,
      this.textAlign,
      this.textDirection,
      this.locale,
      this.softWrap,
      this.overflow,
      this.textScaleFactor,
      this.maxLines,
      this.semanticsLabel,
      this.textWidthBasis,
      Key? key})
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

  /// {@macro flutter.painting.textPainter.strutStyle}
  final StrutStyle? strutStyle;

  /// How the text should be aligned horizontally.
  final TextAlign? textAlign;

  /// The directionality of the text.
  ///
  /// This decides how [textAlign] values like [TextAlign.start] and
  /// [TextAlign.end] are interpreted.
  ///
  /// This is also used to disambiguate how to render bidirectional text. For
  /// example, if the [data] is an English phrase followed by a Hebrew phrase,
  /// in a [TextDirection.ltr] context the English phrase will be on the left
  /// and the Hebrew phrase to its right, while in a [TextDirection.rtl]
  /// context, the English phrase will be on the right and the Hebrew phrase on
  /// its left.
  ///
  /// Defaults to the ambient [Directionality], if any.
  final TextDirection? textDirection;

  /// Used to select a font when the same Unicode character can
  /// be rendered differently, depending on the locale.
  ///
  /// It's rarely necessary to set this property. By default its value
  /// is inherited from the enclosing app with `Localizations.localeOf(context)`.
  ///
  /// See [RenderParagraph.locale] for more information.
  final Locale? locale;

  /// Whether the text should break at soft line breaks.
  ///
  /// If false, the glyphs in the text will be positioned as if there was unlimited horizontal space.
  final bool? softWrap;

  /// How visual overflow should be handled.
  ///
  /// Defaults to retrieving the value from the nearest [DefaultTextStyle] ancestor.
  final TextOverflow? overflow;

  /// The number of font pixels for each logical pixel.
  ///
  /// For example, if the text scale factor is 1.5, text will be 50% larger than
  /// the specified font size.
  ///
  /// The value given to the constructor as textScaleFactor. If null, will
  /// use the [MediaQueryData.textScaleFactor] obtained from the ambient
  /// [MediaQuery], or 1.0 if there is no [MediaQuery] in scope.
  final double? textScaleFactor;

  /// An optional maximum number of lines for the text to span, wrapping if necessary.
  /// If the text exceeds the given number of lines, it will be truncated according
  /// to [overflow].
  ///
  /// If this is 1, text will not wrap. Otherwise, text will be wrapped at the
  /// edge of the box.
  ///
  /// If this is null, but there is an ambient [DefaultTextStyle] that specifies
  /// an explicit number for its [DefaultTextStyle.maxLines], then the
  /// [DefaultTextStyle] value will take precedence. You can use a [RichText]
  /// widget directly to entirely override the [DefaultTextStyle].
  final int? maxLines;

  /// An alternative semantics label for this text.
  ///
  /// If present, the semantics of this widget will contain this value instead
  /// of the actual text. This will overwrite any of the semantics labels applied
  /// directly to the [TextSpan]s.
  ///
  /// This is useful for replacing abbreviations or shorthands with the full
  /// text value:
  ///
  /// ```dart
  /// Text(r'$$', semanticsLabel: 'Double dollars')
  /// ```
  final String? semanticsLabel;

  /// {@macro flutter.painting.textPainter.textWidthBasis}
  final TextWidthBasis? textWidthBasis;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      _linkify(
        text: text,
        linkStyle: linkStyle,
        onTap: onTap,
        linkTypes: linkTypes,
      ),
      key: key,
      style: textStyle,
      strutStyle: strutStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      textScaleFactor: textScaleFactor,
      textWidthBasis: textWidthBasis,
      semanticsLabel: semanticsLabel,
      softWrap: softWrap,
      overflow: overflow,
      maxLines: maxLines,
      locale: locale,
    );
  }
}

TextSpan _linkify({
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
