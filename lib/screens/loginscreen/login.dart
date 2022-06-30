
import 'package:assignment_flutter/constants/app_constants.dart';
import 'package:assignment_flutter/providers/google_sign_in_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  static const route = '/login';
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.padSixteen),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Center(
                child: Text(
                  'DEMO APP', style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),),
              ),
              const SizedBox(height: 30,),
              ElevatedButton(
                  onPressed: ()  {
                    final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
                    provider.googleLogin();
              }, child: const Text('Sign in by Google'))
            ],


          ),
        ),
      ),
    );
  }
}
