

import 'package:assignment_flutter/screens/loginscreen/login.dart';
import 'package:assignment_flutter/screens/root.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Logged extends StatelessWidget {
  static const route = '/';
  const Logged({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator());
            }else if(snapshot.hasData){
              return const Root();
            }else{
              return const Login();
            }

          }),
        );
  }
}
