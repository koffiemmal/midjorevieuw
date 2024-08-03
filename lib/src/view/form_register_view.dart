// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:midjo/src/services/firebase_service.dart';
import 'package:midjo/src/states/userinfos.dart';
import 'package:midjo/src/view/home_view.dart';
import 'package:midjo/src/view/login_view.dart';
import 'package:midjo/src/view/register_view.dart';
import 'package:midjo/src/view_models/button_register.dart';
import 'package:provider/provider.dart';

class FormRegister extends StatefulWidget {
  const FormRegister({
    Key? key,
  }) : super(key: key);

  @override
  State<FormRegister> createState() => _FormRegisterState();
}

class _FormRegisterState extends State<FormRegister> {
  Future<void> methodRedirection() async {
    Future.delayed(Duration(milliseconds: 2000));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  bool _Activate = false;

  TextEditingController _Nom = TextEditingController();

  TextEditingController _prenom = TextEditingController();

  TextEditingController _phoneNumber = TextEditingController();

  TextEditingController _email = TextEditingController();

  TextEditingController _password = TextEditingController();

  TextEditingController _Confirmedpassword = TextEditingController();

  final _fromKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final userDataProvider = Provider.of<UserDataProvider>(context);

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
                if (value == null || value.isEmpty || value.length < 3) {
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
                  labelText: 'Prenom',
                  labelStyle: TextStyle(color: Color(0xff7152F3))),
            ),
            SizedBox(
              height: 19,
            ),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty || value.length < 8) {
                  return 'Numero incorrect';
                }
              },
              controller: _phoneNumber,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff7152F3))),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff7152F3)),
                      borderRadius: BorderRadius.circular(15)),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff7152F3))),
                  labelText: 'Numero',
                  labelStyle: TextStyle(color: Color(0xff7152F3))),
            ),
            SizedBox(
              height: 19,
            ),
            TextFormField(
              controller: _email,
              keyboardType: TextInputType.emailAddress,
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
              keyboardType: TextInputType.visiblePassword,
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
              height: 19,
            ),
            TextFormField(
              controller: _Confirmedpassword,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Confirmer le mot de passe';
                }
                if (_password.text != _Confirmedpassword.text) {
                  return 'Mot de passe non conforme';
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
                  labelText: 'Confirmer le mot de passe',
                  labelStyle: TextStyle(color: Color(0xff7152F3))),
            ),
            SizedBox(
              height: 50,
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
                    setState(() {
                      _Activate = true;
                    });

                               AuthFirebase.testConnectSuccessAfterCreateAccount(
                        nom: _Nom.text.trim(),
                        prenom: _prenom.text.trim(),
                        phoneNumber: _phoneNumber.text.trim(),
                        email: _email.text.trim(),
                        password: _password.text.trim());
                    ;

                   

                   // AuthFirebase.SignIn(
                      //  _email.text.trim(), _password.text.trim());

                    Future.delayed(Duration(milliseconds: 4000), () {
                    

                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => HomeView())));
                    });
                  }
                },
                child: _Activate
                    ? CircularProgressIndicator()
                    : Text(
                        "S'incrire",
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
              redirection: LoginView(),
              couleurfond: Colors.white,
              couleurtext: Color(0xff7152F3),
              text: 'Connexion',
              BorderCouleur: Color(0xff7152F3),
            )
          ],
        ));
  }
}
