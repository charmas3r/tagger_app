// import 'dart:developer';
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:tagger_app/utils/logging_utils.dart';
//
// import '../../../../resources/colors.dart';
// import '../../../../main.presentation/navigation/model/routes.dart';
// import '../domain/firebase_login_service.dart';
//
// class FacebookSignIn extends StatefulWidget {
//   const FacebookSignIn({Key? key}) : super(key: key);
//
//   @override
//   _FacebookSignInState createState() => _FacebookSignInState();
// }
//
// class _FacebookSignInState extends State<FacebookSignIn> {
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
//         icon: Image.asset("assets/images/facebook.webp"),
//         onPressed: () async {
//           setState(() {
//             isLoading = true;
//           });
//           FirebaseLoginService service = FirebaseLoginService();
//           try {
//             await service.signInWithFacebook();
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
//         label: const Text("fake"),
//         // label: const Text(
//         //   Strings.loginWithFacebook,
//         //   style: TextStyle(
//         //       color: Colors.white,
//         //       fontWeight: FontWeight.bold,
//         //   ),
//         // ),
//         style: ButtonStyle(
//             backgroundColor: MaterialStateProperty.all<Color>(facebookRealBlue),
//             side: MaterialStateProperty.all<BorderSide>(BorderSide.none)),
//       ),
//     ) : const CircularProgressIndicator();
//   }
// }
