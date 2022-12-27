import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tagger_app/plants/presentation/bloc/plant_bloc.dart';
import 'package:tagger_app/resources/colors.dart';
import 'package:tagger_app/resources/theme.dart';
import 'package:tagger_app/soil/presentation/bloc/soil_bloc.dart';

import 'core/bloc/simple_bloc_observer.dart';
import 'core/di/injector.dart';
import 'main/presentation/navigation/router/AppRouter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  await initDependencies();
  runApp(MyApp(
    appRouter: AppRouter(),
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;

  const MyApp({
    Key? key,
    required this.appRouter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MultiBlocProvider(
      providers: [
        BlocProvider<PlantBloc>(
          create: (_) =>
          injector()
            ..add(const FetchPlantsRequested()),
        ),
        BlocProvider<SoilBloc>(
          create: (_) =>
          injector()
            ..add(const FetchSoilBlendsRequested()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
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
