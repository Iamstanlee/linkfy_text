# linkfy_text

A lightweight flutter package to linkify texts containing urls, emails and hashtags.

![issues](https://img.shields.io/github/issues/Iamstanlee/linkfy_text)]
[![pub package](https://img.shields.io/pub/v/http.svg)](https://pub.dev/packages/linkfy_text)

![final](https://user-images.githubusercontent.com/43510799/104180838-2385fd80-5451-11eb-8506-1640b4ea829f.gif)

## Usage

```dart
// first import the package
import 'package:linkfy_text/linkify_text.dart';

LinkifyText(
    "This text contains a url: https://flutter.dev",
    linkStyle: TextStyle(color: Colors.blue, fontSize: 16),
    onTap: (link) {
        /// do stuff with `link`
    },
);
```

Be default, The above snippet would linkify all urls in the string, you can choose whatxw type of link to linkify by passing the `linkTypes` parameter

```dart
LinkifyText(
        "This text contains an #hashtag and a url",
        linkStyle: TextStyle(color: Colors.blue, fontSize: 16),
        linkTypes: [LinkType.url, LinkType.hashtag]
        onTap: (link) {
            /// do stuff with `link`
        },
    );
```


