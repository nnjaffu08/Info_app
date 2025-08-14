import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_info_app/presentation/blocs/personal_info_bloc.dart';

import 'di/injection.dart' as di;
import 'presentation/pages/home_page.dart';
import 'presentation/pages/profile_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Info App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Colors.grey[100],
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => BlocProvider(
              create: (context) => di.locator<PersonalInfoBloc>(),
              child: const HomePage(),
            ),
        '/profile': (context) => BlocProvider(
              create: (context) => di.locator<PersonalInfoBloc>()
                ..add(const LoadPersonalInfoEvent('user_id')),
              child: const ProfilePage(),
            ),
      },
    );
  }
}
