import 'package:flutter/material.dart';
import 'package:linkify_text/linkify_text.dart';

var scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'linkify_text Demo',
      scaffoldMessengerKey: scaffoldMessengerKey,
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
  void showSnackbar(String msg) {
    scaffoldMessengerKey.currentState!.removeCurrentSnackBar();
    scaffoldMessengerKey.currentState!
        .showSnackBar(SnackBar(content: Text("$msg")));
  }

  final space = SizedBox(height: 8);

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
                child: LinkifyText(
              "01. This text contains a url: https://flutter.dev",
              linkStyle: TextStyle(color: Colors.blue, fontSize: 16),
              onTap: (link) {
                showSnackbar(link.value!);
              },
            )),
            space,
            Center(
                child: LinkifyText(
              "02. This text contains an email hello@flutter.dev",
              linkTypes: [LinkType.email],
              linkStyle: TextStyle(color: Colors.blue, fontSize: 16),
              onTap: (link) {
                showSnackbar(link.value!);
              },
            )),
            space,
            Center(
                child: LinkifyText(
              "03. This contains an #hashtag",
              linkTypes: [LinkType.hashTag],
              linkStyle: TextStyle(color: Colors.blue, fontSize: 16),
              onTap: (link) {
                showSnackbar(link.value!);
              },
            )),
            space,
            Center(
                child: LinkifyText(
              "04. Flutter is #trending, goto https://flutter.dev to check it out. hey@pub.dev",
              linkTypes: [LinkType.hashTag, LinkType.url, LinkType.email],
              linkStyle: TextStyle(color: Colors.blue, fontSize: 16),
              onTap: (link) {
                showSnackbar(link.value!);
              },
            )),
          ],
        ),
      ),
    );
  }
}
