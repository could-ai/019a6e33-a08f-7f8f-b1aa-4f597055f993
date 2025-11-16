                        // Create account
                        TextButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const TeacherRegistrationScreen(),
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