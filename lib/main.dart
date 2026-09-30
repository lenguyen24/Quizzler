import 'package:flutter/material.dart';
import 'question.dart';

void main() => runApp(const QuizApp());

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quizzler',
      debugShowCheckedModeBanner: false,
      home: const QuizPage(),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final Icon tickIcon = const Icon(Icons.check, color: Colors.green, size: 24);
  final Icon crossIcon = const Icon(Icons.clear, color: Colors.red, size: 24);

  int count = 0;
  List<Icon> iconsList = [];

  final List<Question> questionsList = [
    Question('Môn Lập trình đa nền tảng học vào sáng thứ 5?', false),
    Question('Môn Lập trình đa nền tảng gồm 3 tín chỉ?', false),
    Question(
      'Giảng viên dạy Môn Lập trình đa nền tảng là thầy ThS Ngô Lê Quân',
      true,
    ),
    Question('1 + 1 = 2 ?', true),
  ];

  void _checkAnswer(bool selectedAnswer) {
    bool correctAnswer = questionsList[count].correctAnswer;

    setState(() {
      if (selectedAnswer == correctAnswer) {
        iconsList.add(tickIcon);
      } else {
        iconsList.add(crossIcon);
      }

      if (count < questionsList.length - 1) {
        count++;
      } else {
        // Sau khi trả lời xong câu cuối cùng, hiển thị thông báo kết thúc và reset
        _showFinishedDialog();
      }
    });
  }

  void _showFinishedDialog() {
    int totalScore = iconsList.where((icon) => icon.icon == Icons.check).length;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF444444),
          title: const Text(
            'Hoàn Thành Bài Quiz!',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          content: Text(
            'Bạn đã hoàn thành tất cả các câu hỏi.\nKết quả: $totalScore / ${questionsList.length} câu đúng.',
            style: const TextStyle(color: Colors.white70, fontSize: 16),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Tải lại (Reset)',
                style: TextStyle(color: Colors.greenAccent, fontSize: 16, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _resetQuiz();
              },
            ),
          ],
        );
      },
    );
  }

  void _resetQuiz() {
    setState(() {
      count = 0;
      iconsList.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF333333),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Dynamic flexible space for question text
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: Text(
                      questionsList[count].question,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 25.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),

              // True Button
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: () => _checkAnswer(true),
                    child: const Text(
                      'Đúng (True)',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              // False Button
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: () => _checkAnswer(false),
                    child: const Text(
                      'Sai (False)',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              // Score Keeper Row
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: SizedBox(
                  height: 30,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: iconsList,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
