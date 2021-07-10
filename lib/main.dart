import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:nodejs_login/screens/dashboard.dart';
import 'package:nodejs_login/screens/register.dart';
import 'package:nodejs_login/screens/loading.dart';
import 'package:nodejs_login/screens/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.active){
            User? user = snapshot.data;
            if(user == null){
              return LoginPage();
            }
            return Dashboard();
          } else {
            return LoadingPage();
          }
        },
      ),
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => Register(),
        '/dashboard': (context) => Dashboard(),
      },
    );
  }
}
