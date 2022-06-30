
import 'package:assignment_flutter/constants/app_constants.dart';
import 'package:assignment_flutter/providers/google_sign_in_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/navigation_provider.dart';


/// Navigation entry point for app.
class Root extends StatelessWidget {
  static const route = '/route';
  const Root({Key? key}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Consumer<NavigationProvider>(
      builder: (context, provider, child) {
        // Create bottom navigation bar items from screens.
        final bottomNavigationBarItems = provider.screens
            .map((screen) => BottomNavigationBarItem(
            icon: screen.icon, label: screen.title))
            .toList();

        // Initialize [Navigator] instance for each screen.
        final screens = provider.screens
            .map(
              (screen) => Navigator(
            key: screen.navigatorState,
            onGenerateRoute: screen.onGenerateRoute,
          ),
        )
            .toList();

        return WillPopScope(

          onWillPop: () async => provider.onWillPop(context),
          child: Scaffold(
            appBar: AppBar(title: Text('Welcome ${user.displayName}'),
            centerTitle: true,),
            body: IndexedStack(
              children: screens,
              index: provider.currentTabIndex,
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: bottomNavigationBarItems,
              currentIndex: provider.currentTabIndex,
              onTap: provider.setTab,
            ),
            drawer: Drawer(
              child: SafeArea(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.all(AppConstants.padSixteen),
                      child: Text('DEMO APP', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),),
                    ),
                    const Divider(
                      height: 2,
                      thickness: 1,
                      // indent: 20,
                      // endIndent: 0,
                      color: Colors.greenAccent,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(AppConstants.padSixteen),
                      child: Text('Change Language', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                    ),
                    const Divider(
                      height: 2,
                      thickness: 1,
                      // indent: 20,
                      // endIndent: 0,
                      color: Colors.greenAccent,
                    ),
                    InkWell(
                      onTap: (){
                        final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
                        provider.logout();
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(AppConstants.padSixteen),
                        child: Text('Logout', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                      ),
                    ),
                    const Divider(
                      height: 2,
                      thickness: 1,
                      // indent: 20,
                      // endIndent: 0,
                      color: Colors.greenAccent,
                    ),

                  ],
                ),
              ),
            ),
            // Disable opening the end drawer with a swipe gesture.
            endDrawerEnableOpenDragGesture: true,
          ),
        );
      },
    );
  }
}
