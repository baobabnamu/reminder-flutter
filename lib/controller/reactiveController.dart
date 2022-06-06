import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:reminder/model/quizUser.dart';

class ReactiveController extends GetxController {
  var quizUser = QuizUser(
    displayName: '',
    email: '',
    photoUrl: '',
  ).obs;

  void updateUserInfo(GoogleSignInAccount googleUser) {
    quizUser.value.displayName = googleUser.displayName;
    quizUser.value.email = googleUser.email;
    quizUser.value.photoUrl = googleUser.photoUrl;
  }

  var quizQuestionBodyIndex = 0;
  selectedHourBody() => quizQuestionBodyIndex = 0;
  selectedDayBody() => quizQuestionBodyIndex = 1;
  selectedWeekBody() => quizQuestionBodyIndex = 2;
  selectedMonthBody() => quizQuestionBodyIndex = 3;
  selectedLongTermBody() => quizQuestionBodyIndex = 4;

  var quizHourIndex = 0;
  increaseHourIndex() => quizHourIndex++;
  var quizHourCardState = false; // false = word, true = mean
  changeHourCardState() => quizHourCardState = !quizHourCardState;
  var quizHourNowCardWord = '';
  changeQuizHourNowCardWord(String word) => quizHourNowCardWord = word;

  var quizDayIndex = 0;
  increaseDayIndex() => quizDayIndex++;
  var quizDayCardState = false; // false = word, true = mean
  changeDayCardState() => quizDayCardState = !quizDayCardState;
  var quizDayNowCardWord = '';
  changeQuizDayNowCardWord(String word) => quizDayNowCardWord = word;

  var quizWeekIndex = 0;
  increaseWeekIndex() => quizWeekIndex++;
  var quizWeekCardState = false; // false = word, true = mean
  changeWeekCardState() => quizWeekCardState = !quizWeekCardState;
  var quizWeekNowCardWord = '';
  changeQuizWeekNowCardWord(String word) => quizWeekNowCardWord = word;

  var quizMonthIndex = 0;
  increaseMonthIndex() => quizMonthIndex++;
  var quizMonthCardState = false; // false = word, true = mean
  changeMonthCardState() => quizMonthCardState = !quizMonthCardState;  
  var quizMonthNowCardWord = '';
  changeQuizMonthNowCardWord(String word) => quizMonthNowCardWord = word;

  var quizLongTermIndex = 0;
  increaseLongTermIndex() => quizLongTermIndex++;
  var quizLongTermCardState = false; // false = word, true = mean
  changeLongTermCardState() => quizLongTermCardState = !quizLongTermCardState;  
  var quizLongTermNowCardWord = '';
  changeQuizLongTermNowCardWord(String word) => quizLongTermNowCardWord = word;
}