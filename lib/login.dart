import 'package:flutter/material.dart';
import 'package:hello_world/auth.dart';
import 'package:hello_world/myHomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text('Hello World!')), 
          body: Body());
  }
}

class Body extends StatefulWidget {


  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  User? user;

  
  void click() {
    signInWithGoogle().then((user) => {
      this.user = user,
      Navigator.push(context, 
        MaterialPageRoute(builder: (context) => MyHomePage(user?.displayName?? '')))
    });
  }

  Widget googleLoginButton()  {
    return OutlinedButton(
      onPressed: this.click,
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
        side: BorderSide(color: Colors.grey),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center, 
          children: <Widget>[
            Image(image: AssetImage('assets/google_logo.png'), height: 35),
            Padding(
              padding: EdgeInsets.only(left:10), 
              child: Text(
                'Sign in with Google', 
                style: TextStyle(color: Colors.grey, fontSize: 25)
              ),
            ),
          ],
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.center, child: googleLoginButton());
  }
} 

