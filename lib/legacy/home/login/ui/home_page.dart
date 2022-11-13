// import 'package:flutter/material.dart';
//
// import '../../../../resources/strings.dart';
// import 'google_sign_in.dart';
//
// class HomePage extends StatelessWidget {
//   const HomePage({Key? key}) : super(key: key);
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
//                         text: Strings.homePageTitle,
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 30.0,
//                         )),
//                   ])),
//               Padding(padding: EdgeInsets.only(bottom: size.height * 0.02)),
//             ])));
//   }
// }