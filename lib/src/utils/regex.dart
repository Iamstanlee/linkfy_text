import 'package:linkify_text/linkify_text.dart';

String urlRegExp = r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+';

String hashtagRegExp = r'(#+[a-zA-Z0-9(_)]{1,})';

String emailRegExp =
    r"([a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+)";

/// construct regexp. pattern from provided link options
RegExp constructRegExpFromOptions(List<LinkOption> options) {
  // default case where we always want to match url strings
  if (options.length == 1 && options.first == LinkOption.url)
    return RegExp(urlRegExp);

  StringBuffer _regexBuffer = StringBuffer();
  for (var i = 0; i < options.length; i++) {
    final o = options[i];
    final isLast = i == options.length - 1;
    switch (o) {
      case LinkOption.url:
        isLast
            ? _regexBuffer.write("($urlRegExp)")
            : _regexBuffer.write("($urlRegExp)|");
        break;
      case LinkOption.hashTag:
        isLast
            ? _regexBuffer.write("($hashtagRegExp)")
            : _regexBuffer.write("($hashtagRegExp)|");
        break;
      case LinkOption.email:
        isLast
            ? _regexBuffer.write("($emailRegExp)")
            : _regexBuffer.write("($emailRegExp)|");
        break;
      default:
    }
  }
  return RegExp(_regexBuffer.toString());
}
