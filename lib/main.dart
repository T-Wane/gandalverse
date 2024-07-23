// ignore_for_file: avoid_print

import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:gandalverse/init.dart';
import 'package:telegram_web_app/telegram_web_app.dart';
import 'package:webview_flutter_web/webview_flutter_web.dart';
//import 'package:telegram_web_app/telegram_web_app.dart';
import 'animations/coinsAnimations_test2.dart';
import 'animations/coinsAnomations_test1.dart';
import 'screens/home.page.dart';

import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';
import 'package:url_launcher/url_launcher.dart';

// import 'package:flutter_telegram_web_app/flutter_telegram_web_app.dart' as tg;
// import 'package:flutter_telegram_web_app/flutter_telegram_web_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WebViewPlatform.instance = WebWebViewPlatform();
  try {
    if (TelegramWebApp.instance.isSupported) {
      await TelegramWebApp.instance.ready();
      Future.delayed(
          const Duration(seconds: 1), TelegramWebApp.instance.expand);
    }
  } catch (e) {
    print("Error happened in Flutter while loading Telegram $e");
    // add delay for 'Telegram not loading sometimes' bug
    await Future.delayed(const Duration(milliseconds: 200));
    main();
    return;
  }

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark),
  );

  /* try {
      if (TelegramWebApp.instance.isSupported) {
        await TelegramWebApp.instance.ready();
        Future.delayed(const Duration(seconds: 1), TelegramWebApp.instance.expand);
      }
    } catch (e) {
      print("Error happened in Flutter while loading Telegram $e");
      // add delay for 'Telegram seldom not loading' bug
      await Future.delayed(const Duration(milliseconds: 200));
      main();
      return;
    }

    FlutterError.onError = (details) {
      print("Flutter error happened: $details");
    };
*/

  runApp(const MyApp()); //InitializationPage
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'GandalVerse',
        debugShowCheckedModeBanner: false,
        theme: TelegramThemeUtil.getTheme(TelegramWebApp.instance),

        /*theme: ThemeData( 
              primaryColor: Colors.white, 
              visualDensity: VisualDensity.adaptivePlatformDensity,
              fontFamily: 'Aller',
              textTheme: Theme.of(context).textTheme,
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)
                  .copyWith(background: const Color(0xffe7e9f0)),
            ),*/
        home: MyHomePage() // CoinAnimation()//FlyCoinAnimation()//MyHomePage(),
        );
  }
}
/*

class InAppWebViewExampleScreen extends StatefulWidget {
  @override
  _InAppWebViewExampleScreenState createState() =>
      _InAppWebViewExampleScreenState();
}

class _InAppWebViewExampleScreenState extends State<InAppWebViewExampleScreen> {
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;
  InAppWebViewSettings settings = InAppWebViewSettings(
      isInspectable: kDebugMode,
      mediaPlaybackRequiresUserGesture: false,
      allowsInlineMediaPlayback: true,
      iframeAllow: "camera; microphone",
      iframeAllowFullscreen: true);

  PullToRefreshController? pullToRefreshController;

  late ContextMenu contextMenu;
  String url = "";
  double progress = 0;

  @override
  void initState() {
    super.initState();

    contextMenu = ContextMenu(
        menuItems: [
          ContextMenuItem(
              id: 1,
              title: "Special",
              action: () async {
                print("Menu item Special clicked!");
                print(await webViewController?.getSelectedText());
                await webViewController?.clearFocus();
              })
        ],
        settings: ContextMenuSettings(hideDefaultSystemContextMenuItems: false),
        onCreateContextMenu: (hitTestResult) async {
          print("onCreateContextMenu");
          print(hitTestResult.extra);
          print(await webViewController?.getSelectedText());
        },
        onHideContextMenu: () {
          print("onHideContextMenu");
        },
        onContextMenuActionItemClicked: (contextMenuItemClicked) async {
          var id = contextMenuItemClicked.id;
          print(
              "onContextMenuActionItemClicked: $id ${contextMenuItemClicked.title}");
        });

    pullToRefreshController = kIsWeb ||
            ![TargetPlatform.iOS, TargetPlatform.android]
                .contains(defaultTargetPlatform)
        ? null
        : PullToRefreshController(
            settings: PullToRefreshSettings(
              color: Colors.blue,
            ),
            onRefresh: () async {
              if (defaultTargetPlatform == TargetPlatform.android) {
                webViewController?.reload();
              } else if (defaultTargetPlatform == TargetPlatform.iOS ||
                  defaultTargetPlatform == TargetPlatform.macOS) {
                webViewController?.loadUrl(
                    urlRequest:
                        URLRequest(url: await webViewController?.getUrl()));
              }
            },
          );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(children: <Widget>[
      Expanded(
        child: Stack(
          children: [
            InAppWebView(
              key: webViewKey,
              initialUrlRequest: URLRequest(url: WebUri('https://flutter.dev')),
              // initialUrlRequest:https://gandalverse.com
              // URLRequest(url: WebUri(Uri.base.toString().replaceFirst("/#/", "/") + 'page.html')),
              // initialFile: "assets/index.html",
              initialUserScripts: UnmodifiableListView<UserScript>([]),
              initialSettings: settings,
              contextMenu: contextMenu,
              pullToRefreshController: pullToRefreshController,
              onWebViewCreated: (controller) async {
                webViewController = controller;
              },

              onPermissionRequest: (controller, request) async {
                return PermissionResponse(
                    resources: request.resources,
                    action: PermissionResponseAction.GRANT);
              },
              shouldOverrideUrlLoading: (controller, navigationAction) async {
                var uri = navigationAction.request.url!;

                if (![
                  "http",
                  "https",
                  "file",
                  "chrome",
                  "data",
                  "javascript",
                  "about"
                ].contains(uri.scheme)) {
                  if (await canLaunchUrl(uri)) {
                    // Launch the App
                    await launchUrl(
                      uri,
                    );
                    // and cancel the request
                    return NavigationActionPolicy.CANCEL;
                  }
                }

                return NavigationActionPolicy.ALLOW;
              },

              onReceivedError: (controller, request, error) {
                pullToRefreshController?.endRefreshing();
              },
              // onProgressChanged: (controller, progress) {
              //   if (progress == 100) {
              //     pullToRefreshController?.endRefreshing();
              //   }
              //   setState(() {
              //     this.progress = progress / 100;
              //     urlController.text = this.url;
              //   });
              // },
              // onUpdateVisitedHistory: (controller, url, isReload) {
              //   setState(() {
              //     this.url = url.toString();
              //     urlController.text = this.url;
              //   });
              // },
              onConsoleMessage: (controller, consoleMessage) {
                print(consoleMessage);
              },
            ),
            progress < 1.0
                ? Stack(children: [
                    Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                "assets/images/GverseToken_OnboardingPage.png"),
                            fit: BoxFit.cover),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.7,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                              Colors.transparent,
                              Colors.transparent,
                              Colors.transparent,
                              Colors.black12,
                              Colors.black26,
                              Colors.black38,
                              Colors.black45,
                              Colors.black54,
                              Colors.black87,
                            ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter)),
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
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 1, left: 1, right: 1),
                      child: LinearProgressIndicator(
                        color: Colors.blue.shade400,
                        value: progress,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ])
                : Container(),
          ],
        ),
      ),
    ]));
  }
}
*/