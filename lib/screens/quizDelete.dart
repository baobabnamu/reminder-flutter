import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reminder/components/global_appBar.dart';
import 'package:http/http.dart' as http;
import 'package:reminder/controller/reactiveController.dart';

class QuizDelete extends StatefulWidget {
  const QuizDelete({
    Key? key,
  }) : super(key: key);  

  QuizDeleteState createState() => QuizDeleteState();
}

class QuizDeleteState extends State<QuizDelete> {
  ReactiveController controller = Get.find();
  String inputWordText = '';

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
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.indigo.shade900, // background
                  onPrimary: Colors.white, // foreground
                ),
                onPressed: () {
                  deleteQuizModel(
                    inputWordText, 
                    controller.quizUser.value.email!
                  );                  
                },
                child: Text('삭제'),
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

  Future deleteQuizModel(String inputWordText, String email) async {
    final http.Response res = await http.delete(
      Uri.parse('https://reminder-api-tuk.herokuapp.com/quiz/del'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'word': inputWordText,
        'uid': email,
      }),    
    );

      if (res.statusCode == 200) {
      final snackBar = SnackBar(
        content: const Text('퀴즈가 성공적으로 삭제되었습니다!'),
        action: SnackBarAction(
          label: '닫기',
          onPressed: () {
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      throw Exception('failed to delete quiz model');
    }
  }
}