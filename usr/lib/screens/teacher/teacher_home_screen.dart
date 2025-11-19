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

  // Mock Data for Sessions (بيانات وهمية للحصص)
  final List<Map<String, dynamic>> _sessions = [
    {
      'id': '1',
      'studentName': 'علي حسن',
      'subject': 'الرياضيات',
      'date': '2023-10-25',
      'time': '16:00',
      'duration': '1 ساعة',
      'price': 200,
      'status': 'upcoming', // قادمة
    },
    {
      'id': '2',
      'studentName': 'سارة محمد',
      'subject': 'الفيزياء',
      'date': '2023-10-26',
      'time': '14:30',
      'duration': '1.5 ساعة',
      'price': 300,
      'status': 'upcoming',
    },
    {
      'id': '3',
      'studentName': 'خالد عبدالله',
      'subject': 'الرياضيات',
      'date': '2023-10-23',
      'time': '10:00',
      'duration': '1 ساعة',
      'price': 200,
      'status': 'completed', // مكتملة
    },
    {
      'id': '4',
      'studentName': 'فهد الكواري',
      'subject': 'الكيمياء',
      'date': '2023-10-22',
      'time': '18:00',
      'duration': '2 ساعة',
      'price': 400,
      'status': 'completed',
    },
    {
      'id': '5',
      'studentName': 'نورة آل ثاني',
      'subject': 'الرياضيات',
      'date': '2023-10-20',
      'time': '15:00',
      'duration': '1 ساعة',
      'price': 200,
      'status': 'completed',
    },
  ];

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.dashboard_customize, size: 80, color: AppTheme.primaryMaroon.withOpacity(0.5)),
            const SizedBox(height: 20),
            Text(
              'مرحباً بك يا أستاذ',
              style: GoogleFonts.cairo(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'يمكنك متابعة جدولك وأرباحك من القائمة السفلية',
              style: GoogleFonts.tajawal(fontSize: 16, color: AppTheme.textSecondary),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 1. تبويب جدولي (Schedule Tab)
  // ---------------------------------------------------------------------------
  Widget _buildScheduleTab() {
    // فصل الحصص القادمة عن المكتملة (اختياري، هنا نعرض الكل)
    return Scaffold(
      appBar: AppBar(
        title: Text('جدول الحصص', style: GoogleFonts.cairo(fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          // ملخص عدد الحصص
          Container(
            padding: const EdgeInsets.all(16),
            color: AppTheme.backgroundLight,
            child: Row(
              children: [
                Expanded(
                  child: _buildSummaryCard(
                    title: 'إجمالي الحصص',
                    value: '${_sessions.length}',
                    icon: Icons.class_rounded,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildSummaryCard(
                    title: 'القادمة',
                    value: '${_sessions.where((s) => s['status'] == 'upcoming').length}',
                    icon: Icons.upcoming_rounded,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
          ),
          
          // قائمة الحصص التفصيلية
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _sessions.length,
              itemBuilder: (context, index) {
                final session = _sessions[index];
                final isUpcoming = session['status'] == 'upcoming';
                
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        // الصف العلوي: التاريخ والوقت والحالة
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.calendar_month, size: 16, color: AppTheme.textSecondary),
                                const SizedBox(width: 4),
                                Text(
                                  '${session['date']} | ${session['time']}',
                                  style: GoogleFonts.tajawal(
                                    color: AppTheme.textSecondary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: isUpcoming ? Colors.orange.withOpacity(0.1) : Colors.green.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: isUpcoming ? Colors.orange : Colors.green,
                                ),
                              ),
                              child: Text(
                                isUpcoming ? 'قادمة' : 'مكتملة',
                                style: GoogleFonts.tajawal(
                                  fontSize: 12,
                                  color: isUpcoming ? Colors.orange[800] : Colors.green[800],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(height: 24),
                        
                        // تفاصيل الحصة
                        _buildDetailRow(Icons.person, 'الطالب:', session['studentName']),
                        const SizedBox(height: 8),
                        _buildDetailRow(Icons.menu_book, 'المادة:', session['subject']),
                        const SizedBox(height: 8),
                        _buildDetailRow(Icons.timer, 'المدة:', session['duration']),
                        const SizedBox(height: 8),
                        _buildDetailRow(Icons.monetization_on, 'السعر:', '${session['price']} ر.ق', isPrice: true),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value, {bool isPrice = false}) {
    return Row(
      children: [
        Icon(icon, size: 18, color: isPrice ? AppTheme.primaryMaroon : AppTheme.textSecondary),
        const SizedBox(width: 8),
        Text(
          label,
          style: GoogleFonts.tajawal(color: AppTheme.textSecondary),
        ),
        const SizedBox(width: 8),
        Text(
          value,
          style: GoogleFonts.tajawal(
            fontWeight: FontWeight.bold,
            color: isPrice ? AppTheme.primaryMaroon : AppTheme.textPrimary,
            fontSize: isPrice ? 16 : 14,
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard({required String title, required String value, required IconData icon, required Color color}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5, offset: const Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: GoogleFonts.tajawal(fontSize: 12, color: AppTheme.textSecondary)),
              Text(value, style: GoogleFonts.cairo(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 2. تبويب الأرباح (Earnings Tab)
  // ---------------------------------------------------------------------------
  Widget _buildEarningsTab() {
    // حساب المجموع الكلي
    double totalEarnings = 0;
    for (var session in _sessions) {
      // نفترض أننا نحسب أرباح الحصص المكتملة فقط
      if (session['status'] == 'completed') {
        totalEarnings += (session['price'] as int);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('الأرباح المالية', style: GoogleFonts.cairo(fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          // بطاقة الرصيد الإجمالي
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppTheme.primaryMaroon, Color(0xFFA91D47)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primaryMaroon.withOpacity(0.4),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  'إجمالي الأرباح المكتسبة',
                  style: GoogleFonts.tajawal(color: Colors.white.withOpacity(0.9), fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(
                  '$totalEarnings ر.ق',
                  style: GoogleFonts.cairo(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.check_circle, color: Colors.white, size: 16),
                      const SizedBox(width: 6),
                      Text(
                        'تم التحديث الآن',
                        style: GoogleFonts.tajawal(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                'سجل المعاملات',
                style: GoogleFonts.cairo(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 8),

          // جدول المعاملات (قائمة)
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _sessions.length,
              itemBuilder: (context, index) {
                final session = _sessions[index];
                final isCompleted = session['status'] == 'completed';
                
                // نعرض فقط الحصص المكتملة في سجل الأرباح (أو نميز القادمة بلون باهت)
                if (!isCompleted) return const SizedBox.shrink();

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppTheme.secondaryGold.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.attach_money, color: AppTheme.secondaryGold),
                    ),
                    title: Text(
                      session['subject'],
                      style: GoogleFonts.tajawal(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      '${session['studentName']} • ${session['date']}',
                      style: GoogleFonts.tajawal(fontSize: 12, color: AppTheme.textSecondary),
                    ),
                    trailing: Text(
                      '+${session['price']} ر.ق',
                      style: GoogleFonts.cairo(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileTab() {
    return const TeacherProfileScreen();
  }
}
