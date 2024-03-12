import 'package:animal_collectables/presentation/providers/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme/colors.dart';
import '../theme/fonts.dart';
import 'home_page.dart';
import 'sign_in_page.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: babyPowder,
      body: body(),
    );
  }

  Center body() {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Hello, it's a pleasure to meet you!",
                style: pFont.copyWith(
                  fontSize: 17,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Create your account',
                style: pFont.copyWith(
                  fontSize: 23,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 35),
              CreateAccountForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class CreateAccountForm extends StatelessWidget {
  CreateAccountForm({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  Future<UserCredential?> register(
      String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await context
          .read<AuthModel>()
          .createAcccount(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      String error = 'Something is wrong with your credentials';
      if (e.code == 'email-already-in-use') {
        error = 'Email already in use';
      }
      if (e.code == 'weak-password') {
        error = 'Week password';
      }
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(error),
          duration: const Duration(seconds: 1),
        ));
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
                hintText: 'Enter your e-mail',
                prefixIcon: Container(
                    width: 50,
                    margin: const EdgeInsets.only(right: 10),
                    color: Colors.grey,
                    child: const Icon(Icons.mail)),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 0,
                )),
            validator: (value) => _emailController.text.isNotEmpty
                ? null
                : 'Este valor es requerido',
          ),
          const SizedBox(
            height: 15,
          ),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
                hintText: 'Enter your password',
                prefixIcon: Container(
                    width: 50,
                    margin: const EdgeInsets.only(right: 10),
                    color: Colors.grey,
                    child: const Icon(Icons.lock)),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 0,
                )),
            validator: (value) => _passwordController.text.isNotEmpty
                ? null
                : 'Este valor es requerido',
          ),
          const SizedBox(
            height: 15,
          ),
          TextFormField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(
                  hintText: 'Confirm your password',
                  prefixIcon: Container(
                      width: 50,
                      margin: const EdgeInsets.only(right: 10),
                      color: Colors.grey,
                      child: const Icon(Icons.lock)),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 0,
                  )),
              validator: (value) {
                if (_confirmPasswordController.text.isEmpty) {
                  return 'Este valor es requerido.';
                }
                if (_passwordController.text.isNotEmpty) {
                  if (_passwordController.text ==
                      _confirmPasswordController.text) {
                    return null;
                  }
                }
                return null;
              }),
          const SizedBox(
            height: 15,
          ),
          ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  UserCredential? credentials = await register(
                      _emailController.text, _passwordController.text, context);

                  if (credentials != null) {
                    if (credentials.user != null) {
                      credentials.user!.sendEmailVerification();
                      if (context.mounted) {
                        // Navigator.of(context).pop();
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                              'Please check your e-mail, we send you a verification link.'),
                          duration: Duration(seconds: 1),
                        ));
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
                      }
                    }
                  }
                }
              },
              child: const Text('Create')),
          const Row(children: [
            SizedBox(
              width: 10,
            ),
            Expanded(
                child: Divider(
              color: Colors.grey,
            )),
            SizedBox(
              width: 10,
            ),
            Text("or"),
            SizedBox(
              width: 10,
            ),
            Expanded(
                child: Divider(
              color: Colors.grey,
            )),
            SizedBox(
              width: 10,
            ),
          ]),
          const SizedBox(
            height: 10,
          ),
          TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignInPage(),
                  ),
                  (route) => false,
                );
              },
              child: const Text('Log in')),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
