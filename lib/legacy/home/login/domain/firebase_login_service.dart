// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:tagger_app/utils/logging_utils.dart';
//
// class FirebaseLoginService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final GoogleSignIn _googleSignIn = GoogleSignIn();
//   final FacebookAuth _facebookAuth = FacebookAuth.instance;
//
//   Future<void> signInWithGoogle() async {
//     try {
//       final GoogleSignInAccount? googleSignInAccount =
//           await _googleSignIn.signIn();
//       final GoogleSignInAuthentication googleSignInAuthentication =
//           await googleSignInAccount!.authentication;
//       final AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleSignInAuthentication.accessToken,
//         idToken: googleSignInAuthentication.idToken,
//       );
//       await _auth.signInWithCredential(credential);
//     } on FirebaseAuthException catch (e) {
//       log(e.message);
//       rethrow;
//     }
//   }
//
//   Future<void> signInWithFacebook() async {
//     try {
//       final LoginResult loginResult = await _facebookAuth.login();
//       final OAuthCredential facebookAuthCredential =
//           FacebookAuthProvider.credential(loginResult.accessToken!.token);
//       await _auth.signInWithCredential(facebookAuthCredential);
//     } on FirebaseAuthException catch (e) {
//       log(e.message);
//       rethrow;
//     } catch (e) {
//       log(e.toString());
//     }
//   }
//
//   Future<void> signOutFromGoogle() async {
//     await _googleSignIn.signOut();
//     await _auth.signOut();
//   }
//
//   Future<void> signOutFromFacebook() async {
//     await _facebookAuth.logOut();
//     await _auth.signOut();
//   }
// }
