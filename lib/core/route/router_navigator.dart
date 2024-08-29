import 'package:flutter/material.dart';
import 'package:gandalverse/init.dart';
import 'package:gandalverse/main.dart';
import 'package:gandalverse/screens/QG_screen/QG_screen.dart';
import 'package:gandalverse/screens/amis/amis_page.dart';
import 'package:gandalverse/screens/new_design_screens/home_page.dart';
import 'package:gandalverse/screens/revenus/revenus_page.dart';
import 'package:go_router/go_router.dart';

import 'route_name.dart';

class RootNavigator {
  final GoRouter makeRoutes = GoRouter(initialLocation: "/", routes: [
    // Route pour l'écran d'initialisation
    GoRoute(
      name: welcome_view,
      path: '/',
      builder: (context, state) => InitializationPage(),
    ),
    GoRoute(
      name: "telegram",
      path: '/telegram',
      builder: (context, state) => TelegramWebAppPage(),
    ),
    // Route pour l'écran de walkthrough
    // GoRoute(
    //   name: splash_view,
    //   path: '/splash',
    //   builder: (context, state) => Walkthrough(),
    // ),

    GoRoute(
      name: home_view,
      path: '/home_vr',
      // Toutes les routes pour le client commencent par /client/
      builder: (BuildContext context, GoRouterState state) => HomeVrScreen(),
      routes: <RouteBase>[
        GoRoute(
          name: amis_view,
          path: 'amis',
          builder: (context, state) => const AmisPage(),
        ),
        GoRoute(
          name: revenu_view,
          path: 'revenu',
          builder: (context, state) => const AllRevenusPage(),
        ),
        GoRoute(
          name: qg_view,
          path: 'qg',
          builder: (context, state) => QGScreen(),
        ),
      ],
    )
  ]);
  // Routes pour l'application livreur
}
