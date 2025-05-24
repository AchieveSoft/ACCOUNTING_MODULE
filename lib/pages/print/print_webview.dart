import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class PrintWebview extends StatelessWidget {
  const PrintWebview({super.key});

  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      initialUrlRequest: URLRequest(
        url: WebUri.uri(Uri.parse('http://localhost:4200/')),
      ),
      initialSettings: InAppWebViewSettings(),
      onWebViewCreated: (controller) {
        controller.evaluateJavascript(source: 'alert("test")');
      },
      onLoadStop: (controller, url) {
        controller.evaluateJavascript(source: 'alert("test")');
      },
    );
  }
}
