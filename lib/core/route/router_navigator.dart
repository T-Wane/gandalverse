import 'package:flutter/material.dart';
import 'package:gandalverse/init.dart';
import 'package:gandalverse/main.dart';
import 'package:gandalverse/screens/QG_screen/QG_screen.dart';
import 'package:gandalverse/screens/amis/amis_page.dart';
import 'package:gandalverse/screens/bm_bank/agances_map_screen.dart';
import 'package:gandalverse/screens/defis/defis_screen.dart';
import 'package:gandalverse/screens/learn_screens/learn_home/learn_home_screen.dart';
import 'package:gandalverse/screens/new_design_screens/home_page.dart';
import 'package:gandalverse/screens/revenus/revenus_page.dart';
import 'package:go_router/go_router.dart';

import '../../screens/bm_bank/map_markers.dart';
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
      // GoRoute(
      //   name: 'initializationWithParam',
      //   path: '/:tgWebAppData',
      //   builder: (BuildContext context, GoRouterState state) {
      //     final tgWebAppData = state.pathParameters['tgWebAppData'];
      //     return InitializationPage(
      //         // tgWebAppData: tgWebAppData, // Passer les paramètres ici si nécessaire
      //         );
      //   },
      // ),

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
            pageBuilder: (context, state) =>
                RouterTransitionFactory.getTransitionPage(
              context: context,
              state: state,
              child: const AmisPage(),
              type: 'slide', // fade|rotation|scale|size
            ),
          ),
          GoRoute(
            name: revenu_view,
            path: 'revenu',
            builder: (context, state) => const AllRevenusPage(),
            pageBuilder: (context, state) =>
                RouterTransitionFactory.getTransitionPage(
              context: context,
              state: state,
              child: const AllRevenusPage(),
              type: 'slide', // fade|rotation|scale|size
            ),
          ),
          GoRoute(
            name: qg_view,
            path: 'qg',
            builder: (context, state) => QGScreen(),
            pageBuilder: (context, state) =>
                RouterTransitionFactory.getTransitionPage(
              context: context,
              state: state,
              child: QGScreen(),
              type: 'slide', // fade|rotation|scale|size
            ),
          ),
          GoRoute(
            name: defi_view,
            path: 'defi',
            builder: (context, state) => AnnoncesPage(),
            pageBuilder: (context, state) =>
                RouterTransitionFactory.getTransitionPage(
              context: context,
              state: state,
              child: AnnoncesPage(),
              type: 'slide', // fade|rotation|scale|size
            ),
          ),
          GoRoute(
            name: learn_home_view,
            path: 'learn_home',
            builder: (context, state) => LearnHomeScreen(),
            pageBuilder: (context, state) =>
                RouterTransitionFactory.getTransitionPage(
              context: context,
              state: state,
              child: const LearnHomeScreen(),
              type: 'custom_curve', // fade|rotation|scale|size
            ),
          ),
          GoRoute(
            name: bnda_view,
            path: 'bnda_home',
            builder: (context, state) => BndaAgenceMapScreen(),
          ),
        ],
      ),
    ], // Route de rattrapage pour les routes inconnues
    errorBuilder: (context, state) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go('/');
      });
      // Retourner un widget vide temporaire, car la redirection sera effectuée
      return Scaffold(
        body: Center(
            child: CircularProgressIndicator()), // Indicateur de chargement
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

class RouterTransitionFactory {
  static CustomTransitionPage getTransitionPage({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,
    required String type,
  }) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        switch (type) {
          case 'fade':
            return FadeTransition(opacity: animation, child: child);
          case 'rotation':
            return RotationTransition(turns: animation, child: child);
          case 'size':
            return SizeTransition(sizeFactor: animation, child: child);
          case 'scale':
            return ScaleTransition(scale: animation, child: child);
          case 'slide':
            return SlideTransition(
              position: Tween<Offset>(
                begin: Offset(1.0, 0.0), // Start from the right
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          case 'scale_rotation':
            return ScaleTransition(
              scale: animation,
              child: RotationTransition(
                turns: animation,
                child: child,
              ),
            );
          case 'custom_curve':
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: Curves.easeInToLinear, // Example of a custom curve
            );
            return FadeTransition(opacity: curvedAnimation, child: child);
          default:
            return FadeTransition(opacity: animation, child: child);
        }
      },
    );
  }
}
