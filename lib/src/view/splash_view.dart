import 'package:flutter/material.dart';
import 'package:midjo/src/services/firebase_service.dart';
import 'package:midjo/src/states/userinfos.dart';
import 'package:midjo/src/view/home_view.dart';
import 'package:midjo/src/view/onboarding_view.dart';
import 'package:provider/provider.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  bool _transitionLogo = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 4000), () {
      setState(() {
        _transitionLogo = true;
      });
    });
/*     Future.delayed(const Duration(milliseconds: 4500), () {
    /*   Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const OnboardingView())); */

         

          
    }); */
  }

  @override
  Widget build(BuildContext context) {
    final userDataProvider = Provider.of<UserDataProvider>(context);

    final userData = AuthFirebase.user;

  /*   print(userData!);

    print('provider');

    print(userDataProvider.userData); */

    if (userData != null) {
      Future.delayed(const Duration(milliseconds: 4500), () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomeView()));
      });
    } else {
      Future.delayed(const Duration(milliseconds: 4500), () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const OnboardingView()));
      });
    }

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(color: Color(0xff7152F3)),
        child: Stack(
          children: [
            Positioned.fill(
                top: 50,
                child: Center(
                    child: Image.asset('assets/images/logoopacity.png'))),
            Positioned(
              child: AnimatedSwitcher(
                  duration: const Duration(seconds: 1),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return ScaleTransition(scale: animation, child: child);
                  },
                  child: _transitionLogo
                      ? Center(child: Image.asset('assets/images/logoB.png'))
                      : Center(child: Image.asset('assets/images/logoA.png'))),
            )
          ],
        ),
      ),
    );
  }
}
