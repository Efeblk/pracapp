import 'package:go_router/go_router.dart';

import '../screens/home_screen.dart';
import '../screens/initial_screen.dart';
import '../screens/static_screens/about_screen.dart';
import '../screens/static_screens/contact_screen.dart';
import '../screens/static_screens/settings_screen.dart';
import '../screens/test.dart';
import '../screens/user/login_screen.dart';
import '../screens/user/register_screen.dart';
import '../screens/user/welcome_screen.dart';

final routes = GoRouter(
  initialLocation: '/',
  routes: [
    // Loader Screen
    GoRoute(
      path: '/',
      builder: (context, state) => InitialScreen(),
    ),
    GoRoute(
      path: '/welcome',
      builder: (context, state) => WelcomeScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => ScrollDownNewsPage(),
    ),
    // User Screens
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => RegisterScreen(),
    ),
    // Static Screen
    GoRoute(
      path: '/about',
      builder: (context, state) => AboutScreen(),
    ),
    GoRoute(
      path: '/contact',
      builder: (context, state) => ContactScreen(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => SettingsScreen(),
    ),
  ],
);
