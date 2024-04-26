import 'package:amanah/bloc_obs.dart';
import 'package:amanah/features/home/presentation/screens/splash_screen.dart';
import 'package:amanah/firebase_options.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  Bloc.observer = MyBlocObserver();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      useInheritedMediaQuery: true,
      builder: (BuildContext context, Widget? child) => const MaterialApp(
        title: 'Amaneh App',
        
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
