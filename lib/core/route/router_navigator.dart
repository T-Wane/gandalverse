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
  final GoRouter makeRoutes = GoRouter(
    initialLocation: "/",
    routes: [
      // Route pour l'écran d'initialisation
      GoRoute(
        name: welcome_view,
        path: '/',
        builder: (context, state) => const InitializationPage(),
      ),
      GoRoute(
              name: '/',
              path: '/:tgWebAppData',
              builder: (BuildContext context, GoRouterState state)  => const InitializationPage()),
      GoRoute(
        name: "telegram",
        path: '/telegram',
        builder: (context, state) {
          // Extraire les paramètres de l'URL
          final queryParams = state.extra as Map<String, String>;
          return TelegramWebAppPage(queryParams: queryParams);
        },
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
      ),
    ], // redirect to the login page if the user is not logged in
    // redirect: (BuildContext context, GoRouterState state) {
    //   // if the user is not logged in, they need to login

    //   return '/';
    // },
  );
  // Routes pour l'application livreur
}
