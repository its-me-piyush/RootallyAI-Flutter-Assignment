import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:rootally_ai_internship/screens/auth/components/authentication_service.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);
  static const routeName = '/sign-in';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Spacer(),
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                width: double.infinity,
                decoration: const BoxDecoration(
                    image:
                        DecorationImage(image: AssetImage('assets/logo.png'))),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Sign in',
                    style: TextStyle(fontSize: 40),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Icon(
                    Icons.exit_to_app_rounded,
                    size: 40,
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    labelText: 'Email Address',
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    labelText: 'Password',
                    suffixIcon: Icon(Icons.visibility_off_rounded),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 20),
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Center(
                child: Container(
                  // width: MediaQuery.of(context).size.width * 0.5,
                  margin: const EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(15),
                    onTap: () {
                      context.read<AuthenticationService>().signIn(
                          email: _emailController.text.trim(),
                          pass: _passwordController.text.trim());
                    },
                    child: Container(
                        margin: const EdgeInsets.only(
                            top: 10, bottom: 10, left: 50, right: 50),
                        child: const Text('Login')),
                  ),
                ),
              ),
              const Spacer(),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.call,
                      color: Colors.blue,
                    ),
                    Text(
                      'Contact us',
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
