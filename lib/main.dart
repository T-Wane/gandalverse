import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gandalverse/init.dart';
//import 'package:telegram_web_app/telegram_web_app.dart';

import 'screens/home.page.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

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

  runApp(const InitializationPage());//InitializationPage
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GandalVerse',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Aller',
        textTheme: Theme.of(context).textTheme,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)
            .copyWith(background: const Color(0xffe7e9f0)),
      ),
      home: MyHomePage(),
      //backgroundColor: Theme.of(context).colorScheme.inversePrimary,
    );
  }
} 