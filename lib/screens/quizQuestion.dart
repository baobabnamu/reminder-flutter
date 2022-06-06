import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:reminder/components/global_appBar.dart';
import 'package:reminder/controller/reactiveController.dart';
import 'package:reminder/screens/quizQuestionDay.dart';
import 'package:reminder/screens/quizQuestionHour.dart';
import 'package:reminder/screens/quizQuestionLongTerm.dart';
import 'package:reminder/screens/quizQuestionMonth.dart';
import 'package:reminder/screens/quizQuestionWeek.dart';

class QuizQuestion extends StatelessWidget {
  const QuizQuestion({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: GlobalAppBar(
        appBar: AppBar(), 
        text: "REMINDER",
      ),
      body: QuizQuestionBody()
    );
  }
}

class QuizQuestionBody extends StatefulWidget {

  const QuizQuestionBody({
    Key? key,
  }) : super(key: key);

  @override
  State<QuizQuestionBody> createState() => QuizQuestionBodyState();
}

class QuizQuestionBodyState extends State<QuizQuestionBody> {
  ReactiveController controller = Get.put(ReactiveController());
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static const List<Widget> _widgetOptions = <Widget>[
    QuizQuestionHour(),
    QuizQuestionDay(),
    QuizQuestionWeek(),
    QuizQuestionMonth(),
    QuizQuestionLongTerm(),
  ];

  @override
  Widget build(BuildContext context) {
    int _selectedIndex = controller.quizQuestionBodyIndex;

    void _onItemTapped(int index) {
      if (index == 0) {
        controller.selectedHourBody();
      } else if (index == 1) {
        controller.selectedDayBody();
      } else if (index == 2) {
        controller.selectedWeekBody();
      } else if (index == 3) {
        controller.selectedMonthBody();
      } else {
        controller.selectedLongTermBody();
      } 
      setState(() {
        _selectedIndex = controller.quizQuestionBodyIndex;
      });
    }

    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.timelapse),
            label: '1H',
            backgroundColor: Colors.white
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timelapse),
            label: '1Day',
            backgroundColor: Colors.white
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timelapse),
            label: '1Week',
            backgroundColor: Colors.white
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timelapse),
            label: '1Month',
            backgroundColor: Colors.white
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timelapse),
            label: 'Long-Term',
            backgroundColor: Colors.white
          ),
        ],
        currentIndex: controller.quizQuestionBodyIndex,
        selectedItemColor: Colors.indigo.shade900,
        onTap: _onItemTapped,
      ),
    );
  }
}
