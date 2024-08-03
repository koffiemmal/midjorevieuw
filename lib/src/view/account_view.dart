import 'package:flutter/material.dart';
import 'package:midjo/src/services/firebase_service.dart';
import 'package:midjo/src/states/userinfos.dart';
import 'package:midjo/src/view/login_view.dart';
import 'package:midjo/src/view_models/account_informations.dart';
import 'package:midjo/src/view/onboarding_view.dart';
import 'package:provider/provider.dart';

class AccountView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userDataProvider =
        Provider.of<UserDataProvider>(context, listen: true);

    if (userDataProvider.userData == null) {
      userDataProvider.loadUserData();
      return Scaffold(
        appBar: AppBar(),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final userData = userDataProvider.userData!;

    print('debuf');

    print(userData);

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${userData['Nom'] ?? ''} ${userData['Prenom'] ?? ''}",
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w600,
                          fontSize: 30),
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          'assets/images/profil.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              AccountInformations(
                title: "+228 ${userData['phoneNumber'] ?? ''}",
                subtitle: 'Numero',
                updatetype: 1,
              ),
              AccountInformations(
                title: "${userData['Nom'] ?? ''}",
                subtitle: 'Nom',
                updatetype: 2,
              ),
              AccountInformations(
                title: "${userData['email'] ?? ''}",
                subtitle: 'Email',
                updatetype: 3,
              ),
            ],
          ),
          InkWell(
            onTap: () {
              AuthFirebase.Singout();
              userDataProvider.clearUserData();

              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => OnboardingView()));
            },
            child: Container(
              margin: EdgeInsets.all(20),
              alignment: Alignment.centerLeft,
              child: Text(
                'Deconnexion',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/**
 * Container(
                  margin: EdgeInsets.all(20),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Se déconnecter du profil',
                    style: TextStyle(fontSize: 16),
                  ),
                )
 */