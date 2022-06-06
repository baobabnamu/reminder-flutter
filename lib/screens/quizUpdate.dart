import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reminder/components/global_appBar.dart';
import 'package:http/http.dart' as http;
import 'package:reminder/controller/reactiveController.dart';

class QuizUpdate extends StatefulWidget {
  const QuizUpdate({
    Key? key,
  }) : super(key: key);

  QuizUpdateState createState() => QuizUpdateState();
}

class QuizUpdateState extends State<QuizUpdate> {
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
                onPressed: () {
                  updateQuizModel(
                    inputWordText, 
                    inputMeanText,
                    controller.quizUser.value.email!
                  );                  
                 },
                child: Text('수정'),
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

  Future updateQuizModel(String inputWordText, String inputMeanText, String email) async {
    final res = await http.put(
      Uri.parse('https://reminder-api-tuk.herokuapp.com/quiz/update'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'word': inputWordText,
        'mean': inputMeanText,
        'uid': email,
      }),
    );
    if (res.statusCode == 200) {
      final snackBar = SnackBar(
        content: const Text('퀴즈가 성공적으로 수정되었습니다!'),
        action: SnackBarAction(
          label: '닫기',
          onPressed: () {
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      throw Exception('failed to update quiz model');
    }
  }
}  