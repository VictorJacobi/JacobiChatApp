import 'package:flutter/material.dart';

class ReUsedButton extends StatelessWidget {
  ReUsedButton({this.onPressed,this.text});
  final onPressed;
  final text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(30.0),
        elevation: 5.0,
        child: MaterialButton(
          onPressed: onPressed,//() {Navigator.pushNamed(context, RegistrationScreen.id); //Go to registration screen.},
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );

  }
}