import 'package:linkfy_text/src/enum.dart';
import 'package:linkfy_text/src/utils/regex.dart';

class Link {
  final String? _value;
  final LinkType? _type;
  String? get value => _value;
  LinkType? get type => _type;

  /// construct link from matched regExp
  Link.fromMatch(RegExpMatch match)
      : _type = getMatchedType(match),
        _value = match.input.substring(match.start, match.end);
}
