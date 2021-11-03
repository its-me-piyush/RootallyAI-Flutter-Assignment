import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rootally_ai_internship/screens/auth/components/authentication_service.dart';
import 'package:rootally_ai_internship/screens/auth/sign_in_screen.dart';
import 'package:rootally_ai_internship/screens/home/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(
            FirebaseAuth.instance,
          ),
        ),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().authStateChange,
          initialData: null,
        )
      ],
      child: MaterialApp(
        title: 'Rootally AI',
        debugShowCheckedModeBanner: false,
        home: const AuthenticationWrapper(),
        routes: {
          HomeScreen.routeName: (context) => const HomeScreen(),
          SignInScreen.routeName: (context) => const SignInScreen(),
        },
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    if (firebaseUser != null) {
      return const HomeScreen();
    } else {}
    return const SignInScreen();
  }
}
