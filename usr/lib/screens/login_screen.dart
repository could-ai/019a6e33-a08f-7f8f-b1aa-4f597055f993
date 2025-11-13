import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              AppTheme.primaryMaroon.withOpacity(0.05),
              AppTheme.secondaryGold.withOpacity(0.08),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Card(
                elevation: 12,
                shadowColor: AppTheme.primaryMaroon.withOpacity(0.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white,
                        AppTheme.secondaryGold.withOpacity(0.02),
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Logo
                        Container(
                          width: 110,
                          height: 110,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppTheme.primaryMaroon,
                                AppTheme.primaryMaroon.withOpacity(0.8),
                              ],
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppTheme.primaryMaroon.withOpacity(0.4),
                                blurRadius: 20,
                                spreadRadius: 2,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.school_rounded,
                            size: 55,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 24),
                        // App Name
                        Text(
                          'EDUQAT',
                          style: GoogleFonts.cairo(
                            fontSize: 38,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryMaroon,
                            letterSpacing: 1.5,
                            shadows: [
                              Shadow(
                                color: AppTheme.secondaryGold.withOpacity(0.3),
                                offset: const Offset(2, 2),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'منصة التعليم القطرية',
                          style: GoogleFonts.tajawal(
                            fontSize: 16,
                            color: AppTheme.secondaryGold,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 40),
                        // User type selector
                        Text(
                          'اختر نوع الحساب',
                          style: GoogleFonts.cairo(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 16),
                        SegmentedButton<String>(
                          segments: [
                            ButtonSegment(
                              value: 'student',
                              label: Text(
                                'طالب',
                                style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              icon: const Icon(Icons.person),
                            ),
                            ButtonSegment(
                              value: 'parent',
                              label: Text(
                                'ولي أمر',
                                style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              icon: const Icon(Icons.family_restroom),
                            ),
                            ButtonSegment(
                              value: 'teacher',
                              label: Text(
                                'مدرس',
                                style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              icon: const Icon(Icons.work),
                            ),
                          ],
                          selected: {_selectedUserType},
                          onSelectionChanged: (Set<String> newSelection) {
                            setState(() {
                              _selectedUserType = newSelection.first;
                            });
                          },
                        ),
                        const SizedBox(height: 32),
                        // Email field
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'البريد الإلكتروني',
                            labelStyle: GoogleFonts.tajawal(
                              fontWeight: FontWeight.w500,
                            ),
                            prefixIcon: const Icon(Icons.email_rounded),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          textDirection: TextDirection.ltr,
                          style: GoogleFonts.roboto(),
                        ),
                        const SizedBox(height: 20),
                        // Password field
                        TextField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: 'كلمة المرور',
                            labelStyle: GoogleFonts.tajawal(
                              fontWeight: FontWeight.w500,
                            ),
                            prefixIcon: const Icon(Icons.lock_rounded),
                          ),
                          obscureText: true,
                          textDirection: TextDirection.ltr,
                          style: GoogleFonts.roboto(),
                        ),
                        const SizedBox(height: 32),
                        // Login button
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: _handleLogin,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primaryMaroon,
                              foregroundColor: Colors.white,
                              elevation: 6,
                              shadowColor: AppTheme.primaryMaroon.withOpacity(0.5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'تسجيل الدخول',
                                  style: GoogleFonts.cairo(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Icon(Icons.login_rounded, size: 22),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Forgot password
                        TextButton(
                          onPressed: () {
                            // TODO: Implement forgot password
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'استعادة كلمة المرور قريباً',
                                  style: GoogleFonts.tajawal(),
                                ),
                              ),
                            );
                          },
                          child: Text(
                            'نسيت كلمة المرور؟',
                            style: GoogleFonts.tajawal(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.primaryMaroon,
                            ),
                          ),
                        ),
                        const Divider(height: 32),
                        // Create account
                        TextButton.icon(
                          onPressed: () {
                            // TODO: Navigate to registration screen
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'إنشاء حساب جديد قريباً',
                                  style: GoogleFonts.tajawal(),
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.person_add_rounded),
                          label: Text(
                            'إنشاء حساب جديد',
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
        ),
      ),
    );
  }
}
