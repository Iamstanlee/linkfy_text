# linkfy_text

Lightweight flutter package that detects linkable patterns(urls, emails, hashtags, etc) in a text and makes them clickable. It also allows you to customize the style of the linkified text and the link itself. It also allows you to choose what type of link to linkify in a text.¬ 

[![pub package](https://img.shields.io/pub/v/linkfy_text.svg)](https://pub.dev/packages/linkfy_text)
[![CI](https://github.com/Iamstanlee/linkfy_text/actions/workflows/main.yml/badge.svg)](https://github.com/Iamstanlee/linkfy_text/actions/workflows/main.yml)
[![coverage Status](https://coveralls.io/repos/github/Iamstanlee/linkfy_text/badge.svg?branch=main)](https://coveralls.io/github/Iamstanlee/linkfy_text?branch=main)

<p>
    <img src="https://raw.githubusercontent.com/Iamstanlee/linkfy_text/main/screenshots/s1.png" width="200px" height="auto" hspace="20"/>
    <img src="https://raw.githubusercontent.com/Iamstanlee/linkfy_text/main/screenshots/s2.png" width="200px" height="auto" hspace="20"/>
</p>

## Usage

To use this package, add `linkfy_text` as a [dependency in your pubspec.yaml file](https://pub.dev/packages/linkfy_text/).

Example:

```dart
// first import the package
import 'package:linkfy_text/linkify_text.dart';

Container(
    child: LinkifyText(
    "This text contains a url: https://flutter.dev",
    linkStyle: TextStyle(color: Colors.blue),
    onTap: (link) {
        /// do stuff with `link`
        },
    );
)
```

Be default, The above snippet would linkify all urls in the string, you can choose what type of link to linkify by passing the `LinkTypes` parameter

```dart
Container(
    child: LinkifyText(
    "This text contains a url: https://flutter.dev and #flutter",
    linkStyle: TextStyle(color: Colors.blue),
    LinkTypes: [LinkType.url, LinkType.hashtag]
    onTap: (link) {
        /// do stuff with `link` like
        /// if(link.type == Link.url) launchUrl(link.value);
        },
    );
)
```

## API Reference

#### LinkfyText

| Parameter   | Type             | Description                                                                                                                                 |
| :---------- | :--------------- | :------------------------------------------------------------------------------------------------------------------------------------------ |
| `textStyle` | `TextStyle`      | style applied to the text                                                                                                                   |
| `linkStyle` | `TextStyle`      | style applied to the linkified text. **defaults** to `textStyle`                                                                            |
| `LinkTypes` | `List<LinkType>` | a list of `LinkType` used to override the links to be linkified in a text either a url, hashtag or email. **defaults** to `[LinkTypes.url]` |
| `onTap`     | `Function(Link)` | function called when a link is pressed                                                                                                      |

#### LinkType

| Parameter | Type     | Description                                          |
| :-------- | :------- | :--------------------------------------------------- |
| `type`    | `Link`   | the link type either url, email or hashtag, @mention |
| `value`   | `String` | value the link holds                                 |

# Contributions

Feel free to contribute to this project.

If you find a bug or want a feature, but don't know how to fix/implement it, please fill an [issue](https://github.com/Iamstanlee/linkfy_text/issues).  
If you fixed a bug or implemented a feature, please send a [pull request](https://github.com/Iamstanlee/linkfy_text/pulls).

# TODO

- LinkifyTextField widget
