// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CarsTraject extends StatelessWidget {
  final String text;

  final String time;

  final Function function;

  const CarsTraject({
    Key? key,
    required this.text,
    required this.time,
    required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        function();
      },
      child: Container(
        margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
        padding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Color(0xff7152F3), blurRadius: 2, offset: Offset(0, 1))
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$text',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            Text('$time'),
            Image.asset('assets/images/busIcons.png')
          ],
        ),
      ),
    );
  }
}

class CarsLongTraject extends StatelessWidget {
  final String text;

  final String time;

  final Function function;

  const CarsLongTraject({
    Key? key,
    required this.text,
    required this.time,
    required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
           onTap: () {
        function();
      },
      child: Container(
        margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
        padding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 80),
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Color(0xff7152F3), blurRadius: 2, offset: Offset(0, 1))
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$text',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            Text('$time'),
            Image.asset('assets/images/busIcons.png')
          ],
        ),
      ),
    );
  }
}

class CommentCaMarche extends StatelessWidget {
  final String text;

  const CommentCaMarche({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      padding: EdgeInsets.only(bottom: 10, top: 5, left: 5),
      decoration: BoxDecoration(
          color: Color(0xff7152F3),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(164, 0, 0, 0),
                blurRadius: 2,
                offset: Offset(0, 1))
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 130,
            padding: EdgeInsets.only(left: 10),
            child: Text('$text',
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white)),
          ),
          Image.asset('assets/images/busIcons.png')
        ],
      ),
    );
  }
}
