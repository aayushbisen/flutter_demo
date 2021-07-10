import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      appBar: AppBar(
        title: Image.asset(
          'assets/HealthVu_logo.png',
          fit: BoxFit.cover,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: Icon(Icons.menu),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 10.0,
            ),
            child: Icon(Icons.shopping_cart_outlined),
          )
        ],
      ),
      body: Center(
        child: Text('Signed in successfully!',
            style: GoogleFonts.montserrat(
              fontSize: 32,
            )),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.logout),
        onPressed: () async {
          await FirebaseAuth.instance.signOut();
          Navigator.pushReplacementNamed(context, '/login');
        },
      ),
    );
  }
}
