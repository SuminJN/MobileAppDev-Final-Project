import 'package:flutter/material.dart';
import 'package:moappdve_project/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:moappdve_project/screens/calendar/utils.dart';

import 'home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    getPlans();
    super.initState();
  }

  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 70.0),
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 250,
                ),
                TextFormField(
                  controller: _idController,
                  decoration: const InputDecoration(
                    filled: true,
                    labelText: 'ID',
                    icon: Icon(Icons.mail),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter your email address to continue';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    filled: true,
                    labelText: 'Password',
                    icon: Icon(Icons.enhanced_encryption),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter your password';
                    }
                    return null;
                  },
                  obscureText: true,
                ),
                const SizedBox(height: 50.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 100,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const SignupPage()));
                        },
                        child: const Text('Sign Up'),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () => _login(),
                        child: const Text('Login'),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.cyan,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 110,
                ),
                Image.asset(
                  'assets/images/logo.png',
                  width: 300,
                  height: 300,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _login() async {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).requestFocus(FocusNode());

      // Firebase 사용자 인증, 사용자 등록
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _idController.text,
          password: _passwordController.text,
        );

        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const MainPage()));
      } on FirebaseAuthException catch (e) {
        String message = '';

        if (e.code == 'user-not-found') {
          message = '사용자가 존재하지 않습니다.';
        } else if (e.code == 'wrong-password') {
          message = '비밀번호를 확인하세요';
        } else if (e.code == 'invalid-email') {
          message = '이메일을 확인하세요.';
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Colors.blueAccent,
          ),
        );
      }

    }
  }
}
