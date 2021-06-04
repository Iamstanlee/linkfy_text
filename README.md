A lightweight flutter package to linkify texts containing urls, emails and hashtags.

<!-- [![pub package](https://img.shields.io/pub/v/http.svg)](https://pub.dev/packages/linkfy_text) -->

## Using

```dart
// first import the package
import 'package:linkfy_text/linkify_text.dart';
LinkifyText(
    "This text contains a url: https://flutter.dev",
    linkStyle: TextStyle(color: Colors.blue, fontSize: 16),
    onTap: (link) {
        // onTap is called when a link is pressed
        print("${link.value}");
    },
);
```

Be default, The above snippet would linkify all urls in the string, you can choose whatxw type of link to linkify by passing the `linkTypes` parameter

```dart
LinkifyText(
        "This text contains an #hashtag",
        linkStyle: TextStyle(color: Colors.blue, fontSize: 16),
        linkTypes: [LinkType.hashtag]
        onTap: (link) {
            print("${link.value}");
        },
    );
```
