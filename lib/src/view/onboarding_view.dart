import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:midjo/src/services/firebase_service.dart';
import 'package:midjo/src/states/userinfos.dart';
import 'package:midjo/src/view/home_view.dart';
import 'package:midjo/src/view/login_view.dart';
import 'package:midjo/src/view/register_view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _pageController = PageController();

  int _currentPage = 0;

  void _SauterMethod() {
    int lastPage = 4; // Définir manuellement le nombre total de pages
    _pageController.animateToPage(
      lastPage,
      duration: Duration(milliseconds: 300), // Durée de l'animation
      curve: Curves.bounceInOut, // Courbe de l'animation
    );
  }

  void _NextPageMethod() {
    if (_currentPage >= 0 && _currentPage != 3) {
      _pageController.animateToPage(_currentPage + 1,
          duration: const Duration(milliseconds: 100), curve: Curves.bounceIn);
    }
  }

  Future<void> _checkAuthStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      // Rediriger vers HomeView si l'utilisateur est déjà connecté
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeView()),
      );
    } else {
      // Rediriger vers RegisterView si l'utilisateur n'est pas connecté
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const RegisterView()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = AuthFirebase.user;

    final userDataProvider = Provider.of<UserDataProvider>(context);

    void method() async {
// Obtain shared preferences.

      final SharedPreferences prefs = await SharedPreferences.getInstance();

      int counter = prefs.getInt('counter') ?? 0;

      print(user!.email);

      counter++;

      await prefs.setInt('counter', counter);

      print(counter);

      if (counter >= 1 && userDataProvider.userData != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeView()),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RegisterView()),
        );
      }
    }

    void ConnexionMethod()  {
     /*  final SharedPreferences prefs = await SharedPreferences.getInstance();

      int counter = prefs.getInt('counter') ?? 0;

      print(user!.email);

      counter++;

      await prefs.setInt('counter', counter);

      print(counter); */

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginView()));

      /*    if (counter >= 1 && user != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeView()),
        );

        print('compte dans provider trouver');
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginView()),
        );

         print('compte dans provider non trouver');
      } */
    }

    /**
   *   void navigateHome(bool firstNav) {
      if (firstNav && AuthFirebase.user != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeView()),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RegisterView()),
        );
      }
    }
   */

    return Scaffold(
      body: Column(
        children: [
          // SizedBox(
          // height: MediaQuery.of(context).size.height * 0.9,
          // child: Expanded(
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (int value) {
                      setState(() {
                        _currentPage = value;
                      });
                    },
                    children: [
                      Image.asset(
                        'assets/images/ob1.png',
                      ),
                      Image.asset(
                        'assets/images/ob2.png',
                      ),
                      Image.asset(
                        'assets/images/ob3.png',
                      ),
                      Image.asset(
                        'assets/images/ob5.png',
                      ),
                    ],
                  ),
                ),
                Positioned(
                    bottom: 0,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xfff7152F3),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50))),
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        //    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 50,
                            margin: const EdgeInsets.all(3),
                            child: SmoothPageIndicator(
                              controller: _pageController,
                              count: 4,
                              axisDirection: Axis.horizontal,
                              effect: const SlideEffect(
                                  spacing: 8.0,
                                  radius: 10.0,
                                  dotWidth: 15.0,
                                  dotHeight: 15.0,
                                  paintStyle: PaintingStyle.stroke,
                                  strokeWidth: 1.5,
                                  dotColor: Colors.white,
                                  activeDotColor: Colors.indigo),
                            ),
                          ),
                          if (_currentPage == 0 || _currentPage == 1 || _currentPage == 2 ) SizedBox(
                            height: 90,
                            child: Image.asset('assets/images/logoB.png'),
                          ) ,
                          SizedBox(
                              width: 320,
                              child: _currentPage == 0
                                  ? SizedBox(
                                      height: 190,
                                      child: Center(
                                        child: Text(
                                          'La premiere application de transport de bus au togo',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    )
                                  : _currentPage == 1
                                      ? Column(
                                          children: [
                                            Text('Bienvenue sur Midjo',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 24,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              'Découvrez une nouvelle manière de naviguer dans votre ville. Midjo vous aide à trouver facilement les arrêts de bus et à planifier vos trajets en toute simplicité.',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        )
                                      : _currentPage == 2
                                          ? Column(
                                              children: [
                                                Text(
                                                    'Trouvez les arrêts de bus à proximité',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  'Grâce à Midjo, repérez rapidement les points de stationnement des bus autour de vous. Ne perdez plus de temps à chercher votre arrêt !',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            )
                                          : _currentPage == 3
                                              ? Column(
                                                  children: [],
                                                )
                                              : null),
                          SizedBox(
                            height: 20,
                          ),
                          _currentPage > 2
                              ? Container(
                                height: 350,
                             margin: EdgeInsets.only(left: 6,right: 6),
                                child: Column(
                                   
                                    children: [
                                
                                         Text(
                                                      'Prets',
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 35,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                              Text('À simplifier vos trajets ?',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 35,
                                              fontWeight: FontWeight.w400)),
                                                  SizedBox(
                                                    height: 25,
                                                  ),
                                                  Text(
                                                    'Rejoignez Midjo pour une expérience de transport fluide et sans stress',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  )
                                ,
                                        SizedBox(
                                        height: 20,
                                      ),
                                      ElevatedButton(
                                          onPressed: () {
                                            ConnexionMethod();
                                          },
                                          style: ElevatedButton.styleFrom(
                                            fixedSize: const Size(250, 55),
                                            backgroundColor: Color(0xfff100344),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                            ),
                                          ),
                                          child: const Text(
                                            'Connexion',
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                            ),
                                          )),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        RegisterView()));
                                          },
                                          style: ElevatedButton.styleFrom(
                                            fixedSize: const Size(250, 55),
                                            backgroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                            ),
                                          ),
                                          child: const Text(
                                            "S'inscrire",
                                            style: TextStyle(
                                              color: Color(0xfff7152F3),
                                            ),
                                          ))
                                    ],
                                  ),
                              )
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ElevatedButton(
                                        onPressed: () {
                                          _SauterMethod();
                                        },
                                        style: ElevatedButton.styleFrom(
                                          fixedSize: const Size(150, 55),
                                          backgroundColor: Color(0xfff100344),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(40),
                                          ),
                                        ),
                                        child: const Text(
                                          'Sauter',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        )),
                                    ElevatedButton(
                                        onPressed: () {
                                          _NextPageMethod();
                                        },
                                        style: ElevatedButton.styleFrom(
                                          fixedSize: const Size(150, 55),
                                          backgroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(40),
                                          ),
                                        ),
                                        child: const Text(
                                          'Suivant',
                                          style: TextStyle(
                                            color: Color(0xfff7152F3),
                                          ),
                                        ))
                                  ],
                                )
                        ],
                      ),
                    ))
              ],
            ),
          ),
          /**
           *       Container(
            height: MediaQuery.of(context).size.height * 0.1,
            margin: const EdgeInsets.all(3),
            child: SmoothPageIndicator(
              controller: _pageController,
              count: 2,
              axisDirection: Axis.horizontal,
              effect: const SlideEffect(
                  spacing: 8.0,
                  radius: 10.0,
                  dotWidth: 15.0,
                  dotHeight: 15.0,
                  paintStyle: PaintingStyle.stroke,
                  strokeWidth: 1.5,
                  dotColor: Colors.grey,
                  activeDotColor: Colors.indigo),
            ),
          )
           */
          // ),

          //   Container(
          //     height: 40,
          //     width: 200,
          //     margin: const EdgeInsets.all(5),
          //     decoration: BoxDecoration(
          //        color: const Color(0xff7152F3),
          //        borderRadius: BorderRadius.circular(5)),
          //    child: MaterialButton(
          //      onPressed: _NextPageMethod,
          //     child: Text(
          //       _currentPage == 1 ? 'Staring' : 'Next',
          //       style: const TextStyle(
          //           fontWeight: FontWeight.bold,
          //            fontSize: 14,
          //            color: Colors.white),
          //     ),
          //   ),
          //  )
        ],
      ),
    );
  }
}
