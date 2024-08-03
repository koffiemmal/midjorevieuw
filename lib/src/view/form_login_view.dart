// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:midjo/src/services/firebase_service.dart';
import 'package:midjo/src/view/home_view.dart';
import 'package:midjo/src/view/login_view.dart';
import 'package:midjo/src/view/register_view.dart';
import 'package:midjo/src/view_models/button_register.dart';

class FormLogin extends StatefulWidget {
  const FormLogin({
    Key? key,
  }) : super(key: key);

  @override
  State<FormLogin> createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  TextEditingController _Nom = TextEditingController();

  TextEditingController _prenom = TextEditingController();

  TextEditingController _email = TextEditingController();

  TextEditingController _password = TextEditingController();

  final _fromKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _fromKey,
        child: Column(
          children: [
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty || value.length < 2) {
                  return 'Nom incorrect';
                }
              },
              controller: _Nom,
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
                  labelText: 'Nom',
                  labelStyle: TextStyle(color: Color(0xff7152F3))),
            ),
            SizedBox(
              height: 19,
            ),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty || value.length < 5) {
                  return 'Prenom incorrect';
                }
              },
              controller: _prenom,
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
                  labelText: 'prenom',
                  labelStyle: TextStyle(color: Color(0xff7152F3))),
            ),
            SizedBox(
              height: 19,
            ),
            TextFormField(
              controller: _email,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'entrer un email';
                }
                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                  return ' entrer une adresse email valide';
                }
              },
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
                  labelText: 'adresse email',
                  labelStyle: TextStyle(color: Color(0xff7152F3))),
            ),
            SizedBox(
              height: 19,
            ),
            TextFormField(
              controller: _password,
              validator: (value) {
                if (value == null || value.isEmpty || value.length < 8) {
                  return 'password invalide';
                }
              },
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
                  labelText: 'mot de passe',
                  labelStyle: TextStyle(color: Color(0xff7152F3))),
            ),
            SizedBox(
              height: 60,
            ),
            Container(
              height: 40,
              width: 200,
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xff7152F3)),
                  color: Color(0xff7152F3),
                  borderRadius: BorderRadius.circular(30)),
              child: MaterialButton(
                onPressed: () {
                  if (_fromKey.currentState!.validate()) {
                    AuthFirebase.Login(
                        _email.text.trim(), _password.text.trim());
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => HomeView()));
                  }
                },
                child: Text(
                  'Connexion',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            ButtonRegister(
              redirection: RegisterView(),
              couleurfond: Colors.white,
              couleurtext: Color(0xff7152F3),
              text: "S'inscire",
              BorderCouleur: Color(0xff7152F3),
            )
          ],
        ));
  }
}
