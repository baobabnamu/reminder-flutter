import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:reminder/components/global_appBar.dart';
import 'package:reminder/controller/reactiveController.dart';

class QuizInsert extends StatefulWidget {
  const QuizInsert({
    Key? key,
  }) : super(key: key);

  QuizInsertState createState() => QuizInsertState();
}

class QuizInsertState extends State<QuizInsert> {
  ReactiveController controller = Get.find();
  String inputWordText = '';
  String inputMeanText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppBar(
        appBar: AppBar(), 
        text: "REMINDER",
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                onChanged: (text) {
                  setState(() {
                    inputWordText = text;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Word',
                ),
              ),
              TextField(
                onChanged: (text) {
                  setState(() {
                    inputMeanText = text;
                  });
                },                
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Mean',
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.indigo.shade900, // background
                  onPrimary: Colors.white, // foreground
                ),
                child: Text('추가'),
                onPressed: () {
                  createQuizModel(
                    inputWordText, 
                    inputMeanText,
                    controller.quizUser.value.email!
                  );
                },
              )
            ]
         ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        child: Container(
          height: 80,
          color: Colors.white,
        ),
      ),
    );
  }
  
  Future createQuizModel(String inputWordText, String inputMeanText, String email) async {
    final res = await http.post(
      Uri.parse('https://reminder-api-tuk.herokuapp.com/quiz/add'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'word': inputWordText,
        'mean': inputMeanText,
        'uid': email,
      }),
    );

    if (res.statusCode == 200) {
      final snackBar = SnackBar(
        content: const Text('퀴즈가 성공적으로 생성되었습니다!'),
        action: SnackBarAction(
          label: '닫기',
          onPressed: () {
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      throw Exception('failed to create quiz model');
    }
  }
}