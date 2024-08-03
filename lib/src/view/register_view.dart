import 'package:flutter/material.dart';
import 'package:midjo/src/view/form_register_view.dart';
import 'package:midjo/src/view/login_view.dart';
import 'package:midjo/src/view_models/button_register.dart';
import 'package:midjo/src/view_models/textfield_register.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {

    

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
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
                        'Inscription',
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(
                        'Entrer vos informations',
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
                FormRegister(),
              
              ],
            ),
          ),
        ),
      ),
    );
  }
}
