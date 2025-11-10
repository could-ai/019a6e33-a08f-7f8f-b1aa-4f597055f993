import 'package:flutter/material.dart';
import '../utils/theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _selectedUserType = 'student';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    // TODO: Implement actual authentication with Supabase
    // For now, navigate based on user type
    String route;
    switch (_selectedUserType) {
      case 'student':
        route = '/student-home';
        break;
      case 'parent':
        route = '/parent-home';
        break;
      case 'teacher':
        route = '/teacher-home';
        break;
      default:
        route = '/student-home';
    }
    Navigator.pushReplacementNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppTheme.primaryMaroon,
              AppTheme.primaryMaroon.withOpacity(0.8),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Logo placeholder
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: AppTheme.primaryMaroon.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.school,
                          size: 50,
                          color: AppTheme.primaryMaroon,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'تطبيق الحجز التعليمي',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              color: AppTheme.primaryMaroon,
                              fontWeight: FontWeight.bold,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'قطر',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppTheme.secondaryGold,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const SizedBox(height: 32),
                      // User type selector
                      SegmentedButton<String>(
                        segments: const [
                          ButtonSegment(
                            value: 'student',
                            label: Text('طالب'),
                            icon: Icon(Icons.person),
                          ),
                          ButtonSegment(
                            value: 'parent',
                            label: Text('ولي أمر'),
                            icon: Icon(Icons.family_restroom),
                          ),
                          ButtonSegment(
                            value: 'teacher',
                            label: Text('مدرس'),
                            icon: Icon(Icons.work),
                          ),
                        ],
                        selected: {_selectedUserType},
                        onSelectionChanged: (Set<String> newSelection) {
                          setState(() {
                            _selectedUserType = newSelection.first;
                          });
                        },
                      ),
                      const SizedBox(height: 24),
                      // Email field
                      TextField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'البريد الإلكتروني',
                          prefixIcon: Icon(Icons.email),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        textDirection: TextDirection.ltr,
                      ),
                      const SizedBox(height: 16),
                      // Password field
                      TextField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          labelText: 'كلمة المرور',
                          prefixIcon: Icon(Icons.lock),
                        ),
                        obscureText: true,
                        textDirection: TextDirection.ltr,
                      ),
                      const SizedBox(height: 24),
                      // Login button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _handleLogin,
                          child: const Text(
                            'تسجيل الدخول',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Forgot password
                      TextButton(
                        onPressed: () {
                          // TODO: Implement forgot password
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('استعادة كلمة المرور قريباً')),
                          );
                        },
                        child: const Text('نسيت كلمة المرور؟'),
                      ),
                      const Divider(height: 32),
                      // Create account
                      TextButton(
                        onPressed: () {
                          // TODO: Navigate to registration screen
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('إنشاء حساب جديد قريباً')),
                          );
                        },
                        child: const Text(
                          'إنشاء حساب جديد',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
