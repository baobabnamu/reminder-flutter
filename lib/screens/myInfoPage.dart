import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reminder/api/google_signin_api.dart';
import 'package:reminder/components/global_appBar.dart';
import 'package:reminder/components/start_button.dart';
import 'package:reminder/controller/reactiveController.dart';
import 'package:reminder/screens/quizPortal.dart';

class MyInfoPage extends StatelessWidget {
  const MyInfoPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ReactiveController controller = Get.find();
    ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: GlobalAppBar(
        appBar: AppBar(), 
        text: "REMINDER"
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 32,),
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(controller.quizUser.value.photoUrl!),
            ),
            SizedBox(height: 8,),
            Text(
              '이름: ' + controller.quizUser.value.displayName!,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
            SizedBox(height: 8,),
            Text(
              '계정: ' + controller.quizUser.value.email!,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),     
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  child: StartButton(
                    text: 'LogOut'
                  ),
                  onTap: () async {
                    await GoogleSignInApi.logOut();
                    Navigator.pushReplacementNamed(context, 'start');
                  }
                ),                
                GestureDetector(
                  child: StartButton(
                    text: 'Quiz Portal'
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuizPortal(),
                      )
                    );
                  }
                ), 
              ],  
            )
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        child: Container(
          height: 80,
          color: theme.backgroundColor,
        ),
      ),
    );
  }
}