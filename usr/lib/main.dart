import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/student/student_home_screen.dart';
import 'screens/parent/parent_home_screen.dart';
import 'screens/teacher/teacher_home_screen.dart';
import 'utils/theme.dart';

void main() {
  runApp(const QatarEducationApp());
}

class QatarEducationApp extends StatelessWidget {
  const QatarEducationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'تطبيق الحجز التعليمي',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/student-home': (context) => const StudentHomeScreen(),
        '/parent-home': (context) => const ParentHomeScreen(),
        '/teacher-home': (context) => const TeacherHomeScreen(),
      },
    );
  }
}
