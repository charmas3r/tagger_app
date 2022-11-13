// import 'package:flutter/material.dart';
//
// import '../../../../resources/strings.dart';
// import 'facebook_sign_in.dart';
// import 'google_sign_in.dart';
//
// class SignInPage extends StatelessWidget {
//   const SignInPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery
//         .of(context)
//         .size;
//     return Scaffold(
//         resizeToAvoidBottomInset: false,
//         body: Center(
//             child:
//             Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//               RichText(
//                   textAlign: TextAlign.center,
//                   text: const TextSpan(children: <TextSpan>[
//                     TextSpan(
//                         text: Strings.plantAppTitle,
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 30.0,
//                         )),
//                   ])),
//               SizedBox(height: size.height * 0.01),
//               const GoogleSignIn(),
//               const FacebookSignIn(),
//               Padding(padding: EdgeInsets.only(bottom: size.height * 0.02)),
//             ])));
//   }
// }