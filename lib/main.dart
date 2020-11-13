import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() {
  runApp(MaterialApp(home: SignInWithGoogle()));
}

class SignInWithGoogle extends StatefulWidget {
  @override
  _SignInWithGoogleState createState() => _SignInWithGoogleState();
}

class _SignInWithGoogleState extends State<SignInWithGoogle> {
  bool _isLoggedin = false;
  GoogleSignInAccount _currentUser;
  String _contactText;
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoggedin
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 100.0,
                  width: 100.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    image: DecorationImage(
                      image: NetworkImage(_googleSignIn.currentUser.photoUrl),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text('${_googleSignIn.currentUser.email}'),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text('${_googleSignIn.currentUser.displayName}'),
                ),
                Container(
                  alignment: Alignment.center,
                  child: RaisedButton(
                    child: Text('SignOut'),
                    onPressed: () {
                      print('sign out pressed');
                      _signOut();
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text('Logged in successfully'),
                )
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: RaisedButton(
                    child: Text('Sign in with google'),
                    onPressed: () {
                      print('sign in pressed');
                      _handleSignIn();
                    },
                  ),
                )
              ],
            ),
    );
  }

  _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
      setState(() {
        _isLoggedin = true;
      });
    } catch (error) {
      print(error);
    }
  }

  _signOut() {
    _googleSignIn.signOut();
    setState(() {
      _isLoggedin = false;
    });
  }
}
