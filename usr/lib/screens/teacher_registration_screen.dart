import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/theme.dart';

class TeacherRegistrationScreen extends StatefulWidget {
  const TeacherRegistrationScreen({super.key});

  @override
  State<TeacherRegistrationScreen> createState() => _TeacherRegistrationScreenState();
}

class _TeacherRegistrationScreenState extends State<TeacherRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _degreeController = TextEditingController();
  final _specializationController = TextEditingController();
  final _experienceController = TextEditingController();
  final _bioController = TextEditingController();

  String? _profileImageUrl;
  bool _isLoading = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _degreeController.dispose();
    _specializationController.dispose();
    _experienceController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  Future<void> _pickProfileImage() async {
    // TODO: Implement image picker with Supabase storage
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'اختيار الصورة الشخصية قريباً',
          style: GoogleFonts.tajawal(),
        ),
      ),
    );
  }

  void _handleRegistration() async {
    if (!_formKey.currentState!.validate()) return;

    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'كلمات المرور غير متطابقة',
            style: GoogleFonts.tajawal(),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // TODO: Implement registration with Supabase
      // Create teacher profile with pending status

      if (mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: Text(
              'تم التسجيل بنجاح',
              style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
            ),
            content: Text(
              'حسابك قيد المراجعة من قبل إدارة التطبيق. سيتم إشعارك عند الموافقة.',
              style: GoogleFonts.tajawal(),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close dialog
                  Navigator.pop(context); // Back to login
                },
                child: Text(
                  'موافق',
                  style: GoogleFonts.cairo(),
                ),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'حدث خطأ أثناء التسجيل',
              style: GoogleFonts.tajawal(),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'إنشاء حساب مدرس',
          style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              AppTheme.primaryMaroon.withOpacity(0.02),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Profile Image Section
                  Stack(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
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
                              color: AppTheme.primaryMaroon.withOpacity(0.3),
                              blurRadius: 20,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: _profileImageUrl != null
                            ? ClipOval(
                                child: Image.network(
                                  _profileImageUrl!,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : const Icon(
                                Icons.person,
                                size: 60,
                                color: Colors.white,
                              ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppTheme.secondaryGold,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 3),
                          ),
                          child: InkWell(
                            onTap: _pickProfileImage,
                            child: const Icon(
                              Icons.camera_alt,
                              color: AppTheme.textPrimary,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Personal Information Section
                  Text(
                    'المعلومات الشخصية',
                    style: GoogleFonts.cairo(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryMaroon,
                    ),
                  ),
                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _firstNameController,
                          decoration: InputDecoration(
                            labelText: 'الاسم الأول',
                            labelStyle: GoogleFonts.tajawal(
                              fontWeight: FontWeight.w500,
                            ),
                            prefixIcon: const Icon(Icons.person),
                          ),
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'الاسم الأول مطلوب';
                            }
                            return null;
                          },
                          style: GoogleFonts.tajawal(),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          controller: _lastNameController,
                          decoration: InputDecoration(
                            labelText: 'اللقب العائلي',
                            labelStyle: GoogleFonts.tajawal(
                              fontWeight: FontWeight.w500,
                            ),
                            prefixIcon: const Icon(Icons.person_outline),
                          ),
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'اللقب العائلي مطلوب';
                            }
                            return null;
                          },
                          style: GoogleFonts.tajawal(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'البريد الإلكتروني',
                      labelStyle: GoogleFonts.tajawal(
                        fontWeight: FontWeight.w500,
                      ),
                      prefixIcon: const Icon(Icons.email),
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
                  const SizedBox(height: 16),

                  TextFormField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      labelText: 'رقم الهاتف',
                      labelStyle: GoogleFonts.tajawal(
                        fontWeight: FontWeight.w500,
                      ),
                      prefixIcon: const Icon(Icons.phone),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'رقم الهاتف مطلوب';
                      }
                      return null;
                    },
                    textDirection: TextDirection.ltr,
                    style: GoogleFonts.roboto(),
                  ),
                  const SizedBox(height: 32),

                  // Academic Information Section
                  Text(
                    'المعلومات الأكاديمية',
                    style: GoogleFonts.cairo(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryMaroon,
                    ),
                  ),
                  const SizedBox(height: 20),

                  TextFormField(
                    controller: _degreeController,
                    decoration: InputDecoration(
                      labelText: 'الشهادة',
                      labelStyle: GoogleFonts.tajawal(
                        fontWeight: FontWeight.w500,
                      ),
                      prefixIcon: const Icon(Icons.school),
                      hintText: 'مثال: بكالوريوس، ماجستير، دكتوراه',
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'الشهادة مطلوبة';
                      }
                      return null;
                    },
                    style: GoogleFonts.tajawal(),
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    controller: _specializationController,
                    decoration: InputDecoration(
                      labelText: 'التخصص',
                      labelStyle: GoogleFonts.tajawal(
                        fontWeight: FontWeight.w500,
                      ),
                      prefixIcon: const Icon(Icons.subject),
                      hintText: 'مثال: الرياضيات، الفيزياء، اللغة العربية',
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'التخصص مطلوب';
                      }
                      return null;
                    },
                    style: GoogleFonts.tajawal(),
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    controller: _experienceController,
                    decoration: InputDecoration(
                      labelText: 'سنوات الخبرة',
                      labelStyle: GoogleFonts.tajawal(
                        fontWeight: FontWeight.w500,
                      ),
                      prefixIcon: const Icon(Icons.work),
                      hintText: 'مثال: 5 سنوات',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'سنوات الخبرة مطلوبة';
                      }
                      return null;
                    },
                    style: GoogleFonts.tajawal(),
                  ),
                  const SizedBox(height: 32),

                  // Password Section
                  Text(
                    'إعداد كلمة المرور',
                    style: GoogleFonts.cairo(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryMaroon,
                    ),
                  ),
                  const SizedBox(height: 20),

                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'كلمة المرور',
                      labelStyle: GoogleFonts.tajawal(
                        fontWeight: FontWeight.w500,
                      ),
                      prefixIcon: const Icon(Icons.lock),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'كلمة المرور مطلوبة';
                      }
                      if (value!.length < 6) {
                        return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
                      }
                      return null;
                    },
                    textDirection: TextDirection.ltr,
                    style: GoogleFonts.roboto(),
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    controller: _confirmPasswordController,
                    decoration: InputDecoration(
                      labelText: 'تأكيد كلمة المرور',
                      labelStyle: GoogleFonts.tajawal(
                        fontWeight: FontWeight.w500,
                      ),
                      prefixIcon: const Icon(Icons.lock_outline),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'تأكيد كلمة المرور مطلوب';
                      }
                      return null;
                    },
                    textDirection: TextDirection.ltr,
                    style: GoogleFonts.roboto(),
                  ),
                  const SizedBox(height: 32),

                  // Bio Section
                  TextFormField(
                    controller: _bioController,
                    decoration: InputDecoration(
                      labelText: 'نبذة عنك (اختياري)',
                      labelStyle: GoogleFonts.tajawal(
                        fontWeight: FontWeight.w500,
                      ),
                      prefixIcon: const Icon(Icons.description),
                      hintText: 'اكتب نبذة قصيرة عن خبراتك التعليمية...',
                    ),
                    maxLines: 3,
                    style: GoogleFonts.tajawal(),
                  ),
                  const SizedBox(height: 40),

                  // Register Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _handleRegistration,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryMaroon,
                        foregroundColor: Colors.white,
                        elevation: 6,
                        shadowColor: AppTheme.primaryMaroon.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'إنشاء الحساب',
                                  style: GoogleFonts.cairo(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Icon(Icons.person_add, size: 20),
                              ],
                            ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}