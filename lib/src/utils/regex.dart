import 'package:linkfy_text/src/enum.dart';

String urlRegExp = r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+';

String hashtagRegExp = r'(#+[a-zA-Z0-9(_)]{1,})';

String userTagRegExp = r'(?<![\w@])@([\w@]+(?:[.!][\w@]+)*)';

String emailRegExp =
    r"([a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+)";

String bookRegExp = r'(《(.*?)》)';


/// construct regexp. pattern from provided link types
RegExp constructRegExpFromLinkType(List<LinkType> types) {
  // default case where we always want to match url strings
  final len = types.length;
  if (len == 1 && types.first == LinkType.url) {
    return RegExp(urlRegExp);
  }
  final buffer = StringBuffer();
  for (var i = 0; i < len; i++) {
    final type = types[i];
    final isLast = i == len - 1;
    switch (type) {
      case LinkType.url:
        isLast ? buffer.write("($urlRegExp)") : buffer.write("($urlRegExp)|");
        break;
      case LinkType.hashTag:
        isLast
            ? buffer.write("($hashtagRegExp)")
            : buffer.write("($hashtagRegExp)|");
        break;
      case LinkType.userTag:
        isLast
            ? buffer.write("($userTagRegExp)")
            : buffer.write("($userTagRegExp)|");
        break;
      case LinkType.email:
        isLast
            ? buffer.write("($emailRegExp)")
            : buffer.write("($emailRegExp)|");
        break;
      case LinkType.bookTag:
        isLast
            ? buffer.write("($bookRegExp)")
            : buffer.write("($bookRegExp)|");
        break;
      default:
    }
  }
  return RegExp(buffer.toString());
}

LinkType getMatchedType(RegExpMatch match) {
  late LinkType type;
  if (RegExp(urlRegExp).hasMatch(match.input)) {
    type = LinkType.url;
  } else if (RegExp(hashtagRegExp).hasMatch(match.input)) {
    type = LinkType.hashTag;
  } else if (RegExp(emailRegExp).hasMatch(match.input)) {
    type = LinkType.email;
  } else if (RegExp(userTagRegExp).hasMatch(match.input)) {
    type = LinkType.userTag;
  } else if (RegExp(bookRegExp).hasMatch(match.input)) {
    type = LinkType.bookTag;
  }
  return type;
}
