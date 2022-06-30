import 'package:flutter/material.dart';

// holds all information required to build screen.
class Screen {
  // String title used inside bottom navigation bar items
  final String title;
  final Icon icon;

  // Screen content
  final Widget child;

  // Route generator for this screen's inner
  final RouteFactory onGenerateRoute;

  // Initial route needs to be handled in implementation
  final String initialRoute;

  // Navigator state for this screen
  final GlobalKey<NavigatorState> navigatorState;

  // Scroll controller for manipulating scroll views from

  final ScrollController? scrollController;

  Screen({
    required this.title,
    required this.icon,
    required this.child,
    required this.onGenerateRoute,
    required this.initialRoute,
    required this.navigatorState,
    this.scrollController,
  });
}
