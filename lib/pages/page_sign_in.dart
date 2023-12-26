import 'package:flutter/material.dart';
import 'package:tubes_kel3/routes/route.dart';
import 'package:tubes_kel3/widgets/custom_field_text.dart';
import 'package:tubes_kel3/widgets/custom_text_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:tubes_kel3/pages/page_sign_up.dart';
import 'package:tubes_kel3/global/common/toast.dart';
import 'package:tubes_kel3/pages/user_auth/firebase_auth_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class pageSignIn extends StatefulWidget {
  const pageSignIn({super.key});

  @override
  State<pageSignIn> createState() => _pageSignIn();
}

class _pageSignIn extends State<pageSignIn> {
  bool _isSigning = false;
  final FirebaseAuthService _auth = FirebaseAuthService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.only(top: 70),
                child: const Image(
                  image: AssetImage('assets/images/logo.png'),
                  width: 150,
                  height: 150,
                )),
            Container(
                padding: EdgeInsets.only(bottom: 40),
                child: CustomTextStyle(
                  text: 'Welcome Back 👋',
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                )),
            Container(
                child: CustomTextStyle(
              text: 'Sign to your account',
              fontSize: 17,
            )),
            Container(
              child: CustomTextField(
                  controller: _emailController,
                  hintText: 'Masukkan Email',
                  inputType: TextInputType.emailAddress),
            ),
            Container(
              child: CustomTextField(
                controller: _passwordController,
                hintText: 'Masukkan Password',
                isPasswordField: true,
              ),
            ),
            GestureDetector(
              onTap: () {
                _signIn();
              },
              child: Container(
                alignment: Alignment.center,
                constraints: BoxConstraints(
                  minWidth: 300,
                  minHeight: 50,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.blue, // Sesuaikan dengan warna yang diinginkan
                ),
                child: _isSigning
                    ? CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : Text(
                        'Masuk',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors
                              .white, // Sesuaikan dengan warna yang diinginkan
                        ),
                      ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                'Atau',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Routes.signUp);
              },
              child: Container(
                width: 300,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: Colors.blue),
                ),
                child: Center(
                  child: Text(
                    'Daftar',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _signIn() async {
    setState(() {
      _isSigning = true;
    });

    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    setState(() {
      _isSigning = false;
    });

    if (user != null) {
      showToast(message: "User is successfully signed in");
      Navigator.pushNamed(context, "/riwayat");
    } else {
      showToast(message: "some error occured");
    }
  }
}
