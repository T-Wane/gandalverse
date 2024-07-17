import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GandalVerseWebView extends StatefulWidget {
  WebViewController controller;
  GandalVerseWebView({super.key, required this.controller});

  @override
  _GandalVerseWebViewState createState() => _GandalVerseWebViewState();
}

class _GandalVerseWebViewState extends State<GandalVerseWebView> {
  @override
  Widget build(BuildContext context) {
    return WebViewStack(controller: widget.controller);
  }
}

class WebViewStack extends StatefulWidget {
  const WebViewStack({required this.controller, super.key});

  final WebViewController controller;

  @override
  State<WebViewStack> createState() => _WebViewStackState();
}

class _WebViewStackState extends State<WebViewStack> {
  var loadingPercentage = 0;

  @override
  void initState() {
    super.initState();
    widget.controller
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() {
              loadingPercentage = 0;
            });
          },
          onProgress: (progress) {
            setState(() {
              loadingPercentage = progress;
            });
          },
          onPageFinished: (url) {
            setState(() {
              loadingPercentage = 100;
            });
          },
          onNavigationRequest: (navigation) {
            final host = Uri.parse(navigation.url).host;
            if (host.contains('youtube.com')) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Blocking navigation to $host',
                  ),
                ),
              );
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        'SnackBar',
        onMessageReceived: (message) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(message.message)));
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    const Color3 = Color.fromARGB(255, 18, 40, 70);

    return Stack(children: [
      /* WebViewWidget(
          controller: widget.controller,
        ),
        if (loadingPercentage < 100) ...[*/
      Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/GverseToken_OnboardingPage.png"),
              fit: BoxFit.cover),
        ),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.7,
          width: double.infinity,
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Colors.transparent,
            Colors.transparent,
            Colors.transparent,
            Colors.black12,
            Colors.black26,
            Colors.black38,
            Colors.black45,
            Colors.black54,
            Colors.black87,
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Text(
                  "Gandal Verse".toUpperCase(),
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      fontFamily: 'Aller',
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Text(
                  "Votre portail virtuel vers un nouveau monde",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w200),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Text(
                  "#Korix Africa #MetaVerse",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontFamily: 'Aller',
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.w300),
                ),
              ),
              const SizedBox.square(
                dimension: 30,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
      Container(
        margin: const EdgeInsets.only(top: 1, left: 1, right: 1),
        child: LinearProgressIndicator(
          color: Colors.blue.shade400,
          value: loadingPercentage / 100.0,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ]
        // ],
        );
  }
}
