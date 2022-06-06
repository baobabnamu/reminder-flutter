import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reminder/screens/quizDelete.dart';
import 'package:reminder/screens/quizInsert.dart';
import 'package:reminder/screens/quizPortal.dart';
import 'package:reminder/screens/quizUpdate.dart';
import 'package:reminder/screens/start.dart';
import 'package:reminder/screens/quizQuestion.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Reminder',
      theme: ThemeData(
        brightness: Brightness.light,
        backgroundColor: Color.fromRGBO(37, 44, 74, 1.0),
        primaryColor: Color.fromRGBO(190, 56, 55, 1.0),
      ),
      routes: {
        'start': (context) => Start(),
        'quiz-portal': (context) => QuizPortal(),
      },
      home: Start(),
    );
  }
}