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
  DateTime _selectedDate = DateTime.now();
  String? _selectedTime;

  final List<String> _subjects = [
    'الرياضيات',
    'العلوم',
    'اللغة العربية',
    'اللغة الإنجليزية',
    'الفيزياء',
    'الكيمياء',
  ];

  final List<String> _availableTimes = [
    '08:00 صباحاً',
    '10:00 صباحاً',
    '12:00 ظهراً',
    '02:00 مساءً',
    '04:00 مساءً',
    '06:00 مساءً',
  ];

  @override
  void initState() {
    super.initState();
    _selectedSubject = widget.subject;
  }

  void _handleBooking() {
    if (_selectedSubject == null || _selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('يرجى اختيار المادة والوقت'),
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
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('المادة: $_selectedSubject'),
            Text('المنهج: ${_selectedCurriculum == "qatari" ? "قطري" : "دولي"}'),
            Text('التاريخ: ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}'),
            Text('الوقت: $_selectedTime'),
          ],
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
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _availableTimes.map((time) {
                final isSelected = _selectedTime == time;
                return FilterChip(
                  label: Text(time),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      _selectedTime = selected ? time : null;
                    });
                  },
                  selectedColor: AppTheme.secondaryGold,
                  checkmarkColor: AppTheme.textPrimary,
                  backgroundColor: Colors.white,
                  side: BorderSide(
                    color: isSelected ? AppTheme.secondaryGold : Colors.grey.shade300,
                  ),
                );
              }).toList(),
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
