import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // Import go_router

class QuizLayout extends StatefulWidget {
  @override
  _QuizLayoutState createState() => _QuizLayoutState();
}

class _QuizLayoutState extends State<QuizLayout> {
  int currentQuestion = 0;
  int timeLeft = 1800; // 30 phút = 1800 giây
  late Timer _timer;
  final List<Map<String, dynamic>> questions = [
    {'id': 1, 'content': '1 + 1 = ?', 'answer': 'A.2'},
    {'id': 2, 'content': '2 + 3 = ?', 'answer': 'B.5'},
    {'id': 3, 'content': '5 - 2 = ?', 'answer': 'C.3'},
    {'id': 4, 'content': '4 × 2 = ?', 'answer': 'D.8'},
    {'id': 5, 'content': '10 ÷ 2 = ?', 'answer': 'A.5'},
    {'id': 6, 'content': '3 + 4 = ?', 'answer': 'B.7'},
    {'id': 7, 'content': '7 - 5 = ?', 'answer': 'C.2'},
    {'id': 8, 'content': '6 × 1 = ?', 'answer': 'D.6'},
    {'id': 9, 'content': '9 ÷ 3 = ?', 'answer': 'A.3'},
    {'id': 10, 'content': '8 + 2 = ?', 'answer': 'B.10'},
  ];
  final Map<int, String?> selectedOptions = {};

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        if (timeLeft > 0) {
          setState(() {
            timeLeft--;
          });
        } else {
          _timer.cancel();
          _submitQuiz();
        }
      }
    });
  }

  void _submitQuiz() {
    int correctAnswers = 0;
    for (int i = 0; i < questions.length; i++) {
      if (selectedOptions[questions[i]['id']] == questions[i]['answer']) {
        correctAnswers++;
      }
    }
    // Chuyển sang màn hình Dashboard sau khi tính điểm
    context.go('/dashboard');
  }

  void _nextQuestion() {
    if (currentQuestion < questions.length - 1) {
      setState(() {
        currentQuestion++;
      });
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String formatTime(int seconds) {
      int minutes = seconds ~/ 60;
      int remainingSeconds = seconds % 60;
      return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Layout'),
        backgroundColor: Colors.blueGrey[800],
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.grey[200]!, Colors.white, Colors.grey[100]!],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(10.0),
          children: [
            // Number pad
            Container(
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey[300],
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[500]!.withOpacity(0.2),
                    spreadRadius: -5,
                    blurRadius: 10,
                    offset: const Offset(3, 3),
                  ),
                  BoxShadow(
                    color: Colors.white.withOpacity(0.6),
                    spreadRadius: -5,
                    blurRadius: 10,
                    offset: const Offset(-3, -3),
                  ),
                ],
              ),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.2,
                  crossAxisSpacing: 6,
                  mainAxisSpacing: 6,
                ),
                itemCount: 10,
                itemBuilder: (context, index) {
                  final questionNumber = index + 1;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        currentQuestion = index;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: currentQuestion == index
                            ? Colors.blueGrey[700]
                            : Colors.grey[400],
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[500]!.withOpacity(0.1),
                            blurRadius: 6,
                            offset: const Offset(2, 2),
                          ),
                          BoxShadow(
                            color: Colors.white.withOpacity(0.7),
                            blurRadius: 6,
                            offset: const Offset(-2, -2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          questionNumber.toString(),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: currentQuestion == index
                                ? Colors.white
                                : Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Questions and options
            Container(
              margin: const EdgeInsets.only(bottom: 15),
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[400]!.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(3, 3),
                  ),
                  BoxShadow(
                    color: Colors.white.withOpacity(0.7),
                    blurRadius: 10,
                    offset: const Offset(-3, -3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Câu ${questions[currentQuestion]['id']}: ${questions[currentQuestion]['content']}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[800],
                    ),
                  ),
                  const SizedBox(height: 10),
                  OptionList(
                    questionId: questions[currentQuestion]['id'],
                    selectedOption: selectedOptions[questions[currentQuestion]['id']],
                    onOptionSelected: (value) {
                      setState(() {
                        selectedOptions[questions[currentQuestion]['id']] = value;
                      });
                    },
                  ),
                ],
              ),
            ),

            // Next button
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: ElevatedButton(
                onPressed: _nextQuestion,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal[700],
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 0,
                ).copyWith(
                  overlayColor: MaterialStateProperty.resolveWith<Color?>(
                    (states) {
                      if (states.contains(MaterialState.pressed)) {
                        return Colors.teal[900];
                      }
                      return null;
                    },
                  ),
                ),
                child: const Text(
                  "Next",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            // Timer and submit button
            Container(
              margin: const EdgeInsets.only(top: 15),
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                        colors: [Colors.blueGrey[800]!, Colors.blueGrey[600]!],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[500]!.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(3, 3),
                        ),
                        BoxShadow(
                          color: Colors.white.withOpacity(0.7),
                          blurRadius: 10,
                          offset: const Offset(-3, -3),
                        ),
                      ],
                    ),
                    child: Text(
                      formatTime(timeLeft),
                      style: const TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {
                      _timer.cancel();
                      _submitQuiz();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal[700],
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 0,
                    ).copyWith(
                      overlayColor: MaterialStateProperty.resolveWith<Color?>(
                        (states) {
                          if (states.contains(MaterialState.pressed)) {
                            return Colors.teal[900];
                          }
                          return null;
                        },
                      ),
                    ),
                    child: const Text(
                      "Nộp bài",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
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

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}

class OptionList extends StatelessWidget {
  final int questionId;
  final String? selectedOption;
  final Function(String?) onOptionSelected;

  const OptionList({
    required this.questionId,
    required this.selectedOption,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    final options = ['A.2', 'B.5', 'C.3', 'D.8'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: options.map((option) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[400]!.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(2, 2),
                ),
                BoxShadow(
                  color: Colors.white.withOpacity(0.7),
                  blurRadius: 8,
                  offset: const Offset(-2, -2),
                ),
              ],
            ),
            child: RadioListTile(
              value: option,
              groupValue: selectedOption,
              onChanged: (value) {
                onOptionSelected(value);
              },
              title: Text(
                option,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              activeColor: Colors.teal[700],
              controlAffinity: ListTileControlAffinity.trailing,
              tileColor: selectedOption == option ? Colors.teal[50] : null,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
