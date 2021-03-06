import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:reminder/screens/quizPortal.dart';
import 'package:reminder/screens/start.dart';

class GlobalAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;
  final String text;

  const GlobalAppBar({
    Key? key,
    required this.appBar,
    required this.text,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
  
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              child: Text(
                text, 
                style: TextStyle(
                  color: Colors.indigo.shade900,
                  fontSize: 35,
                  fontFamily: 'DoHyeonRegular'
                ),
              ),
              onTap: () {
                Navigator.pushReplacementNamed(context, 'start');
              }
            )  
          ],
        ),
        elevation: 0,
        leading: IconButton(
          color: Colors.indigo.shade900,
          icon: Icon(Icons.menu),
          iconSize: 30,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => QuizPortal(),
              )
            );
          },
        ),
        actions: [
          IconButton(
            color: Colors.indigo.shade900,
            icon: Icon(Icons.help),
            iconSize: 30,
            onPressed: () {
              Navigator.of(context).restorablePush(_dialogBuilder);
            },
          ),
        ],
    );
  }

  static Route<Object?> _dialogBuilder(BuildContext context, Object? arguments) {
    return DialogRoute<void>(
      context: context,
      builder: (BuildContext context) =>
        const AlertDialog(
          title: Text('?????????'),
          content: Text(
            '1??????, 1???, 1??????, 1??????, ???????????? ????????? ?????? ????????? ???????????? ?????????, ????????? ????????? ?????? ???????????? ???????????? ????????? ????????? ??? ????????????.',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          elevation: 24.0,
        ),
    );
  }
}