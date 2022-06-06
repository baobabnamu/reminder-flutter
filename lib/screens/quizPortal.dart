import 'package:flutter/material.dart';
import 'package:reminder/components/global_appBar.dart';
import 'package:reminder/components/quiz_button.dart';
import 'package:reminder/screens/quizDelete.dart';
import 'package:reminder/screens/quizInsert.dart';
import 'package:reminder/screens/quizQuestion.dart';
import 'package:reminder/screens/quizUpdate.dart';

class QuizPortal extends StatelessWidget {
  const QuizPortal({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    
    return Expanded(child: 
      Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: GlobalAppBar(
        appBar: AppBar(), 
        text: "REMINDER",
      ),      
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                child: QuizButton(
                  text: '퀴즈 풀기'
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizQuestion(),
                    )
                  );
                }
              ),
              GestureDetector(
                child: QuizButton(
                  text: '퀴즈 추가'
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizInsert(),
                    )
                  );
                }
              ),
              GestureDetector(
                child: QuizButton(
                  text: '퀴즈 수정'
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizUpdate(),
                    )
                  );
                }
              ),
              GestureDetector(
                child: QuizButton(
                  text: '퀴즈 삭제'
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizDelete(),
                    )
                  );
                }
              ),
              GestureDetector(
                child: QuizButton(
                  text: '홈 이동'
                ),
                onTap: () {
                  Navigator.pushReplacementNamed(context, 'start');
                }
              ),
            ],
          )
        ),
      ),
      bottomNavigationBar: SizedBox(
        child: Container(
          height: 80,
          color: theme.backgroundColor,
        ),
      ),
    )
    );
  }
}