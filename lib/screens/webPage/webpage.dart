import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gandalverse/screens/new_design_screens/helper/ui_helper.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';
import 'package:webview_flutter_web/webview_flutter_web.dart';

import '../../components/user_top_infos.dart';

//import 'package:webview_flutter/webview_flutter.dart';
class GandalVerseWebView extends StatefulWidget {
  PlatformWebViewController controller;
  GandalVerseWebView({super.key, required this.controller});

  @override
  _GandalVerseWebViewState createState() => _GandalVerseWebViewState();
}

class _GandalVerseWebViewState extends State<GandalVerseWebView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Offset _offset = Offset.zero;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image:
                    AssetImage("assets/images/GverseToken_OnboardingPage.png"),
                fit: BoxFit.cover),
          ),
        ),
        /*Align(
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
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox.square(
                  dimension: 30,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ),*/
        Positioned.fill(
          child: PlatformWebViewWidget(
            PlatformWebViewWidgetCreationParams(controller: widget.controller),
          ).build(context),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: PointerInterceptor(
            child: userTopInfos(),
          ),
        ),
      ]),
    );
  }
}

//import 'package:webview_flutter/webview_flutter.dart';
class VerseWebView extends StatefulWidget {
  VerseWebView({
    super.key,
  });

  @override
  _VerseWebViewState createState() => _VerseWebViewState();
}

class _VerseWebViewState extends State<VerseWebView> {
  late PlatformWebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    _webViewController = PlatformWebViewController(
      const PlatformWebViewControllerCreationParams(),
    )..loadRequest(
        LoadRequestParams(
          uri: Uri.parse('https://storage.net-fs.com/hosting/8150162/0/'),
        ),
      );

    //     PlatformWebViewControllerCreationParams params;
    // if (WebViewPlatform.instance is WebKitWebViewPlatform) {
    //   params = WebKitWebViewControllerCreationParams();
    // } else {
    //   params = const PlatformWebViewControllerCreationParams();
    // }

    // _webViewController = WebViewController.fromPlatformCreationParams(params);
    // if (controller.platform is WebKitWebViewController) {
    //   (controller.platform as WebKitWebViewController).setInspectable(true);
    // }
    // }
  } // old url :: https://gandalverse.com

  @override
  void dispose() {
    super.dispose();
  }

  Offset _offset = Offset.zero;
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenWidth,
      height: screenHeight,
      child: PlatformWebViewWidget(
        PlatformWebViewWidgetCreationParams(controller: _webViewController),
      ).build(context),
    );
  }
}
