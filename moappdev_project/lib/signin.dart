import 'package:flutter/material.dart';
import 'package:moappdve_project/login.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 70.0),
        children: [
          Column(
            children: [
              const SizedBox(
                height: 250,
              ),
              TextField(
                controller: _idController,
                decoration: const InputDecoration(
                  filled: true,
                  labelText: 'ID',
                ),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  filled: true,
                  labelText: 'Password',
                ),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: _confirmPasswordController,
                decoration: const InputDecoration(
                  filled: true,
                  labelText: 'Confirm Password',
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  filled: true,
                  labelText: 'Name',
                ),
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
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const LoginPage()));
                      },
                      child: const Text('Sign-In'),
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
    );
  }
}
