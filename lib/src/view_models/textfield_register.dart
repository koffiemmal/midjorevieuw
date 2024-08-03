// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class TextfieldRegister extends StatelessWidget {
  final String label;

  final validator;

  const TextfieldRegister({
    Key? key,
    required this.label,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff7152F3))),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff7152F3)),
              borderRadius: BorderRadius.circular(15)),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff7152F3))),
          labelText: '$label',
          labelStyle: TextStyle(color: Color(0xff7152F3))),
    );
  }
}

class TextfieldsuffixIcon extends StatelessWidget {
  final Icon icones;

  const TextfieldsuffixIcon({
    Key? key,
    required this.icones,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          suffixIcon: icones,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff7152F3))),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff7152F3)),
              borderRadius: BorderRadius.circular(15)),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff7152F3))),
          labelText: ' Confirmed Password',
          labelStyle: TextStyle(color: Color(0xff7152F3))),
    );
  }
}
