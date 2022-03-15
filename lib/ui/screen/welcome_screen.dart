import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            Center(
                child: ListView(
              children: [
                const SizedBox(height: 40),
                SvgPicture.asset(
                  'assets/Logo-app.svg',
                  height: 300,
                  width: 300,
                  alignment: Alignment.topCenter,
                ),
                const SizedBox(height: 60),
                const Padding(
                  padding: EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0),
                  child: Text(
                    'BIENVENIDO',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0),
                  child: Text(
                    'Encuentra diferentes eventos culturales que se llevan a cabo en Cochabamba y mantente informado sobre tus eventos favoritos.',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0),
                  child: MaterialButton(
                    child: const Text(
                      'Comenzar',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    color: Colors.green[400],
                    height: 50,
                    minWidth: 90,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    onPressed: () =>
                        Navigator.pushNamed(context, 'login_screen'),
                  ),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
