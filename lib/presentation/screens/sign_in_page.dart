import 'package:animal_collectables/presentation/providers/auth_provider.dart';
import 'package:animal_collectables/presentation/screens/home_page.dart';
import 'package:animal_collectables/presentation/screens/create_account_page.dart';
import 'package:animal_collectables/presentation/theme/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme/fonts.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          backgroundColor: babyPowder,
          body: body(),
        ));
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
                'Welcome back',
                style: pFont.copyWith(
                  fontSize: 17,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Login to your account',
                style: pFont.copyWith(
                  fontSize: 23,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 35),
              SignInForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class SignInForm extends StatelessWidget {
  SignInForm({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<UserCredential?> login(
      String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await context
          .read<AuthModel>()
          .signIn(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print('e');
      print(e);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Something is wrong with your credentials'),
          duration: Duration(seconds: 1),
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
                hintText: 'Enter your e-mail or username',
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
          ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  UserCredential? credentials = await login(
                      _emailController.text, _passwordController.text, context);
                  if (credentials != null) {
                    if (credentials.user != null) {
                      if (credentials.user!.emailVerified) {
                        if (context.mounted) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomePage(),
                              ),
                              (route) => false);
                        }
                      } else {
                        if (context.mounted) {
                          context.read<AuthModel>().signOut();
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Email not verified yet'),
                            duration: Duration(seconds: 1),
                          ));
                        }
                      }
                    }
                  }
                }
              },
              child: const Text('Ingresar')),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Don't have an account?"),
              TextButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CreateAccountPage(),
                      ),
                      (route) => false,
                    );
                  },
                  child: const Text('Register')),
            ],
          ),
        ],
      ),
    );
  }
}
