import 'package:flutter/material.dart';

class SimpleRoundButton extends StatelessWidget{
  SimpleRoundButton({@required this.onPressed, @required this.buttonText, @required this.backgroundColor}); //constructor called BottomButton with two required inputs

  final Function()? onPressed; //property of type function that implements functionality
  final Text? buttonText; //property of type text that accounts for text on the button //it was previously of type string but string cant be assigned to parameter type widget
  final Color? backgroundColor; //property of type color that implements color on button

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 1.0),
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0))),
                overlayColor: MaterialStateProperty.all(this.backgroundColor),
                backgroundColor: MaterialStateProperty.all(this.backgroundColor),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: buttonText,
                  ),
                ],
              ),
              onPressed: () => onPressed!(),
            ),
          ),
        ],
      ),
    );
  }
}

