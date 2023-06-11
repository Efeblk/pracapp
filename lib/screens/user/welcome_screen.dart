import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../localizations/localizations.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue,
              Colors.green
            ], // Replace with your desired colors
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      GoRouter.of(context).push('/login');
                    },
                    icon: Icon(Icons.login),
                    label: Text(
                        AppLocalizations.of(context).getTranslate('login')),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white, // Customize button color
                      onPrimary: Colors.black, // Customize text color
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      GoRouter.of(context).push('/register');
                    },
                    icon: Icon(Icons.person_add),
                    label: Text(
                        AppLocalizations.of(context).getTranslate('register')),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white, // Customize button color
                      onPrimary: Colors.black, // Customize text color
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).replace('/home');
              },
              child: Text(
                AppLocalizations.of(context).getTranslate('continue_no_user'),
                style: TextStyle(fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.white, // Customize button color
                onPrimary: Colors.black, // Customize text color
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(20.0), // Customize button shape
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: 16, vertical: 12), // Add padding
              ),
            ),
          ],
        ),
      ),
    );
  }
}
