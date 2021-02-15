import 'dart:convert';
import 'package:Ajreeha/Drawer%20screen/myrent.dart';
import 'package:Ajreeha/Drawer%20screen/myvehicles.dart';
import 'package:Ajreeha/Drawer%20screen/sendus.dart';
import 'package:Ajreeha/Firsthome.dart';
import 'package:Ajreeha/localization/App_localization.dart';
import 'package:Ajreeha/login/loginui.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'Drawer screen/mybooking.dart';
import 'localization/AppLanguage.dart';
import 'package:Ajreeha/Settings.dart';

class Drawers extends StatefulWidget {
  @override
  _DrawersState createState() => _DrawersState();
}

class _DrawersState extends State<Drawers> {
  bool tokencheck = false;
  String tokenchec;
  SharedPreferences prefs;
  String userNamelogin;
  getStringValuesSF() async {
    prefs = await SharedPreferences.getInstance();
    //Return String
    print(tokenchec);
    tokenchec = prefs.getString('value_key');
    userNamelogin = prefs.getString('UserName');

    if (tokenchec == "") {
      print("null" + tokenchec);
      setState(() {
        tokencheck = false;
      });
    } else {
      print("else" + tokenchec);
      setState(() {
        tokencheck = true;
      });
    }

    print("drawer" + tokenchec);
    print(userNamelogin);
  }

  @override
  void initState() {
    getStringValuesSF();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var appLanguage = Provider.of<AppLanguage>(context);
    return ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: <Widget>[
        Container(
          height: 0.082 * MediaQuery.of(context).size.height +
              MediaQuery.of(context).padding.top,
          child: DrawerHeader(
            child: Row(
              children: [
                Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 0.04 * MediaQuery.of(context).size.width,
                ),
                tokencheck
                    ? Text(
                        userNamelogin,
                        textScaleFactor: 1,
                        style: TextStyle(
                            fontSize: ResponsiveFlutter.of(context).wp(6),
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Tajawal',
                            color: Colors.white),
                      )
                    : FlatButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginUi()),
                          );
                        },
                        child: Text(
                          "Login / Signup",
                          textScaleFactor: 1,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Tajawal',
                            fontSize: ResponsiveFlutter.of(context).fontSize(2),
                          ),
                        ),
                      )
              ],
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xFF042E6F), Color(0xFF00BAF2)]),
            ),
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.home_outlined,
            color: Color(0xFF00BAF2),
          ),
          title: Text(
            AppLocalizations.of(context).translate(
              'drawer_home',
            ),
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: 'Tajawal'),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FirstHome()),
            );
          },
        ),
        ListTile(
          leading: Icon(
            Icons.list,
            color: Color(0xFF00BAF2),
          ),
          title: Text(
            AppLocalizations.of(context).translate(
              'drawer_booking',
            ),
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: 'Tajawal'),
          ),
          onTap: () {
            Navigator.pop(context);

            tokencheck
                ? Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyBooking()),
                  )
                : Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginUi()),
                  );
          },
        ),
        ListTile(
          leading: Icon(
            Icons.directions_car_outlined,
            color: Color(0xFF00BAF2),
          ),
          title: Text(
            AppLocalizations.of(context).translate(
              'drawer_vehicles',
            ),
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: 'Tajawal'),
          ),
          onTap: () {
            Navigator.pop(context);

            tokencheck
                ? Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyVehicles()),
                  )
                : Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginUi()),
                  );
          },
        ),
        ListTile(
          leading: Icon(
            Icons.attach_money_sharp,
            color: Color(0xFF00BAF2),
          ),
          title: Text(
            AppLocalizations.of(context).translate(
              'drawer_rent',
            ),
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: 'Tajawal'),
          ),
          onTap: () {
            Navigator.pop(context);

            tokencheck
                ? Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyRent()),
                  )
                : Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginUi()),
                  );
          },
        ),
        ListTile(
          leading: Icon(
            Icons.info_outline,
            color: Color(0xFF00BAF2),
          ),
          title: Text(
            AppLocalizations.of(context).translate(
              'drawer_about',
            ),
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: 'Tajawal'),
          ),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(
            Icons.mail_outline,
            color: Color(0xFF00BAF2),
          ),
          title: Text(
            AppLocalizations.of(context).translate(
              'drawer_send',
            ),
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: 'Tajawal'),
          ),
          onTap: () {
            Navigator.pop(context);

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SendUs()),
            );
          },
        ),
        ListTile(
            leading: Icon(
              Icons.logout,
              color: Color(0xFF00BAF2),
            ),
            title: tokencheck
                ? InkWell(
                    child: Text(
                      AppLocalizations.of(context).translate('drawer_sign_out'),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Tajawal',
                      ),
                    ),
                    onTap: () {
                      http.get('https://ajerrha.com/api/sanctum/logout',
                          headers: {
                            'Content-Type': 'application/json',
                            'Authorization': 'Bearer ' + tokenchec,
                          }).then((response) {
                        var tokenchange = jsonDecode(response.body);
                        print("check" + tokenchange);
                        if (tokenchange == "true") {
                          setState(() {
                            getStringValuesSF();
                            prefs.setString('value_key', "");
                            prefs.setString('UserName', "");

                            tokencheck = false;
                          });
                        }
                        Navigator.pop(context);
                      });
                    })
                : InkWell(
                    child: Text(
                      AppLocalizations.of(context).translate('drawer_sign_in'),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Tajawal',
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginUi()),
                      );
                    },
                  )),
        ListTile(
            leading: Icon(
              Icons.language_outlined,
              color: Color(0xFF00BAF2),
            ),
            title: Row(
              children: <Widget>[
                SizedBox(
                  width: 60,
                  child: MaterialButton(
                      color: Color(0xff00BAF2),
                      child: Text(
                        AppLocalizations.of(context).translate(
                          'English',
                        ),
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Tajawal',
                            color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        appLanguage.changeLanguage(Locale("en"));
                      }),
                ),
                SizedBox(width: 2),
                SizedBox(
                  width: 65,
                  child: MaterialButton(
                    color: Color(0xff00BAF2),
                    child: Text(
                      AppLocalizations.of(context).translate(
                        'Arabic',
                      ),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Tajawal',
                          color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      appLanguage.changeLanguage(Locale("ar"));
                    },
                  ),
                ),
              ],
            )),
        ListTile(
          leading: Icon(
            Icons.settings,
            color: Color(0xFF00BAF2),
          ),
          title: InkWell(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Setting()),
              );
            },
            child: Text(
              AppLocalizations.of(context).translate(
                'drawer_settings',
              ),
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Tajawal'),
            ),
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.help_outline,
            color: Color(0xFF00BAF2),
          ),
          title: Text(
            AppLocalizations.of(context).translate(
              'drawer_help',
            ),
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: 'Tajawal'),
          ),
        ),
      ],
    );
  }
}
