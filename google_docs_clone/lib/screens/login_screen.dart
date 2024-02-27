

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_docs_clone/repository/auth_repository.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  void signInWithGoogle(WidgetRef ref){
    ref.read(AuthRepositoryProvider).signInWithGoogle();
  }
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: ElevatedButton.icon(onPressed:(){ signInWithGoogle(ref);}, 
          icon:Image.asset('assets/images/g-logo-2.png',height: 20,), 
          label: Text("sign in with google")),
      ),
    );
  }
}