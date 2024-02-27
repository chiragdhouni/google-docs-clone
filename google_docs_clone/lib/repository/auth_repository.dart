import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod/riverpod.dart';

final AuthRepositoryProvider=Provider((ref) => AuthRepository(googleSignIn: GoogleSignIn()));
class AuthRepository{
  final GoogleSignIn _googleSignIn;

  AuthRepository({required GoogleSignIn googleSignIn}): _googleSignIn=googleSignIn;

  void signInWithGoogle() async{
    try {
       final user=await _googleSignIn.signIn();
       if(user!=null){
          print(user.email);
          print(user.displayName);
          print(user.photoUrl);
       }
    } catch (e) {
      print(e);
    }
   
  }
  
}