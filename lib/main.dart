import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tagger_app/resources/theme.dart';

import 'connectivity/logic/cubit/internet_cubit.dart';
import 'main/logic/simple_bloc_observer.dart';
import 'main/presentation/navigation/router/AppRouter.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp(
    appRouter: AppRouter(),
    connectivity: Connectivity(),
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  final Connectivity connectivity;

  const MyApp({
    Key? key,
    required this.appRouter,
    required this.connectivity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetCubit>(
          create: (context) => InternetCubit(connectivity: connectivity),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: PlantTheme.lightTheme,
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
    );
  }
}

// Previous login page
// @override
// Widget build(BuildContext context) {
//   return MaterialApp(
//     debugShowCheckedModeBanner: false,
//     title: Strings.loginPageTitle,
//     initialRoute: Routes.signInRoute,
//     routes: Navigate.routes,
//     theme: ThemeData(
//       // Define the default brightness and colors.
//       brightness: Brightness.dark,
//       primaryColor: Colors.lightBlue[800],
//
//       // Define the default font family.
//       fontFamily: 'Georgia',
//
//       // Define the default `TextTheme`. Use this to specify the default
//       // text styling for headlines, titles, bodies of text, and more.
//       textTheme: const TextTheme(
//         headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
//         headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
//         bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
//       ),
//     ),
//   );
// }
