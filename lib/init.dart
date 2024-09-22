// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:gandalverse/core/services/QG_services/equipe_service.dart';
import 'package:gandalverse/core/services/QG_services/partenaire_service.dart';
import 'package:gandalverse/di/global_dependencies.dart';
import 'package:gandalverse/screens/new_design_screens/home_page.dart';
import 'package:go_router/go_router.dart';
import '../main.dart';

class InitializationPage extends StatefulWidget {
  const InitializationPage({super.key});

  @override
  State<InitializationPage> createState() => _InitializationPageState();
}

class _InitializationPageState extends State<InitializationPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GandalVerse',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: Init.initialize(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // return HomeVrScreen();
            // Navigation vers HomeVrScreen une fois l'initialisation terminée
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.go(
                  '/home_vr'); // Assurez-vous que ce chemin correspond à la route définie
            });
            return const SizedBox
                .shrink(); // Retourne un widget vide pendant la navigation
          } else {
            return const SplashScreen();
          }
        },
      ),
    );
  }
}

class Init {
  static initialize() async {
    await _registerServices();
    await _loadSettings();
  }

  static _registerServices() async {
    print("debut chargement service");
    await Future.delayed(const Duration(seconds: 1));
  }

  static _loadSettings() async {
    print("debut chargement setting");
    PartenaireService _partenaireService = getIt<PartenaireService>();
    EquipeService _equipeService = getIt<EquipeService>();

    await Future.wait([
      _partenaireService.loadInitialData(),
      _equipeService.loadInitialData()
    ]);

    await Future.delayed(const Duration(seconds: 1));
    print("debut chargement");
    print("fin chargement setting");
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: <Widget>[
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
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                Colors.transparent,
                Colors.transparent,
                Colors.transparent,
                Colors.black26,
                Colors.black38,
                Colors.black45,
                Colors.black54,
                Colors.black87,
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                /* const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text(
                      "Gandal Verse".toUpperCase(),
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontFamily: 'Aller',
                          fontSize: 35,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
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
                ),*/
                const Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text(
                      "build en cours ...",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontFamily: 'Aller',
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
              ],
            ),
            floatingActionButton: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 1.2,
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
          ),
        ],
      ),
    );
  }
}
