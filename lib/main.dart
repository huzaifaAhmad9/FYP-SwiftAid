import 'package:swift_aid/bloc/hospital_auth_bloc/hospital_auth_bloc.dart';
import 'package:swift_aid/Screens/Splash_Screen/main_splash.dart';
import 'package:swift_aid/bloc/user_bloc/file_upload_cubit.dart';
import 'package:swift_aid/bloc/auth_bloc/auth_bloc.dart';
import 'package:swift_aid/bloc/user_bloc/user_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(),
      ),
      BlocProvider<UserBloc>(create: (_) => UserBloc()),
      BlocProvider(
        create: (context) => FileUploadCubit(),
      ),
      BlocProvider(create: (_) => HospitalAuthBloc()),
    ],
    child: const MyApp(),
  ));
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
