import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/theme.dart';
import '../../widgets/subject_card.dart';
import 'booking_screen.dart';

class StudentHomeScreen extends StatefulWidget {
  const StudentHomeScreen({super.key});

  @override
  State<StudentHomeScreen> createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {
  int _selectedIndex = 0;
  final String _studentName = 'أحمد محمد'; // Mock data

  // Mock subjects data
  final List<Map<String, dynamic>> _subjects = [
    {
      'name': 'الرياضيات',
      'icon': Icons.calculate,
      'color': Colors.blue,
      'upcoming': 2,
    },
    {
      'name': 'العلوم',
      'icon': Icons.science,
      'color': Colors.green,
      'upcoming': 1,
    },
    {
      'name': 'اللغة العربية',
      'icon': Icons.menu_book,
      'color': Colors.orange,
      'upcoming': 3,
    },
    {
      'name': 'اللغة الإنجليزية',
      'icon': Icons.language,
      'color': Colors.purple,
      'upcoming': 1,
    },
    {
      'name': 'الفيزياء',
      'icon': Icons.bolt,
      'color': Colors.red,
      'upcoming': 0,
    },
    {
      'name': 'الكيمياء',
      'icon': Icons.biotech,
      'color': Colors.teal,
      'upcoming': 2,
    },
  ];

  // Mock sessions data for student
  final List<Map<String, dynamic>> _sessions = [
    {
      'id': '1',
      'teacherName': 'سارة أحمد',
      'subject': 'الرياضيات',
      'date': '2023-10-25',
      'time': '16:00',
      'duration': '1 ساعة',
      'price': 200,
      'status': 'upcoming', // قادمة
      'curriculum': 'قطري',
      'address': 'الدوحة، منطقة الخليج الغربي',
    },
    {
      'id': '2',
      'teacherName': 'محمد علي',
      'subject': 'الفيزياء',
      'date': '2023-10-26',
      'time': '14:30',
      'duration': '1.5 ساعة',
      'price': 300,
      'status': 'upcoming',
      'curriculum': 'دولي',
      'address': 'الدوحة، اللؤلؤة',
    },
    {
      'id': '3',
      'teacherName': 'فاطمة حسن',
      'subject': 'اللغة العربية',
      'date': '2023-10-23',
      'time': '10:00',
      'duration': '1 ساعة',
      'price': 200,
      'status': 'completed', // مكتملة
      'curriculum': 'قطري',
      'address': 'الدوحة، الريان',
      'rated': true,
      'rating': 5,
    },
    {
      'id': '4',
      'teacherName': 'خالد محمود',
      'subject': 'الكيمياء',
      'date': '2023-10-22',
      'time': '18:00',
      'duration': '2 ساعة',
      'price': 400,
      'status': 'completed',
      'curriculum': 'دولي',
      'address': 'الدوحة، الوكرة',
      'rated': false, // لم يتم التقييم بعد
    },
    {
      'id': '5',
      'teacherName': 'نورة السليطي',
      'subject': 'اللغة الإنجليزية',
      'date': '2023-10-20',
      'time': '15:00',
      'duration': '1 ساعة',
      'price': 200,
      'status': 'completed',
      'curriculum': 'دولي',
      'address': 'الدوحة، الخليج الغربي',
      'rated': true,
      'rating': 4,
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
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppTheme.secondaryGold,
              child: Text(
                _studentName[0],
                style: GoogleFonts.cairo(
                  color: AppTheme.primaryMaroon,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'مرحباً',
                    style: GoogleFonts.tajawal(
                      fontSize: 12,
                      color: Colors.white70,
                    ),
                  ),
                  Text(
                    _studentName,
                    style: GoogleFonts.cairo(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications),
                onPressed: () {
                  // TODO: Open notifications
                },
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '3',
                    style: GoogleFonts.cairo(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: AppTheme.primaryMaroon,
        unselectedItemColor: AppTheme.textSecondary,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: GoogleFonts.cairo(fontWeight: FontWeight.bold),
        unselectedLabelStyle: GoogleFonts.tajawal(),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'حصصي',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on),
            label: 'النقاط',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'حسابي',
          ),
        ],
      ),
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BookingScreen()),
                );
              },
              backgroundColor: AppTheme.secondaryGold,
              icon: const Icon(Icons.add, color: AppTheme.textPrimary),
              label: Text(
                'حجز حصة',
                style: GoogleFonts.cairo(
                  color: AppTheme.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : null,
    );
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return _buildHomeTab();
      case 1:
        return _buildScheduleTab();
      case 2:
        return _buildPointsTab();
      case 3:
        return _buildProfileTab();
      default:
        return _buildHomeTab();
    }
  }

  Widget _buildHomeTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'المواد الدراسية',
            style: GoogleFonts.cairo(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.1,
            ),
            itemCount: _subjects.length,
            itemBuilder: (context, index) {
              final subject = _subjects[index];
              return SubjectCard(
                name: subject['name'],
                icon: subject['icon'],
                color: subject['color'],
                upcomingSessions: subject['upcoming'],
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookingScreen(subject: subject['name']),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // تبويب حصصي (My Sessions Tab)
  // ---------------------------------------------------------------------------
  Widget _buildScheduleTab() {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'حصصي',
          style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
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
                        _buildDetailRow(Icons.person, 'المدرس:', session['teacherName']),
                        const SizedBox(height: 8),
                        _buildDetailRow(Icons.menu_book, 'المادة:', session['subject']),
                        const SizedBox(height: 8),
                        _buildDetailRow(Icons.public, 'المنهج:', session['curriculum']),
                        const SizedBox(height: 8),
                        _buildDetailRow(Icons.timer, 'المدة:', session['duration']),
                        const SizedBox(height: 8),
                        _buildDetailRow(Icons.monetization_on, 'السعر:', '${session['price']} ر.ق', isPrice: true),
                        const SizedBox(height: 8),
                        _buildDetailRow(Icons.location_on, 'العنوان:', session['address']),

                        // زر التقييم للحصص المكتملة
                        if (!isUpcoming && session['rated'] == false) ..[
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                _showRatingDialog(session);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.secondaryGold,
                                foregroundColor: AppTheme.textPrimary,
                              ),
                              icon: const Icon(Icons.star, size: 18),
                              label: Text(
                                'قيّم هذه الحصة',
                                style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],

                        // عرض التقييم إذا تم
                        if (!isUpcoming && session['rated'] == true) ..[
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.check_circle, color: Colors.green, size: 16),
                              const SizedBox(width: 6),
                              Text(
                                'تم التقييم: ',
                                style: GoogleFonts.tajawal(color: Colors.green[700]),
                              ),
                              ...List.generate(
                                session['rating'],
                                (index) => const Icon(Icons.star, color: AppTheme.secondaryGold, size: 16),
                              ),
                            ],
                          ),
                        ],
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
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.tajawal(
              fontWeight: FontWeight.bold,
              color: isPrice ? AppTheme.primaryMaroon : AppTheme.textPrimary,
              fontSize: isPrice ? 16 : 14,
            ),
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

  // دالة عرض نافذة التقييم
  void _showRatingDialog(Map<String, dynamic> session) {
    int rating = 0;
    final TextEditingController commentController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(
            'تقييم الحصة',
            style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'المدرس: ${session['teacherName']}',
                  style: GoogleFonts.tajawal(fontSize: 16),
                ),
                Text(
                  'المادة: ${session['subject']}',
                  style: GoogleFonts.tajawal(color: AppTheme.textSecondary),
                ),
                const SizedBox(height: 20),
                Text(
                  'كيف كانت تجربتك؟',
                  style: GoogleFonts.cairo(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return IconButton(
                      onPressed: () {
                        setDialogState(() {
                          rating = index + 1;
                        });
                      },
                      icon: Icon(
                        index < rating ? Icons.star : Icons.star_border,
                        color: AppTheme.secondaryGold,
                        size: 36,
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: commentController,
                  decoration: InputDecoration(
                    hintText: 'أضف تعليقاً (اختياري)',
                    hintStyle: GoogleFonts.tajawal(),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  maxLines: 3,
                  style: GoogleFonts.tajawal(),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('إلغاء', style: GoogleFonts.cairo()),
            ),
            ElevatedButton(
              onPressed: rating > 0
                  ? () {
                      // TODO: Save rating to Supabase
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'شكراً لتقييمك! حصلت على +2 نقطة',
                            style: GoogleFonts.tajawal(),
                          ),
                          backgroundColor: Colors.green,
                        ),
                      );
                      setState(() {
                        session['rated'] = true;
                        session['rating'] = rating;
                      });
                    }
                  : null,
              child: Text('إرسال', style: GoogleFonts.cairo()),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // تبويب النقاط (Points Tab)
  // ---------------------------------------------------------------------------
  Widget _buildPointsTab() {
    // حساب إجمالي النقاط
    int totalPoints = 450; // Mock data
    int pointsNeeded = 120 - (totalPoints % 120);
    double progress = (totalPoints % 120) / 120;

    // سجل النقاط
    final List<Map<String, dynamic>> pointsHistory = [
      {'action': 'حجز حصة رياضيات', 'points': 10, 'date': '2023-10-25'},
      {'action': 'حضور حصة فيزياء', 'points': 5, 'date': '2023-10-24'},
      {'action': 'تقييم المدرس', 'points': 2, 'date': '2023-10-24'},
      {'action': 'حجز حصة كيمياء', 'points': 10, 'date': '2023-10-23'},
      {'action': 'حضور حصة لغة عربية', 'points': 5, 'date': '2023-10-23'},
      {'action': 'تقييم المدرس', 'points': 2, 'date': '2023-10-23'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'نقاطي',
          style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          // بطاقة النقاط الإجمالية
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppTheme.secondaryGold, Color(0xFFFFD700)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.secondaryGold.withOpacity(0.4),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              children: [
                const Icon(Icons.stars, color: Colors.white, size: 48),
                const SizedBox(height: 12),
                Text(
                  'رصيدك الحالي',
                  style: GoogleFonts.tajawal(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '$totalPoints نقطة',
                  style: GoogleFonts.cairo(
                    color: Colors.white,
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),

                // شريط التقدم للحصة المجانية
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'الحصة المجانية القادمة',
                            style: GoogleFonts.tajawal(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'متبقي $pointsNeeded نقطة',
                            style: GoogleFonts.cairo(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: progress,
                          minHeight: 12,
                          backgroundColor: Colors.white.withOpacity(0.3),
                          valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // كيفية كسب النقاط
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'كيف تكسب النقاط؟',
                  style: GoogleFonts.cairo(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                _buildPointsInfoCard('حجز حصة', '+10 نقاط', Icons.add_circle, Colors.blue),
                const SizedBox(height: 8),
                _buildPointsInfoCard('حضور الحصة', '+5 نقاط', Icons.check_circle, Colors.green),
                const SizedBox(height: 8),
                _buildPointsInfoCard('تقييم المدرس', '+2 نقطة', Icons.star, AppTheme.secondaryGold),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // سجل النقاط
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'سجل النقاط',
                  style: GoogleFonts.cairo(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'آخر 6 عمليات',
                  style: GoogleFonts.tajawal(
                    fontSize: 12,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: pointsHistory.length,
              itemBuilder: (context, index) {
                final item = pointsHistory[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.add, color: Colors.green, size: 20),
                    ),
                    title: Text(
                      item['action'],
                      style: GoogleFonts.tajawal(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      item['date'],
                      style: GoogleFonts.tajawal(
                        fontSize: 12,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                    trailing: Text(
                      '+${item['points']}',
                      style: GoogleFonts.cairo(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                        fontSize: 18,
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

  Widget _buildPointsInfoCard(String title, String points, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.tajawal(
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
            ),
          ),
          Text(
            points,
            style: GoogleFonts.cairo(
              fontWeight: FontWeight.bold,
              color: color,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person, size: 64, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            'الملف الشخصي',
            style: GoogleFonts.cairo(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'معلومات الحساب والإعدادات',
            style: GoogleFonts.tajawal(
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}