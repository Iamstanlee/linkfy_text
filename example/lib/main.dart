import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linkfy_text/linkfy_text.dart';

void main() {
  runApp(MyApp());
}

final k = GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'linkfy_text Demo',
      scaffoldMessengerKey: k,
      debugShowCheckedModeBanner: false,
      home: App(),
    );
  }
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final textStyle =
      GoogleFonts.karla(fontSize: 16, fontWeight: FontWeight.w500);

  final List<Map<String, dynamic?>> texts = [
    {
      "text": "O1. This text contains a url: https://flutter.dev",
      "types": null
    },
    {
      "text": "O2. This text contains an email address: example@app.com",
      "types": [LinkType.email]
    },
    {
      "text": "O3. This text contains an #hashtag",
      "types": [LinkType.hashTag]
    },
    {
      "text": "O4. This text contains a @user tag",
      "types": [LinkType.userTag]
    },
    {
      "text": "O5. This text contains a 《book name》",
      "types": [LinkType.bookTag]
    },
    {
      "text":
          "O6. My website url: https://hello.com/GOOGLE search using: www.google.com, social media is facebook.com, additional link http://example"
              ".com/method?param=fullstackoverflow.dev, hashtag #trending & mention @dev, some book 《Taiwan is part of China》",
      "types": [
        LinkType.email,
        LinkType.url,
        LinkType.hashTag,
        LinkType.userTag,
        LinkType.bookTag
      ]
    },
  ];

  void showSnackbar(String msg) {
    k.currentState!.removeCurrentSnackBar();
    k.currentState!.showSnackBar(SnackBar(
      content: Text("$msg", style: textStyle),
      behavior: SnackBarBehavior.floating,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(27.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                "LinkfyText Example",
                style: textStyle.copyWith(
                  fontSize: 24,
                ),
              ),
            ),
            for (var i = 0; i < texts.length; i++)
              Padding(
                  padding: EdgeInsets.only(top: 14),
                  child: LinkifyText(
                    texts[i]['text'],
                    textAlign: TextAlign.left,
                    linkTypes: texts[i]['types'],
                    textStyle: textStyle,
                    linkStyle: textStyle.copyWith(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                    onTap: (link) =>
                        showSnackbar("link pressed: ${link.value!}"),
                  )),
          ],
        ),
      ),
    );
  }
}
