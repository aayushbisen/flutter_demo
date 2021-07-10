import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // state variables
  late String _name;
  late String _password;

  final _formKey = GlobalKey<FormState>();

  void _onSubmit() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _name, password: _password);

      Navigator.of(context).pushNamed('/dashboard');
    } on PlatformException catch (error) {
      String message = 'Please check your credentials and try again';

      if (error.message != null) {
        message = error.message.toString();
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(context).errorColor,
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 3),
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString()),
          backgroundColor: Theme.of(context).errorColor,
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(11, 8, 0, 0),
                  child: Icon(
                    Icons.arrow_back,
                    size: 30,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'To purchase HealthVu Basic',
              style: GoogleFonts.montserrat(
                color: Color(0xff332F2F),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'please log in',
              style: GoogleFonts.montserrat(
                color: Color(0xff332F2F),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Image.asset(
              'assets/Login_Image.png',
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 32,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: TextFormField(
                      onSaved: (value) {
                        _name = value.toString();
                      },
                      decoration: InputDecoration(
                        hintText: 'Username*',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Username is required';
                        }
                        
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: TextFormField(
                      onSaved: (value) {
                        _password = value.toString();
                      },
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        }

                        return null;
                      },
                      // controller: passwordController,
                      decoration: InputDecoration(
                        hintText: 'Password*',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: Text(
                      'New User? Sign Up',
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          letterSpacing: 1.7,
                          color: Colors.black87),
                    ),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 60),
                          elevation: 10,
                          primary: Color(0xff000a42)),
                      onPressed: () async {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }
                        _formKey.currentState!.save();
                        _onSubmit();
                      },
                      child: Text(
                        'Sign In',
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Forgot Details?',
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                letterSpacing: 1.5,
                color: Color(0xff7c7c7c),
              ),
            ),
            SizedBox(
              height: 20.0,
            )
          ],
        ),
      ),
    );;
  }
}
