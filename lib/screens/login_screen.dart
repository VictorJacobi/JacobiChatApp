import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import'MyButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static const String id = '/login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
 // bool obscure=false;
  bool inAsyncCall =false;
  final _auth = FirebaseAuth.instance;
  String email;
  bool obscure = true;
  String password;
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
      body: ModalProgressHUD(
        inAsyncCall: inAsyncCall,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: animation.value*200,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 25.0,
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
                decoration: kInputDecoration.copyWith(
                  hintText: 'Enter your email',
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                obscureText: obscure,
                style: TextStyle(
                  color: Colors.black,
                ),
                onChanged: (value) {
                  password=value;
                },
                decoration: kInputDecoration.copyWith(
                    hintText: 'Enter your password.',
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
                text: 'Log in',
                onPressed: () async{
                  setState(() {
                    inAsyncCall=true;
                  });
              try {
              final user = await _auth.signInWithEmailAndPassword(
              email: email
              , password: password);
              if (user != null) {
              Navigator.pushNamed(context, ChatScreen.id);
              setState((){inAsyncCall=false;});
              }
              }catch(e){
              print(e);
              }
                  setState(() {
                    inAsyncCall=false;
                  });

                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
