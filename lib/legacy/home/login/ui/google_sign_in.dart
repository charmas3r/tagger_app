// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:tagger_app/main.presentation/navigation/model/routes.dart';
// import 'package:tagger_app/resources/strings.dart';
// import 'package:tagger_app/utils/logging_utils.dart';
//
// import '../domain/firebase_login_service.dart';
//
// class GoogleSignIn extends StatefulWidget {
//   const GoogleSignIn({Key? key}) : super(key: key);
//
//   @override
//   _GoogleSignInState createState() => _GoogleSignInState();
// }
//
// class _GoogleSignInState extends State<GoogleSignIn> {
//   bool isLoading = false;
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery
//         .of(context)
//         .size;
//     return !isLoading ? SizedBox(
//       width: size.width * 0.8,
//       child: OutlinedButton.icon(
//         icon: Image.asset("assets/images/superg.webp"),
//         onPressed: () async {
//           setState(() {
//             isLoading = true;
//           });
//           FirebaseLoginService service = FirebaseLoginService();
//           try {
//             await service.signInWithGoogle();
//             Navigator.pushNamedAndRemoveUntil(
//                 context, Routes.mainRoute, (route) => false);
//           } catch (e) {
//             if (e is FirebaseAuthException) {
//               log(e.message);
//             }
//           }
//           setState(() {
//             isLoading = false;
//           });
//         },
//         label: const Text(
//           Strings.loginWithGoogle,
//           style: TextStyle(
//               fontWeight:
//               FontWeight.bold
//           ),
//         ),
//         style: ButtonStyle(
//             side: MaterialStateProperty.all<BorderSide>(BorderSide.none)),
//       ),
//     ) : const CircularProgressIndicator();
//   }
// }