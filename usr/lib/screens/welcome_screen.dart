import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/theme.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> _pages = [
    {
      'icon': Icons.school_rounded,
      'title': 'مرحباً بك في EDUQAT',
      'description': 'منصة تعليمية متكاملة تربط الطلاب بأفضل المدرسين في قطر',
      'gradient': [Color(0xFF8B1538), Color(0xFFA91D47)],
    },
    {
      'icon': Icons.calendar_month_rounded,
      'title': 'احجز حصتك بسهولة',
      'description': 'اختر المادة والمنهج والوقت المناسب لك واحجز حصتك في ثوانٍ',
      'gradient': [Color(0xFF2E7D32), Color(0xFF43A047)],
    },
    {
      'icon': Icons.star_rounded,
      'title': 'قيّم واكسب النقاط',
      'description': 'قيّم المدرسين بعد كل حصة واجمع النقاط للحصول على حصص مجانية',
      'gradient': [Color(0xFFD4AF37), Color(0xFFFFD700)],
    },
    {
      'icon': Icons.workspace_premium_rounded,
      'title': 'أفضل المدرسين',
      'description': 'مدرسون ذوو خبرة ومؤهلات عالية لضمان أفضل تجربة تعليمية',
      'gradient': [Color(0xFF6A1B9A), Color(0xFF8E24AA)],
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic,
      );
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  void _skipToLogin() {
    Navigator.pushReplacementNamed(context, '/login');
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
          child: Column(
            children: [
              // Header with logo and skip button
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Logo
                    Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppTheme.primaryMaroon,
                                AppTheme.primaryMaroon.withOpacity(0.8),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: AppTheme.primaryMaroon.withOpacity(0.3),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.school_rounded,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'EDUQAT',
                          style: GoogleFonts.cairo(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryMaroon,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                    // Skip button
                    TextButton(
                      onPressed: _skipToLogin,
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        backgroundColor: AppTheme.primaryMaroon.withOpacity(0.1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'تخطي',
                        style: GoogleFonts.cairo(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.primaryMaroon,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // PageView
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemCount: _pages.length,
                  itemBuilder: (context, index) {
                    final page = _pages[index];
                    return Padding(
                      padding: const EdgeInsets.all(40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Icon with gradient background
                          Container(
                            width: 180,
                            height: 180,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: page['gradient'] as List<Color>,
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: (page['gradient'] as List<Color>)[0].withOpacity(0.4),
                                  blurRadius: 30,
                                  spreadRadius: 5,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Icon(
                              page['icon'],
                              size: 90,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 50),
                          // Title with beautiful font
                          Text(
                            page['title'],
                            style: GoogleFonts.cairo(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primaryMaroon,
                              height: 1.4,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          // Description with elegant font
                          Text(
                            page['description'],
                            style: GoogleFonts.tajawal(
                              fontSize: 18,
                              color: AppTheme.textSecondary,
                              height: 1.8,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              // Page indicators
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _pages.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    width: _currentPage == index ? 40 : 12,
                    height: 12,
                    decoration: BoxDecoration(
                      gradient: _currentPage == index
                          ? LinearGradient(
                              colors: [
                                AppTheme.primaryMaroon,
                                AppTheme.secondaryGold,
                              ],
                            )
                          : null,
                      color: _currentPage == index
                          ? null
                          : AppTheme.primaryMaroon.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              // Next/Start button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: _nextPage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryMaroon,
                      foregroundColor: Colors.white,
                      elevation: 8,
                      shadowColor: AppTheme.primaryMaroon.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _currentPage == _pages.length - 1 ? 'ابدأ الآن' : 'التالي',
                          style: GoogleFonts.cairo(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          _currentPage == _pages.length - 1
                              ? Icons.rocket_launch_rounded
                              : Icons.arrow_forward_rounded,
                          size: 24,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
