import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/theme.dart';
import 'teacher_registration_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String _userType = 'student'; // Default user type

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    // Mock login logic - replace with Supabase auth later
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        switch (_userType) {
          case 'student':
            Navigator.pushReplacementNamed(context, '/student-home');
            break;
          case 'teacher':
            Navigator.pushReplacementNamed(context, '/teacher-home');
            break;
          case 'parent':
            Navigator.pushReplacementNamed(context, '/parent-home');
            break;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              AppTheme.primaryMaroon.withOpacity(0.03),
              AppTheme.secondaryGold.withOpacity(0.05),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo and App Name
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppTheme.primaryMaroon,
                            AppTheme.primaryMaroon.withOpacity(0.8),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.primaryMaroon.withOpacity(0.3),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.school_rounded,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'EDUQAT',
                      style: GoogleFonts.cairo(
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryMaroon,
                        letterSpacing: 1.5,
                        shadows: [
                          Shadow(
                            color: AppTheme.secondaryGold.withOpacity(0.5),
                            blurRadius: 10,
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'منصة التعليم القطرية',
                      style: GoogleFonts.tajawal(
                        fontSize: 18,
                        color: AppTheme.secondaryGold,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // User Type Selector
                    SegmentedButton<String>(
                      segments: const [
                        ButtonSegment(
                          value: 'student',
                          label: Text('طالب'),
                          icon: Icon(Icons.school),
                        ),
                        ButtonSegment(
                          value: 'teacher',
                          label: Text('مدرس'),
                          icon: Icon(Icons.person_pin_rounded),
                        ),
                        ButtonSegment(
                          value: 'parent',
                          label: Text('ولي أمر'),
                          icon: Icon(Icons.family_restroom),
                        ),
                      ],
                      selected: {_userType},
                      onSelectionChanged: (Set<String> newSelection) {
                        setState(() {
                          _userType = newSelection.first;
                        });
                      },
                      style: SegmentedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppTheme.textSecondary,
                        selectedForegroundColor: Colors.white,
                        selectedBackgroundColor: AppTheme.primaryMaroon,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Email Field
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'البريد الإلكتروني',
                        labelStyle: GoogleFonts.tajawal(
                          fontWeight: FontWeight.w500,
                        ),
                        prefixIcon: const Icon(Icons.email_rounded),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'البريد الإلكتروني مطلوب';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value!)) {
                          return 'البريد الإلكتروني غير صحيح';
                        }
                        return null;
                      },
                      textDirection: TextDirection.ltr,
                      style: GoogleFonts.roboto(),
                    ),
                    const SizedBox(height: 20),

                    // Password Field
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'كلمة المرور',
                        labelStyle: GoogleFonts.tajawal(
                          fontWeight: FontWeight.w500,
                        ),
                        prefixIcon: const Icon(Icons.lock_rounded),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'كلمة المرور مطلوبة';
                        }
                        return null;
                      },
                      textDirection: TextDirection.ltr,
                      style: GoogleFonts.roboto(),
                    ),
                    const SizedBox(height: 16),

                    // Forgot Password
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () {
                          // TODO: Implement forgot password
                        },
                        child: Text(
                          'نسيت كلمة المرور؟',
                          style: GoogleFonts.tajawal(
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Login Button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton.icon(
                        onPressed: _isLoading ? null : _handleLogin,
                        icon: _isLoading
                            ? const SizedBox.shrink()
                            : const Icon(Icons.login_rounded),
                        label: _isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : Text(
                                'تسجيل الدخول',
                                style: GoogleFonts.cairo(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                        style: ElevatedButton.styleFrom(
                          elevation: 8,
                          shadowColor: AppTheme.primaryMaroon.withOpacity(0.5),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Create account
                    if (_userType == 'teacher')
                      TextButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const TeacherRegistrationScreen(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.person_add_rounded),
                        label: Text(
                          'إنشاء حساب مدرس جديد',
                          style: GoogleFonts.cairo(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
