import 'dart:convert';

import 'package:google_docs_clone/constant.dart';
import 'package:google_docs_clone/models/error_model.dart';
import 'package:google_docs_clone/models/user.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:riverpod/riverpod.dart';

// final authRepositoryProvider=Provider((ref) => AuthRepository(googleSignIn: GoogleSignIn(),client: Client()));

// final userProvider = StateProvider<UserModel?>((ref) => null);
// class AuthRepository{
//   final GoogleSignIn _googleSignIn;
//   final Client _client;

//   AuthRepository({required GoogleSignIn googleSignIn,required Client client}):_googleSignIn=googleSignIn,_client=client ;

//   Future<ErrorModel> signInWithGoogle() async{
//     ErrorModel errorModel=ErrorModel(error: "some error occured", data: null);
//     try {
      
//        final user=await _googleSignIn.signIn();

//        if(user!=null){
//         final userAcc= UserModel(email: user.email, name: user.displayName??"", profilePic: user.photoUrl??"", uid: '', token: '');
//         print(userAcc.toJson());
//         var res = await _client.post(Uri.parse('$host/api/signup'), body: userAcc.toJson(), headers: {
//           'Content-Type': 'application/json; charset=UTF-8',
//         });

//         print(res.statusCode);
//          switch (res.statusCode) {
//           case 200:
//             final newUser = userAcc.copyWith(
//               uid: jsonDecode(res.body)['user']['_id'],
//               token: jsonDecode(res.body)['token'],
//             );
//             errorModel = ErrorModel(error: null, data: newUser);
//             break;
//         }
//       }
      
//     } catch (e) {
//       errorModel = ErrorModel(
//         error: e.toString(),
//         data: null,
//       );
//     }
//    return errorModel;
//   }
  
// }

final AuthRepositoryProvider = Provider(
  (ref) => AuthRepository(
    googleSignIn: GoogleSignIn(),
    client: Client(),

  ),
);

final userProvider = StateProvider<UserModel?>((ref) => null);

class AuthRepository {
  final GoogleSignIn _googleSignIn;
  final Client _client;

  AuthRepository({
    required GoogleSignIn googleSignIn,
    required Client client,

  })  : _googleSignIn = googleSignIn,
        _client = client;


  Future<ErrorModel> signInWithGoogle() async {
    ErrorModel error = ErrorModel(
      error: 'Some unexpected error occurred.',
      data: null,
    );
    try {
      final user = await _googleSignIn.signIn();
      if (user != null) {
        final userAcc = UserModel(
          email: user.email,
          name: user.displayName ?? '',
          // profilePic: user.photoUrl?? '',
          profilePic: "2423",
          uid: '',
          token: '',
        );
      print(userAcc.toJson());
        var res = await _client.post(Uri.parse('$host/api/signup'), body: userAcc.toJson(), headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        });

        switch (res.statusCode) {
          case 200:
            final newUser = userAcc.copyWith(
              uid: jsonDecode(res.body)['user']['_id'],
              token: jsonDecode(res.body)['token'],
            );
            error = ErrorModel(error: null, data: newUser);
            break;
          case 500:
            error = ErrorModel(error: res.body, data:null);
        }
      }
    } catch (e) {
      error = ErrorModel(
        error: e.toString(),
        data: null,
      );
    }
    return error;
  }
}