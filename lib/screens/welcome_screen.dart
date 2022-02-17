import 'package:flash_chat/screens/MyButton.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = '/welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Flexible(
                    child: Hero(
                      tag: 'logo',
                      child: Container(
                        child: Image.asset('images/logo.png'),
                        height: 60.0,
                      ),
                    ),
                  ),
          AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText(
                'Jacobi Chat',
                textStyle: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                speed: Duration(milliseconds: 200),
              ),
            ],
            repeatForever: true,
          ),
                ],
              ),
              SizedBox(
                height: 48.0,
              ),
              ReUsedButton(
                onPressed: (){
                  Navigator.pushNamed(context, LoginScreen.id);//Go to login screen.
                },
                text: 'Log in',
              ),
              ReUsedButton(
                onPressed: (){

                  Navigator.pushNamed(context, RegistrationScreen.id); //Go to registration screen.// Navigator.pushNamed(context, LoginScreen.id);//Go to login screen.
                },
                text: 'Register',
              )
            ],
          ),
        ),
      ),
    );
  }
}
