import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:midjo/src/view/form_login_view.dart';
import 'package:midjo/src/view/home_view.dart';
import 'package:midjo/src/view/register_view.dart';
import 'package:midjo/src/view_models/button_register.dart';
import 'package:midjo/src/view_models/textfield_register.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool _isRemember = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Stack(
          children: [
            Positioned.fill(
                child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: Image.asset(
                      'assets/images/formbck.png',
                      fit: BoxFit.cover,
                    ))),
            Container(
              padding: EdgeInsets.all(40),
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Image.asset('assets/images/logopurple.png'),
                    ),
                    Container(
                      width: double.infinity,
                      child: Column(
                        children: [
                          Text(
                            'Bienvenue',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            'Veuillez entrer vos informations',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    FormLogin()
                   
                  
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
