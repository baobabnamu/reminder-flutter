import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reminder/controller/reactiveController.dart';
import 'package:http/http.dart' as http;
import 'package:reminder/model/quizModel.dart';
import 'package:reminder/screens/quizQuestion.dart';

class QuizList extends StatelessWidget {
  final List<QuizModel>? quizSet;

  const QuizList({
    Key? key,
    this.quizSet
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ReactiveController controller = Get.put(ReactiveController());

    void checkIdx() {
      if (quizSet!.length == controller.quizLongTermIndex) {
        controller.quizLongTermIndex = 0;
      }
    }

    checkIdx();
    if (quizSet!.isEmpty) {
      return Text(
          '데이터가 없습니다.',
          style: TextStyle(
            color: Colors.indigo.shade900,
            fontSize: 24.0,
            fontWeight: FontWeight.w800,
          ),
        );
    } else if (!controller.quizLongTermCardState) {
        controller.changeQuizLongTermNowCardWord(quizSet![controller.quizLongTermIndex].word);
        return Text(
          quizSet![controller.quizLongTermIndex].word,
          style: TextStyle(
            color: Colors.indigo.shade900,
            fontSize: 35.0,
            fontWeight: FontWeight.w800,
          ),
        );
    } else {
        return Text(
          quizSet![controller.quizLongTermIndex].mean,
          style: TextStyle(
            color: Colors.indigo.shade900,
            fontSize: 35.0,
            fontWeight: FontWeight.w800,
          ),
        );
    }
  }
}

class QuizQuestionLongTerm extends StatelessWidget {
  const QuizQuestionLongTerm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ReactiveController controller = Get.find();

    List<QuizModel> parseQuizModels(String responseBody) {
      final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
      return parsed.map<QuizModel>((json) => QuizModel.fromJson(json)).toList();
    }

    Future<List<QuizModel>> fetchQuizSet(http.Client client) async {
      final response =
        await http.post(
        Uri.parse('https://reminder-api-tuk.herokuapp.com/quiz'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'quizSpace': 5,
          'uid': controller.quizUser.value.email!,
        }),
      );
      return compute(parseQuizModels, utf8.decode(response.bodyBytes));
    }
    
    return Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.center,
              child: SizedBox(
                child: Container(
                  decoration : BoxDecoration(
                    color: theme.backgroundColor,
                  ),
                ),
              )
          ),
          Align(
            child: SizedBox(
                width: 230,
                height: 230,
                child: GestureDetector(
                    child: Container(
                      decoration : BoxDecoration(
                        border : Border.all(color: Colors.black),
                        color: Colors.white,
                      ),
                    ),
                  onTap: () {
                    controller.changeLongTermCardState();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuizQuestion(),
                      )
                    );  
                  }
                ),
            ),           
          ),
          Align(
            child: FutureBuilder<List<QuizModel>>(
              future: fetchQuizSet(http.Client()),
              builder: (context, snapshot) {
                if(snapshot.hasError) print(snapshot.error);
                return snapshot.hasData
                  ? QuizList(quizSet: snapshot.data)
                  : Center(
                      child: CircularProgressIndicator(),
                    );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              height: 70,
              width: 70,
              margin: const EdgeInsets.only(bottom: 40, left: 20),
              child: FloatingActionButton(
                onPressed: () {
                  controller.increaseLongTermIndex();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizQuestion(),
                    )
                  );                  
                },
                child: Icon(
                  Icons.navigate_before, size: 40,
                  color: Colors.indigo.shade900,
                ),
              ),
            ),
          ),
        ],
    );
  }
}