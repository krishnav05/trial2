import 'dart:async';
import 'package:Ajreeha/checkUser.dart';
import 'package:Ajreeha/location/locationpermission.dart';
import 'package:flutter/material.dart';
import 'package:Ajreeha/onboarding.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:location/location.dart' as loc;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  loc.Location location =
      loc.Location(); //explicit reference to the Location class
  Future _checkGps() async {
    if (!await location.serviceEnabled()) {
      location.requestService();
    }
  }

  @override
  void initState() {
    super.initState();
    _checkGps();
    Timer(
        Duration(seconds: 5),
        () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Check
                    // AskForPermission
                    ())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        child: Container(
            child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  child: new CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 100,
                child: SvgPicture.asset('assets/images/svg_logo_ajerrha.svg'),
              )),
            ],
          ),
        )),
      ),
    );
  }
}
