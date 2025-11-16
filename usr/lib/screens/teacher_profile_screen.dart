import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/theme.dart';

class TeacherProfileScreen extends StatefulWidget {
  const TeacherProfileScreen({super.key});

  @override
  State<TeacherProfileScreen> createState() => _TeacherProfileScreenState();
}

class _TeacherProfileScreenState extends State<TeacherProfileScreen> {
  // Mock teacher data - will be replaced with Supabase data
  final Map<String, dynamic> _teacherData = {
    'firstName': 'سارة',
    'lastName': 'أحمد',
    'email': 'sara.ahmed@example.com',
    'phone': '+974 1234 5678',
    'degree': 'ماجستير في الرياضيات',
    'specialization': 'الرياضيات والفيزياء',
    'experience': '8',
    'bio': 'مدرسة رياضيات معتمدة من وزارة التعليم في قطر، خبرة 8 سنوات في تدريس الرياضيات للمرحلة الثانوية.',
    'profileImage': null, // Will be URL from Supabase storage
    'rating': 4.6,
    'totalRatings': 127,
    'points': 2450,
    'status': 'approved', // pending/approved/rejected
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'الملف الشخصي',
          style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // TODO: Navigate to edit profile
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'تعديل الملف الشخصي قريباً',
                    style: GoogleFonts.tajawal(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Header with Rating
            Container(
              padding: const EdgeInsets.all(24),
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
              child: Column(
                children: [
                  // Profile Image
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 20,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: _teacherData['profileImage'] != null
                        ? ClipOval(
                            child: Image.network(
                              _teacherData['profileImage'],
                              fit: BoxFit.cover,
                            ),
                          )
                        : Icon(
                            Icons.person,
                            size: 60,
                            color: AppTheme.primaryMaroon,
                          ),
                  ),
                  const SizedBox(height: 16),

                  // Name
                  Text(
                    '${_teacherData['firstName']} ${_teacherData['lastName']}',
                    style: GoogleFonts.cairo(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.star, color: AppTheme.secondaryGold, size: 24),
                      const SizedBox(width: 8),
                      Text(
                        '${_teacherData['rating']}',
                        style: GoogleFonts.cairo(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.secondaryGold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '(${_teacherData['totalRatings']} تقييم)',
                        style: GoogleFonts.tajawal(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Points
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppTheme.secondaryGold,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${_teacherData['points']} نقطة',
                      style: GoogleFonts.cairo(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Status Banner (if pending)
            if (_teacherData['status'] == 'pending')
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                color: Colors.orange.shade100,
                child: Row(
                  children: [
                    Icon(Icons.pending, color: Colors.orange.shade700),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'حسابك قيد المراجعة من قبل إدارة التطبيق',
                        style: GoogleFonts.tajawal(
                          color: Colors.orange.shade800,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            // Personal Information
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'المعلومات الشخصية',
                    style: GoogleFonts.cairo(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryMaroon,
                    ),
                  ),
                  const SizedBox(height: 16),

                  _buildInfoCard(
                    icon: Icons.email,
                    title: 'البريد الإلكتروني',
                    value: _teacherData['email'],
                  ),
                  const SizedBox(height: 12),

                  _buildInfoCard(
                    icon: Icons.phone,
                    title: 'رقم الهاتف',
                    value: _teacherData['phone'],
                  ),
                  const SizedBox(height: 24),

                  // Academic Information
                  Text(
                    'المعلومات الأكاديمية',
                    style: GoogleFonts.cairo(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryMaroon,
                    ),
                  ),
                  const SizedBox(height: 16),

                  _buildInfoCard(
                    icon: Icons.school,
                    title: 'الشهادة',
                    value: _teacherData['degree'],
                  ),
                  const SizedBox(height: 12),

                  _buildInfoCard(
                    icon: Icons.subject,
                    title: 'التخصص',
                    value: _teacherData['specialization'],
                  ),
                  const SizedBox(height: 12),

                  _buildInfoCard(
                    icon: Icons.work,
                    title: 'سنوات الخبرة',
                    value: '${_teacherData['experience']} سنوات',
                  ),
                  const SizedBox(height: 24),

                  // Bio
                  if (_teacherData['bio']?.isNotEmpty ?? false) ...[
                    Text(
                      'نبذة عني',
                      style: GoogleFonts.cairo(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryMaroon,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          _teacherData['bio'],
                          style: GoogleFonts.tajawal(
                            fontSize: 16,
                            height: 1.6,
                            color: AppTheme.textSecondary,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.primaryMaroon.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: AppTheme.primaryMaroon,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.tajawal(
                      fontSize: 14,
                      color: AppTheme.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: GoogleFonts.tajawal(
                      fontSize: 16,
                      color: AppTheme.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}