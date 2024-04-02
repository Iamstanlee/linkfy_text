import 'package:linkfy_text/src/enum.dart';
import 'package:linkfy_text/src/utils/regex.dart';

class Link {
  late final String? _value;
  late final LinkType? _type;
  String? get value => _value;
  LinkType? get type => _type;

  /// construct link from matched regExp
  Link.fromMatch(RegExpMatch match) {
    final String _match = match.input.substring(match.start, match.end);
    _type = getMatchedType(_match);
    _value = _match;
  }
}
