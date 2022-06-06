import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:reminder/api/google_signin_api.dart';
import 'package:reminder/components/start_button.dart';
import 'package:reminder/screens/myInfoPage.dart';
import 'package:reminder/controller/reactiveController.dart';

class Start extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final ReactiveController controller = Get.put(ReactiveController());

    Future signIn() async {
      final GoogleSignInAccount? googleUser = await GoogleSignInApi.logIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser!.authentication;

      if (googleUser == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Sign In Failed!')
          )
        );
      } else {
        controller.updateUserInfo(googleUser);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyInfoPage(),
          )
        );
      }
    }  

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/quiz-logo.png'),
              GestureDetector(
                child: StartButton(
                  text: 'Google Login'
                ),
                onTap: () {
                  signIn();
                }
              ),
            ],
          )
        ),
      )
    );
  }
}
