// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ButtonRegister extends StatelessWidget {
  final Color couleurfond;

  final Color couleurtext;

  final Color BorderCouleur;

  final String text;

  final Widget redirection;

  const ButtonRegister({
    Key? key,
    required this.couleurfond,
    required this.couleurtext,
    required this.BorderCouleur,
    required this.text,
    required this.redirection,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 200,
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          border: Border.all(color: BorderCouleur),
          color: couleurfond,
          borderRadius: BorderRadius.circular(30)),
      child: MaterialButton(
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => redirection));
        },
        child: Text(
          '$text',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: couleurtext),
        ),
      ),
    );
  }
}
