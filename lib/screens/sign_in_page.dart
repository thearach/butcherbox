import 'package:butcherbox/butch_widgets/butch_button.dart';
import 'package:butcherbox/screens/landing_page.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                colorFilter: ColorFilter.mode(Colors.black12, BlendMode.darken),
                fit: BoxFit.fill,
                image: AssetImage('images/butchboxbgimage.png'))),
        child: Column(
          children: <Widget>[
            Container(
                child: Image(
              alignment: Alignment.center,
              image: AssetImage('images/greenlogoback.png'),
            )),
            Expanded(
                flex: 1, child: Image(image: AssetImage('images/welcome.png'))),
            ButcherButtons(
              buttonText: 'GET STARTED',
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LandingPage()));
              },
            ),
            SizedBox(height: 50.0)
          ],
        ),
      ),
    );
  }
}
