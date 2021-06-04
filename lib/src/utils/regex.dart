import 'package:linkfy_text/src/enum.dart';

String urlRegExp = r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+';

String hashtagRegExp = r'(#+[a-zA-Z0-9(_)]{1,})';

String emailRegExp =
    r"([a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+)";

/// construct regexp. pattern from provided link linkTypes
RegExp constructRegExpFromLinkType(List<LinkType> linkTypes) {
  // default case where we always want to match url strings
  if (linkTypes.length == 1 && linkTypes.first == LinkType.url)
    return RegExp(urlRegExp);

  StringBuffer _regexBuffer = StringBuffer();
  for (var i = 0; i < linkTypes.length; i++) {
    final _type = linkTypes[i];
    final _isLast = i == linkTypes.length - 1;
    switch (_type) {
      case LinkType.url:
        _isLast
            ? _regexBuffer.write("($urlRegExp)")
            : _regexBuffer.write("($urlRegExp)|");
        break;
      case LinkType.hashTag:
        _isLast
            ? _regexBuffer.write("($hashtagRegExp)")
            : _regexBuffer.write("($hashtagRegExp)|");
        break;
      case LinkType.email:
        _isLast
            ? _regexBuffer.write("($emailRegExp)")
            : _regexBuffer.write("($emailRegExp)|");
        break;
      default:
    }
  }
  return RegExp(_regexBuffer.toString());
}

LinkType getMatchedType(RegExpMatch match) {
  late LinkType _type;
  if (RegExp(urlRegExp).hasMatch(match.input)) {
    _type = LinkType.url;
  } else if (RegExp(hashtagRegExp).hasMatch(match.input)) {
    _type = LinkType.hashTag;
  } else if (RegExp(hashtagRegExp).hasMatch(match.input)) {
    _type = LinkType.email;
  }
  return _type;
}
