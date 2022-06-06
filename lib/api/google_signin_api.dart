import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInApi {
  static final _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ]
  );

  static Future<GoogleSignInAccount?> logIn() => _googleSignIn.signIn();
  static Future<GoogleSignInAccount?> logOut() => _googleSignIn.disconnect();
}