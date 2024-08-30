import 'package:flutter/material.dart';
import 'package:gandalverse/init.dart';
import 'package:gandalverse/main.dart';
import 'package:gandalverse/screens/QG_screen/QG_screen.dart';
import 'package:gandalverse/screens/amis/amis_page.dart';
import 'package:gandalverse/screens/defis/defis_screen.dart';
import 'package:gandalverse/screens/new_design_screens/home_page.dart';
import 'package:gandalverse/screens/revenus/revenus_page.dart';
import 'package:go_router/go_router.dart';

import 'route_name.dart';
/*
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
        name: 'initializationWithParam',
        path: '/:tgWebAppData',
        builder: (BuildContext context, GoRouterState state) {
          final tgWebAppData = state.pathParameters['tgWebAppData'];
          return InitializationPage(
           // tgWebAppData: tgWebAppData, // Passer les paramètres ici si nécessaire
          );
        },
      ),
      GoRoute(
        name: "telegram",
        path: '/telegram',
        builder: (context, state) {
          // Extraire les paramètres de l'URL
          final queryParams = state.extra as Map<String, String>;
          return TelegramWebAppPage(queryParams: queryParams);
        },
      ),
      // Autres routes...
      GoRoute(
        name: home_view,
        path: '/home_vr',
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
          GoRoute(
            name: defi_view,
            path: 'defi',
            builder: (context, state) => AnnoncesPage(),
          ),
        ],
      ),
    ],
  );
}*/

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
        name: 'initializationWithParam',
        path: '/:tgWebAppData',
        builder: (BuildContext context, GoRouterState state) {
          final tgWebAppData = state.pathParameters['tgWebAppData'];
          return InitializationPage(
              // tgWebAppData: tgWebAppData, // Passer les paramètres ici si nécessaire
              );
        },
      ),
      GoRoute(
        name: "telegram",
        path: '/telegram',
        builder: (context, state) {
          // Extraire les paramètres de l'URL
          final queryParams = state.extra as Map<String, String>;
          return TelegramWebAppPage(queryParams: queryParams);
        },
      ),
      // Autres routes...
      GoRoute(
        name: home_view,
        path: '/home_vr',
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
          GoRoute(
            name: defi_view,
            path: 'defi',
            builder: (context, state) => AnnoncesPage(),
          ),
        ],
      ),
    ], // Route de rattrapage pour les routes inconnues
    errorBuilder: (context, state) {
      // debugPrint('Navigated to unknown route: ${state.uri.toString()}');
      // Extraire les paramètres de l'URL
      final queryParams = state.pathParameters;
      return NotFoundPage(
        path: state,
        parameters: queryParams,
      );
    },
  );
}

class NotFoundPage extends StatelessWidget {
  final GoRouterState path;
  final dynamic parameters;

  NotFoundPage({Key? key, required this.path, required this.parameters});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page Not Found'),
      ),
      body: ListView( 
        children: [
          Text(
            '404 - Page Not Found',
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(height: 16),
          Text(
            "  \n *  pageKey: ${path.pageKey.value}  \n * Path: ${path.path}  \n * Path name: ${path.name} \n * Path  : ${path.uri.path}  \n * uri  : ${path.uri.toString()}   \n * fullPath  : ${path.fullPath}  \n * matchedLocation  : ${path.matchedLocation}  ",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 16),
          Text(
            'Parameters: $parameters',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
