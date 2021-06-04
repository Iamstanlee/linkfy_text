import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linkfy_text/linkfy_text.dart';

void main() {
  runApp(MyApp());
}

var _msgKey = GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'linkify_text Demo',
      scaffoldMessengerKey: _msgKey,
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
  final _textStyle =
      GoogleFonts.jetBrainsMono(fontSize: 14, fontWeight: FontWeight.w500);

  final List<Map<String, dynamic?>> _texts = [
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
      "text":
          "O4. This text contains a url: https://flutter.dev, An email example@app.com and #hashtag",
      "types": [LinkType.email, LinkType.url, LinkType.hashTag]
    },
  ];

  void showSnackbar(String msg) {
    _msgKey.currentState!.removeCurrentSnackBar();
    _msgKey.currentState!.showSnackBar(SnackBar(
      content: Text("$msg", style: _textStyle),
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
                "LinkifyText",
                style: _textStyle.copyWith(
                  fontSize: 24,
                ),
              ),
            ),
            for (var i = 0; i < _texts.length; i++)
              Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: LinkifyText(
                    _texts[i]['text'],
                    textAlign: TextAlign.center,
                    linkTypes: _texts[i]['types'],
                    textStyle: _textStyle,
                    linkStyle: _textStyle.copyWith(color: Colors.blue),
                    onTap: (link) {
                      showSnackbar("link tapped: ${link.value!}");
                    },
                  )),
          ],
        ),
      ),
    );
  }
}
