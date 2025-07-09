import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart'; // Import GoRouter

class CreateQuizScreen extends StatefulWidget {
  const CreateQuizScreen({super.key});

  @override
  State<CreateQuizScreen> createState() => _CreateQuizScreenState();
}

class _CreateQuizScreenState extends State<CreateQuizScreen> {
  String? selectedSubject;
  String? selectedClass;
  String? selectedQuestionCount;
  String? selectedTime;

  final List<String> subjects = ['Toán', 'Văn', 'Anh', 'Lý', 'Hóa', 'Sinh'];
  final List<String> classes = ['6', '7', '8', '9', '10', '11', '12'];
  final List<String> questionCounts = ['10', '15', '20', '30', '50'];
  final List<String> times = [
    '10 phút',
    '15 phút',
    '20 phút',
    '30 phút',
    '45 phút',
    '60 phút',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f8fb),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: SizedBox(
              width: 430,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  // Card trắng chứa form
                  Container(
                    margin: const EdgeInsets.only(top: 0),
                    padding: const EdgeInsets.symmetric(
                      vertical: 36,
                      horizontal: 32,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueGrey.withOpacity(0.11),
                          blurRadius: 36,
                          offset: const Offset(0, 12),
                        ),
                      ],
                      border: Border.all(
                        color: const Color(0xffe9edf3),
                        width: 1.2,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header
                        Row(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                color: Color(0xffe0f2fe),
                                shape: BoxShape.circle,
                              ),
                              padding: const EdgeInsets.all(9),
                              child: Icon(
                                Icons.quiz_rounded,
                                color: Colors.blue[700],
                                size: 36,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Text(
                              "Tạo đề trắc nghiệm",
                              style: GoogleFonts.poppins(
                                fontSize: 25,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xff294265),
                                letterSpacing: 0.2,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Chọn cấu hình đề kiểm tra phù hợp, hệ thống sẽ tự động chấm điểm khi hết giờ.",
                          style: GoogleFonts.roboto(
                            fontSize: 14.5,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 32),

                        _buildModernDropdown(
                          icon: Icons.menu_book_rounded,
                          label: "Môn học",
                          value: selectedSubject,
                          hint: "Chọn môn học",
                          items: subjects,
                          onChanged: (v) => setState(() => selectedSubject = v),
                        ),
                        _buildModernDropdown(
                          icon: Icons.class_rounded,
                          label: "Lớp học",
                          value: selectedClass,
                          hint: "Chọn lớp",
                          items: classes,
                          onChanged: (v) => setState(() => selectedClass = v),
                        ),
                        _buildModernDropdown(
                          icon: Icons.format_list_numbered_rounded,
                          label: "Số lượng câu hỏi",
                          value: selectedQuestionCount,
                          hint: "Chọn số câu hỏi",
                          items: questionCounts,
                          onChanged:
                              (v) => setState(() => selectedQuestionCount = v),
                        ),
                        _buildModernDropdown(
                          icon: Icons.timer_rounded,
                          label: "Thời gian làm bài",
                          value: selectedTime,
                          hint: "Chọn thời gian",
                          items: times,
                          onChanged: (v) => setState(() => selectedTime = v),
                        ),

                        const SizedBox(height: 26),
                        // Lưu ý, cảnh báo
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.blue[50]!, Colors.yellow[50]!],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _noteRow(
                                Icons.info_outline_rounded,
                                "Lưu ý:",
                                Colors.blue[800]!,
                              ),
                              const SizedBox(height: 2),
                              _noteText(
                                "• Thời gian tính từ lúc bấm 'Tạo đề'.",
                              ),
                              _noteText("• Hết giờ sẽ tự động nộp và chấm."),
                              _noteText(
                                "• Gặp lỗi, liên hệ: dungle102@gmail.com",
                              ),
                              const SizedBox(height: 7),
                              _noteRow(
                                Icons.warning_amber_rounded,
                                "Vi phạm:",
                                Colors.orange[800]!,
                              ),
                              const SizedBox(height: 2),
                              _noteText(
                                "• Thi một tài khoản trên hai thiết bị/trình duyệt cùng lúc.",
                              ),
                              _noteText("• Mở nhiều cửa sổ thi cùng lúc."),
                              const SizedBox(height: 4),
                              Text(
                                "Vi phạm sẽ bị hệ thống ghi nhận & báo nhà trường.",
                                style: GoogleFonts.roboto(
                                  fontSize: 14.3,
                                  color: Colors.red[700],
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 34),

                        // Nút tạo đề
                        Center(
                          child: SizedBox(
                            width: double.infinity,
                            child: GestureDetector(
                              onTap: () {
                                if (selectedSubject == null ||
                                    selectedClass == null ||
                                    selectedQuestionCount == null ||
                                    selectedTime == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Vui lòng chọn đầy đủ các trường!',
                                      ),
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.red[700],
                                      duration: const Duration(seconds: 2),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Đã tạo đề $selectedSubject lớp $selectedClass (${selectedQuestionCount ?? ""} câu, $selectedTime)!',
                                      ),
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.green[600],
                                      duration: const Duration(seconds: 2),
                                    ),
                                  );
                                  context.push('/quiz-layout');
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xfffee140),
                                      Color(0xfffa709a),
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.orange.withOpacity(0.17),
                                      blurRadius: 18,
                                      offset: const Offset(0, 8),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.edit_note_rounded,
                                      color: Color(0xff7d5702),
                                      size: 26,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      "TẠO ĐỀ",
                                      style: GoogleFonts.poppins(
                                        color: const Color(0xff7d5702),
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Dropdown widget
  Widget _buildModernDropdown({
    required IconData icon,
    required String label,
    required String? value,
    required String hint,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 19.0),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.blue[50],
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(10),
            child: Icon(icon, color: Colors.blue[400], size: 21),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xfff7fafc),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xffe0e5eb), width: 1.1),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: value,
                  icon: const Icon(Icons.expand_more, color: Colors.grey),
                  hint: Text(
                    hint,
                    style: GoogleFonts.roboto(
                      color: Colors.grey[600],
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  items: [
                    DropdownMenuItem(value: null, child: Text(hint)),
                    ...items
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                  ],
                  onChanged: onChanged,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _noteRow(IconData icon, String text, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 17),
        const SizedBox(width: 6),
        Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _noteText(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 3, top: 1.5, bottom: 1.5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("• ", style: TextStyle(fontSize: 16, color: Colors.grey)),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.roboto(fontSize: 14.3, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
