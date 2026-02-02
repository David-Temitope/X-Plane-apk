import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WebPage(),
    );
  }
}

class WebPage extends StatefulWidget {
  const WebPage({super.key});

  @override
  State<WebPage> createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  bool isLoading = true;
  String? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          WebView(
            initialUrl: 'https://x-plane.lovable.app',
            javascriptMode: JavascriptMode.unrestricted,
            onPageStarted: (_) {
              setState(() {
                isLoading = true;
                error = null;
              });
            },
            onPageFinished: (_) {
              setState(() {
                isLoading = false;
              });
            },
            onWebResourceError: (err) {
              setState(() {
                isLoading = false;
                error = err.description;
              });
            },
          ),
          if (isLoading)
            const Center(child: CircularProgressIndicator()),
          if (error != null)
            Center(
              child: Text(
                'WebView error:\n$error',
                textAlign: TextAlign.center,
              ),
            ),
        ],
      ),
    );
  }
}
