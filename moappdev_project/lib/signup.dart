import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 70.0),
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 250,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    filled: true,
                    labelText: 'Email',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter your email address';
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
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter your password';
                    }
                    return null;
                  },
                  obscureText: true,
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: const InputDecoration(
                    filled: true,
                    labelText: 'Confirm Password',
                  ),
                  validator: (value) {
                    if ((value!.isEmpty) ||
                        (_passwordController.value !=
                            _confirmPasswordController.value)) {
                      return 'Password mismatch!';
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
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.grey,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () => signUp(
                            _emailController.text, _passwordController.text),
                        child: const Text('Sign-Up'),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      width: 250,
                      height: 300,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;

      Navigator.pop(context);
      addUserInfo(user!.uid);
    } on FirebaseAuthException catch (e) {
      String message = '';

      if (e.code == 'email-already-in-use') {
        message = '?????? ???????????? ????????? ?????????.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.blueAccent,
        ),
      );
    }
  }

  Future<void> addUserInfo(String uid) async {
    CollectionReference user = FirebaseFirestore.instance.collection('user');
    user.doc(uid).set({
      'name': 'userName',
      'major': 'Major',
      'semester': 1,
      'status': 'Please enter a status message',
      'photoUrl': 'https://picsum.photos/id/237/5000/5000',
    });
  }
}
