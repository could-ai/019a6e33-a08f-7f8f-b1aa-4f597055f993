import 'package:flutter/material.dart';
import '../../utils/theme.dart';

class BookingScreen extends StatefulWidget {
  final String? subject;

  const BookingScreen({super.key, this.subject});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  String? _selectedSubject;
  String _selectedCurriculum = 'qatari';
  String? _selectedGrade;
  DateTime _selectedDate = DateTime.now();
  TimeOfDay? _selectedTime;
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _houseNumberController = TextEditingController();

  final List<String> _subjects = [
    'الرياضيات',
    'العلوم',
    'اللغة العربية',
    'اللغة الإنجليزية',
    'الفيزياء',
    'الكيمياء',
  ];

  final List<String> _grades = [
    'الصف الأول',
    'الصف الثاني',
    'الصف الثالث',
    'الصف الرابع',
    'الصف الخامس',
    'الصف السادس',
    'الصف السابع',
    'الصف الثامن',
    'الصف التاسع',
    'الصف العاشر',
    'الصف الحادي عشر',
    'الصف الثاني عشر',
  ];

  @override
  void initState() {
    super.initState();
    _selectedSubject = widget.subject;
  }

  @override
  void dispose() {
    _addressController.dispose();
    _houseNumberController.dispose();
    super.dispose();
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppTheme.primaryMaroon,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _handleBooking() {
    if (_selectedSubject == null ||
        _selectedGrade == null ||
        _selectedTime == null ||
        _addressController.text.isEmpty ||
        _houseNumberController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('يرجى إكمال جميع الحقول المطلوبة'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // TODO: Implement actual booking with Supabase
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تأكيد الحجز'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('المادة: $_selectedSubject'),
              Text('الصف الدراسي: $_selectedGrade'),
              Text('المنهج: ${_selectedCurriculum == "qatari" ? "قطري" : "دولي"}'),
              Text('التاريخ: ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}'),
              Text('الوقت: ${_selectedTime!.format(context)}'),
              Text('العنوان: ${_addressController.text}'),
              Text('رقم البيت: ${_houseNumberController.text}'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('تم حجز الحصة بنجاح'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('تأكيد'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('حجز حصة جديدة'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Subject selection
            Text(
              'اختر المادة',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _selectedSubject,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.subject),
                hintText: 'اختر المادة',
              ),
              items: _subjects.map((subject) {
                return DropdownMenuItem(
                  value: subject,
                  child: Text(subject),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedSubject = value;
                });
              },
            ),
            const SizedBox(height: 24),

            // Grade selection
            Text(
              'الصف الدراسي',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _selectedGrade,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.school),
                hintText: 'اختر الصف الدراسي',
              ),
              items: _grades.map((grade) {
                return DropdownMenuItem(
                  value: grade,
                  child: Text(grade),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedGrade = value;
                });
              },
            ),
            const SizedBox(height: 24),

            // Curriculum selection
            Text(
              'اختر المنهج',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(
                  value: 'qatari',
                  label: Text('قطري'),
                  icon: Icon(Icons.flag),
                ),
                ButtonSegment(
                  value: 'international',
                  label: Text('دولي'),
                  icon: Icon(Icons.public),
                ),
              ],
              selected: {_selectedCurriculum},
              onSelectionChanged: (Set<String> newSelection) {
                setState(() {
                  _selectedCurriculum = newSelection.first;
                });
              },
            ),
            const SizedBox(height: 24),

            // Date selection
            Text(
              'اختر التاريخ',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            Card(
              child: ListTile(
                leading: const Icon(Icons.calendar_today, color: AppTheme.primaryMaroon),
                title: Text(
                  '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 30)),
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: const ColorScheme.light(
                            primary: AppTheme.primaryMaroon,
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (picked != null) {
                    setState(() {
                      _selectedDate = picked;
                    });
                  }
                },
              ),
            ),
            const SizedBox(height: 24),

            // Time selection
            Text(
              'اختر الوقت',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            Card(
              child: ListTile(
                leading: const Icon(Icons.access_time, color: AppTheme.primaryMaroon),
                title: Text(
                  _selectedTime != null
                      ? _selectedTime!.format(context)
                      : 'اضغط لاختيار الوقت',
                  style: TextStyle(
                    color: _selectedTime != null
                        ? AppTheme.textPrimary
                        : AppTheme.textSecondary,
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: _selectTime,
              ),
            ),
            const SizedBox(height: 24),

            // Address field
            Text(
              'العنوان',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.location_on),
                hintText: 'أدخل عنوان السكن',
                labelText: 'العنوان',
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 24),

            // House number field
            Text(
              'رقم البيت',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _houseNumberController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.home),
                hintText: 'أدخل رقم البيت',
                labelText: 'رقم البيت',
              ),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 32),

            // Confirm button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _handleBooking,
                child: const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'تأكيد الحجز',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}