import 'package:linkify_text/src/enum.dart';
import 'package:linkify_text/src/utils/regex.dart';

class Link {
  String? _value;
  LinkType? _type;
  String? get value => _value;
  LinkType? get type => _type;

  ///   construct link from matched regExp
  Link.fromMatch(RegExpMatch match)
      : this._type = getMatchedType(match),
        this._value = match.input.substring(match.start, match.end);
}
