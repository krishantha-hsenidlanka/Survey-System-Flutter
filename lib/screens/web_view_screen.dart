import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WebViewScreen extends StatefulWidget {
  final String url;

  WebViewScreen({required this.url});

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late WebViewController _controller;
  bool _isLoadingPage = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'AI Survey',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color.fromARGB(255, 22, 0, 143),
                const Color.fromARGB(255, 21, 90, 237)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          WebView(
            initialUrl: widget.url,
            javascriptMode: JavascriptMode.unrestricted,
            onPageStarted: (url) {
              setState(() {
                _isLoadingPage = true;
              });
            },
            onPageFinished: (url) {
              setState(() {
                _isLoadingPage = false;
              });
            },
            onWebViewCreated: (WebViewController controller) {
              _controller = controller;
              setTokenInLocalStorage();
            },
          ),
          if (_isLoadingPage)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }

  void setTokenInLocalStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null) {
      await _controller.evaluateJavascript('localStorage.setItem("token", "$token");');
    }
  }
}

void navigateToWebView(BuildContext context, String url) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => WebViewScreen(url: url),
    ),
  );
}
