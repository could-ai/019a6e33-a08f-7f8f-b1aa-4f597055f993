import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/theme.dart';
import '../teacher_profile_screen.dart';

class TeacherHomeScreen extends StatefulWidget {
  const TeacherHomeScreen({super.key});

  @override
  State<TeacherHomeScreen> createState() => _TeacherHomeScreenState();
}

class _TeacherHomeScreenState extends State<TeacherHomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: AppTheme.primaryMaroon,
        unselectedItemColor: AppTheme.textSecondary,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_rounded),
            label: 'لوحة التحكم',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_rounded),
            label: 'جدولي',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wallet_rounded),
            label: 'الأرباح',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'حسابي',
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return _buildDashboardTab();
      case 1:
        return _buildScheduleTab();
      case 2:
        return _buildEarningsTab();
      case 3:
        return _buildProfileTab();
      default:
        return _buildDashboardTab();
    }
  }

  Widget _buildDashboardTab() {
    return Scaffold(
      appBar: AppBar(
        title: Text('لوحة التحكم', style: GoogleFonts.cairo(fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: Text(
          'سيتم عرض الإحصائيات هنا',
          style: GoogleFonts.cairo(fontSize: 18, color: AppTheme.textSecondary),
        ),
      ),
    );
  }

  Widget _buildScheduleTab() {
     return Scaffold(
      appBar: AppBar(
        title: Text('جدول الحصص', style: GoogleFonts.cairo(fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: Text(
          'سيتم عرض الحصص القادمة والسابقة هنا',
          style: GoogleFonts.cairo(fontSize: 18, color: AppTheme.textSecondary),
        ),
      ),
    );
  }

    Widget _buildEarningsTab() {
     return Scaffold(
      appBar: AppBar(
        title: Text('الأرباح والتقارير المالية', style: GoogleFonts.cairo(fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: Text(
          'سيتم عرض التقارير المالية هنا',
          style: GoogleFonts.cairo(fontSize: 18, color: AppTheme.textSecondary),
        ),
      ),
    );
  }

  Widget _buildProfileTab() {
    return const TeacherProfileScreen();
  }
}
