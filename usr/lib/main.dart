import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/welcome_screen.dart';
import 'screens/login_screen.dart';
import 'screens/student/student_home_screen.dart';
import 'screens/parent/parent_home_screen.dart';
import 'screens/teacher/teacher_home_screen.dart';
import 'utils/theme.dart';

void main() {
  runApp(const EduQatApp());
}

class EduQatApp extends StatelessWidget {
  const EduQatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EDUQAT - التعليم في قطر',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/welcome': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/student-home': (context) => const StudentHomeScreen(),
        '/parent-home': (context) => const ParentHomeScreen(),
        '/teacher-home': (context) => const TeacherHomeScreen(),
      },
    );
  }
}
