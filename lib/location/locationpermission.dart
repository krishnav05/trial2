// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:android_intent/android_intent.dart';
// import 'package:geolocator/geolocator.dart';

// class AskForPermission extends StatefulWidget {
//   @override
//   _AskForPermissionState createState() => _AskForPermissionState();
// }

// class _AskForPermissionState extends State<AskForPermission> {
//   //final PermissionHandler permissionHandler = PermissionHandler();
//   //Map<Permission, PermissionStatus> permissions;
//   void initState() {
//     super.initState();
//     // requestLocationPermission();
//     _gpsService();
//   }

// //  Future<bool> _requestPermission(PermissionGroup permission) async {
// // final PermissionHandler _permissionHandler = PermissionHandler();
// // var result = await _permissionHandler.requestPermissions([permission]);
// // if (result[permission] == PermissionStatus.granted) {
// //   return true;
// // }
// // return false;
// // }
// // /*Checking if your App has been Given Permission*/
// // Future<bool> requestLocationPermission({Function onPermissionDenied}) async {
// // var granted = await _requestPermission(Permission.location);
// // if (granted!=true) {
// //   requestLocationPermission();
// // }
// // debugPrint('requestContactsPermission $granted');
// // return granted;
// // }
// /*Show dialog if GPS not enabled and open settings location*/
//   Future _checkGps() async {
//     if (!(await Geolocator().isLocationServiceEnabled())) {
//       if (Theme.of(context).platform == TargetPlatform.android) {
//         showDialog(
//             context: context,
//             builder: (BuildContext context) {
//               return AlertDialog(
//                 title: Text("Can't get gurrent location"),
//                 content:
//                     const Text('Please make sure you enable GPS and try again'),
//                 actions: <Widget>[
//                   FlatButton(
//                       child: Text('Ok'),
//                       onPressed: () {
//                         final AndroidIntent intent = AndroidIntent(
//                             action:
//                                 'android.settings.LOCATION_SOURCE_SETTINGS');
//                         intent.launch();
//                         Navigator.of(context, rootNavigator: true).pop();
//                         _gpsService();
//                       })
//                 ],
//               );
//             });
//       }
//     }
//   }

// /*Check if gps service is enabled or not*/
//   Future _gpsService() async {
//     if (!(await Geolocator().isLocationServiceEnabled())) {
//       _checkGps();
//       return null;
//     } else
//       return true;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Ask for permisions'),
//           backgroundColor: Colors.red,
//         ),
//         body: Center(
//             child: Column(
//           children: <Widget>[
//             Text("All Permission Granted"),
//           ],
//         )));
//   }
// }

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:Ajreeha/Firsthome.dart';
// // void main() => runApp(MyApp());

// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       home: LocationDialog(),
// //     );
// //   }
// // }

// class LocationDialog extends StatefulWidget {
//   @override
//   _LocationDialogState createState() => _LocationDialogState();
// }

// class _LocationDialogState extends State<LocationDialog>
//     with SingleTickerProviderStateMixin {
//   PermissionStatus _status;

//   @override
//   void initState() {
//     runFirst();
//     super.initState();
//   }

//   runFirst() async {
// //await PermissionHandler()
// //        .checkPermissionStatus(PermissionGroup.locationWhenInUse)
// //        .then(_updateStatus);

//     /* PermissionHandle() deprecated in permission_handler: ^5.0.0+hotfix.3 */

//     await Permission.locationWhenInUse.status.then(_updateStatus);

//     await _requestPerms();
//     if (_status == PermissionStatus.granted) {
//       Navigator.push(
//           context, MaterialPageRoute(builder: (context) => FirstHome()));
//     } else if (_status == PermissionStatus.denied) {
//       SystemChannels.platform.invokeMethod('SystemNavigator.pop');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SpinKitFadingCircle(
//       itemBuilder: (BuildContext context, int index) {
//         return DecoratedBox(
//           decoration: BoxDecoration(
//             color: index.isEven ? Colors.red : Colors.green,
//           ),
//         );
//       },
//     );
//   }

//   void _requestPerms() async {
//     Map<Permission, PermissionStatus> statuses = await [
//       Permission.locationWhenInUse,
//       Permission.locationAlways
//     ].request();

//     if (await Permission.locationWhenInUse.serviceStatus.isEnabled) {
//       _updateStatus(PermissionStatus.granted);
//       // PermissionHandler().openAppSettings();
//       //  openAppSettings();
//     }

//     //  switch (status) {
//     //    case PermissionStatus.disabled:
//     //      await PermissionHandler().
//     //      break;
//     //  }
//     //  _updateStatus(status);
//     //  }
//   }

//   void _updateStatus(PermissionStatus value) {
//     setState(() {
//       _status = value;
//     });
//   }
// }

// class NextPage extends StatefulWidget {
//   @override
//   _NextPageState createState() => _NextPageState();
// }

// class _NextPageState extends State<NextPage> {
//   PermissionStatus _status;
//   @override
//   Widget build(BuildContext context) {
//     debugPrint('Location Status $_status');
//     return Scaffold(
//       body: SafeArea(
//           child: Column(
//         children: <Widget>[
//           Image.asset('assets/images/perm_icon_location.png'),
//           Text(
//             "LocationDialogHelper",
//           ),
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Text(
//               "locationDialogBody",
//               textAlign: TextAlign.center,
//             ),
//           ),
//           Expanded(
//             child: Align(
//               alignment: FractionalOffset.bottomCenter,
//               child: Container(
//                 width: double.infinity,
//                 padding: EdgeInsets.all(10.0),
//                 child: RaisedButton(
//                   color: Colors.black,
//                   onPressed: _requestPerms,
//                   padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
//                   child: Text(
//                     "allow",
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ),
//             ),
//           )
//         ],
//       )),
//     );
//   }

//   void _requestPerms() async {
//     Map<Permission, PermissionStatus> statuses = await [
//       Permission.locationWhenInUse,
//       Permission.locationAlways,
//     ].request();

//     final status = Permission.locationWhenInUse.serviceStatus;
//     _updateStatus(status);

// // switch (status) {
//     //     case PermissionStatus.disabled:
//     //       await PermissionHandler().openAppSettings();
//     //       break;
// //    }
// //    _updateStatus(status);
// //  }

//   }
//   void _updateStatus(PermissionStatus value) {
//       setState(() {
//         _status = value;
//       });
//     }
// }
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:android_intent/android_intent.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:Ajreeha/checkUser.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class AskForPermission extends StatefulWidget {
//   @override
//   _AskForPermissionState createState() => _AskForPermissionState();
// }

// class _AskForPermissionState extends State<AskForPermission> {
//   final PermissionHandler permissionHandler = PermissionHandler();
//   Map<PermissionGroup, PermissionStatus> permissions;

//   void initState() {
//     super.initState();
//     requestLocationPermission();
//     _gpsService();
//   }

//   Future<bool> _requestPermission(PermissionGroup permission) async {
//     final PermissionHandler _permissionHandler = PermissionHandler();
//     var result = await _permissionHandler.requestPermissions([permission]);
//     if (result[permission] == PermissionStatus.granted) {
//       return true;
//     }
//     return false;
//   }

//   // bool checklocation = false;
// /*Checking if your App has been Given Permission*/
//   Future<bool> requestLocationPermission({Function onPermissionDenied}) async {
//     var granted = await _requestPermission(PermissionGroup.location);
//     if (granted != true) {
//       requestLocationPermission();
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       prefs.setBool("loccheck", false);
//       // setState(() {
//       //   checklocation = false;

//       // });
//     }

//     debugPrint('requestContactsPermission $granted');
//     return granted;
//   }

// /*Show dialog if GPS not enabled and open settings location*/
//   Future _checkGps() async {
//     if (!(await Geolocator().isLocationServiceEnabled())) {
//       if (Theme.of(context).platform == TargetPlatform.android) {
//         showDialog(
//             context: context,
//             builder: (BuildContext context) {
//               return AlertDialog(
//                 title: Text("Can't get Current location"),
//                 content:
//                     const Text('Please make sure you enable GPS and try again'),
//                 actions: <Widget>[
//                   FlatButton(
//                       child: Text('Ok'),
//                       onPressed: () {
//                         final AndroidIntent intent = AndroidIntent(
//                             action:
//                                 'android.settings.LOCATION_SOURCE_SETTINGS');
//                         intent.launch();
//                         Navigator.of(context, rootNavigator: true).pop();
//                         _gpsService();
//                       })
//                 ],
//               );
//             });
//       }
//     }
//   }

// /*Check if gps service is enabled or not*/
//   Future _gpsService() async {
//     if (!(await Geolocator().isLocationServiceEnabled())) {
//       _checkGps();
//       return null;
//     } else
//       return true;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(body: Check());
//   }
// }
