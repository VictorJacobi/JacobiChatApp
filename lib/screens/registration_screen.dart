import 'package:flash_chat/screens/MyButton.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = '/registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> with SingleTickerProviderStateMixin {

  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  bool obscure = true;
  AnimationController animation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animation = AnimationController(
        vsync: this,
        duration: Duration(
          seconds: 2,
        ));
    animation.forward();
    animation.addListener(() {
      setState(() {

      });
  });
        }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              child: Hero(
                tag: 'logo',
                child: Container(
                  height: animation.value*200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(
                color: Colors.black,
              ),
              onChanged: (value) {
                email=value;
              },
              decoration: kInputDecoration.copyWith(hintText: 'Enter your email'),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextField(
              textAlign: TextAlign.center,
              obscureText: true,
              style: TextStyle(
                color: Colors.black,
              ),
              onChanged: (value) {
                password=value;
              },
              decoration: kInputDecoration.copyWith(
                hintText: 'Enter your password',
                prefixIcon: TextButton(
                  onPressed: (){
                    setState((){
                      if (obscure==false){
                        obscure=true;
                      }
                      else{
                        obscure=false;
                      }
                    });
                    },
                  child: Icon(
                    obscure==false?Icons.lock_outline_rounded: Icons.lock_open,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            ReUsedButton(
              text: 'Register',
              onPressed: () async{
                try {
                  final newUser = await _auth.createUserWithEmailAndPassword(
                      email:
                      email, password: password);
                  if (newUser != null) {
                    Navigator.pushNamed(context, ChatScreen.id);
                  }
                }catch(e){
                  print(e);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
