import 'package:swift_aid/Screens/Splash_Screen/On_Boarding/on_boarding_main.dart';
import 'package:swift_aid/Screens/Splash_Screen/main_splash.dart';
import 'package:swift_aid/Screens/Main_Screens/main_home.dart';
import 'package:swift_aid/bloc/auth_bloc/auth_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(BlocProvider(create: (context) => AuthBloc(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainSplash(),
    );
  }
}
