import 'package:assignment_flutter/screens/todoscreen/add_todo_page.dart';
import 'package:assignment_flutter/screens/todoscreen/edit_todo_page.dart';
import 'package:assignment_flutter/screens/aesencryption/encryption.dart';
import 'package:assignment_flutter/screens/loginscreen/logged_screen.dart';
import 'package:assignment_flutter/screens/loginscreen/login.dart';
import 'package:assignment_flutter/screens/stopwatchscreen/stopwatch.dart';
import 'package:assignment_flutter/screens/todoscreen/todo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/screen.dart';
import '../screens/root.dart';
import '../widgets/exit_dialog.dart';

const FIRST_SCREEN = 0;
const SECOND_SCREEN = 1;
const THIRD_SCREEN = 2;

class NavigationProvider extends ChangeNotifier {
  /// Shortcut method for getting [NavigationProvider].
  static NavigationProvider of(BuildContext context) =>
      Provider.of<NavigationProvider>(context, listen: false);

  int _currentScreenIndex = FIRST_SCREEN;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int get currentTabIndex => _currentScreenIndex;

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    print('Generating route: ${settings.name}');
    switch (settings.name) {
      case AddTodoPage.route:
        return MaterialPageRoute(builder: (_) => const AddTodoPage());
      case EditTodoPage.route:
        return MaterialPageRoute(builder: (_) => const EditTodoPage());
      default:
        return MaterialPageRoute(builder: (_) => const Logged());
    }
  }

  final Map<int, Screen> _screens = {
    FIRST_SCREEN: Screen(
      title: 'Encryption',
      icon: const Icon(Icons.lock),
      child: const Encryption(),
      initialRoute: Encryption.route,
      navigatorState: GlobalKey<NavigatorState>(),
      onGenerateRoute: (settings) {
        print('Generating route: ${settings.name}');
        switch (settings.name) {
       /*   case PushedScreen.route:
            return MaterialPageRoute(builder: (_) => PushedScreen());*/
          default:
            return MaterialPageRoute(builder: (_) => const Encryption());
        }
      },
      scrollController: ScrollController(),
    ),
    SECOND_SCREEN: Screen(
      title: 'To-Do',
      icon: const Icon(Icons.today_outlined),
      child: const Todo(),
      initialRoute: Todo.route,
      navigatorState: GlobalKey<NavigatorState>(),
      onGenerateRoute: (settings) {
        print('Generating route: ${settings.name}');
        switch (settings.name) {
          default:
            return MaterialPageRoute(builder: (_) => const Todo());
        }
      },
      scrollController: ScrollController(),
    ),
    THIRD_SCREEN: Screen(
      title: 'Stopwatch',
      icon: const Icon(Icons.timer_rounded),
      child:  StopWatch(),
      initialRoute: StopWatch.route,
      navigatorState: GlobalKey<NavigatorState>(),
      onGenerateRoute: (settings) {
        print('Generating route: ${settings.name}');
        switch (settings.name) {
          default:
            return MaterialPageRoute(builder: (_) => StopWatch());
        }
      },
      scrollController: ScrollController(),
    ),
  };

  List<Screen> get screens => _screens.values.toList();

  Screen? get currentScreen => _screens[_currentScreenIndex];

  /// Set currently visible tab.
  void setTab(int tab) {
    if (tab == currentTabIndex) {
      _scrollToStart();
    } else {
      _currentScreenIndex = tab;
      notifyListeners();
    }
  }

  /// If currently displayed screen has given [ScrollController] animate it
  /// to the start of scroll view.
  void _scrollToStart() {
    if (currentScreen!.scrollController != null &&
        currentScreen!.scrollController!.hasClients) {
      currentScreen!.scrollController!.animateTo(
        0,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }

  /// Provide this to [WillPopScope] callback.
  Future<bool> onWillPop(BuildContext context) async {
    final currentNavigatorState = currentScreen!.navigatorState.currentState;

    if (currentNavigatorState!.canPop()) {
      currentNavigatorState.pop();
      return false;
    } else {
      if (currentTabIndex != FIRST_SCREEN) {
        setTab(FIRST_SCREEN);
        notifyListeners();
        return false;
      } else {
        return await showDialog(
          context: context,
          builder: (context) => const ExitAlertDialog(),
        );
      }
    }
  }

  void openEndDrawer() {
    _scaffoldKey.currentState!.openEndDrawer();
  }

  void closeEndDrawer(BuildContext context) {
    Navigator.of(context).pop();
  }
}
