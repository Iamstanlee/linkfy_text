# linkfy_text

A lightweight flutter package that linkifies a text containing urls, emails and hashtag like twitter does.

[![pub package](https://img.shields.io/pub/v/linkfy_text.svg)](https://pub.dev/packages/linkfy_text)

![gif](https://github.com/Iamstanlee/linkfy_text/blob/main/ezgif.com-gif-maker.gif)

## Usage

To use this package, add `linkfy_text` as a [dependency in your pubspec.yaml file](https://pub.dev/packages/linkfy_text/).

Example:

```dart
// first import the package
import 'package:linkfy_text/linkify_text.dart';

Container(
    child: LinkifyText(
    "This text contains a url: https://flutter.dev",
    linkStyle: TextStyle(color: Colors.blue, fontSize: 16),
    onTap: (link) {
        /// do stuff with `link`
        },
    );
)
```

Be default, The above snippet would linkify all urls in the string, you can choose what type of link to linkify by passing the `Links` parameter

```dart
Container(
    child: LinkifyText(
    "This text contains a url: https://flutter.dev and #flutter",
    linkStyle: TextStyle(color: Colors.blue, fontSize: 16),
    Links: [Link.url, Link.hashtag]
    onTap: (link) {
        /// do stuff with `link` like
        /// if(link.type == Link.url) launchUrl(link.value);
        },
    );
)
```

## API Reference

#### LinkfyText

| Parameter   | Type             | Description                                                                                                                        |
| :---------- | :--------------- | :--------------------------------------------------------------------------------------------------------------------------------- |
| `textStyle` | `TextStyle`      | style applied to the text                                                                                                          |
| `linkStyle` | `TextStyle`      | style applied to the linkified text. **defaults** to `textStyle`                                                                   |
| `Links`     | `List<Link>`     | a list of `Link` used to override the links to be linkified in a text either a url, hashtag or email. **defaults** to `[Link.url]` |
| `onTap`     | `Function(Link)` | function called when a link is pressed                                                                                             |

#### Link

| Parameter | Type     | Description                                |
| :-------- | :------- | :----------------------------------------- |
| `type`    | `Link`   | the link type either url, email or hashtag |
| `value`   | `String` | value this link holds                      |

# Contributions

Feel free to contribute to this project.

If you find a bug or want a feature, but don't know how to fix/implement it, please fill an [issue](https://github.com/Iamstanlee/linkfy_text/issues).  
If you fixed a bug or implemented a feature, please send a [pull request](https://github.com/Iamstanlee/linkfy_text/pulls).

# TODO

- LinkifyTextField widget
