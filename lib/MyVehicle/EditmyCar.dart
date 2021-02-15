import 'package:Ajreeha/MyVehicle/MyVehiclecards.dart';
import 'package:Ajreeha/localization/App_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:Ajreeha/MyVehicle/repositary.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'MyVehiclecards.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:typed_data';

class EditmyCar extends StatefulWidget {
  final String vehicaleid;
  // // final String vid;
  // const  EditmyCar(this.vehicaleid);
  EditmyCar({Key key, this.vehicaleid}) : super(key: key);
  @override
  _EditmyCarState createState() => _EditmyCarState();
}

class _EditmyCarState extends State<EditmyCar> {
/*--------------------------------------------------------------------------------------------------------------------------------------------- -------------------*/

  GlobalKey<FormState> _form = GlobalKey<FormState>();
  TextEditingController colorcontroller = TextEditingController();
  TextEditingController rentcontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  TextEditingController insuranceexpirycontroller = TextEditingController();
  TextEditingController mileagecontroller = TextEditingController();
  TextEditingController conditioncontroller = TextEditingController();

/*--------------------------------------------------------------------------------------------------------------------------------------------- -------------------*/

/*--------------------------------------------------------------------------------------------------------------------------------------------- -------------------*/

  TextEditingController middleRightSidecontroller = TextEditingController();
  TextEditingController backRightSidecontroller = TextEditingController();
  TextEditingController frontRightSidecontroller = TextEditingController();

  TextEditingController middleLeftSidecontroller = TextEditingController();
  TextEditingController backLeftSidecontroller = TextEditingController();
  TextEditingController frontLeftSidecontroller = TextEditingController();

/*--------------------------------------------------------------------------------------------------------------------------------------------- -------------------*/
  bool isloding = false;
/*--------------------------------------------------------------------------------------------------------------------------------------------- -------------------*/
  String value_keytoken;
  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    value_keytoken = prefs.getString('value_key');
    dir = (await getApplicationDocumentsDirectory()).path;
    // isregister = register.isNotEmpty; //verify gives true only
    print(value_keytoken);
    getdata();
  }

/*--------------------------------------------------------------------------------------------------------------------------------------------- -------------------*/

/*--------------------------------------------------------------------------------------------------------------------------------------------- -------------------*/
//  bool datacoming = false;
  String dir;

  getdata() async {
    print("getdata" + value_keytoken);
    print("id" + widget.vehicaleid);
    await http.post(
      'https://ajerrha.com/api/fetch/vehicle/details',
      body: jsonEncode({
        "vehicaleid": widget.vehicaleid.toString(),
      }),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + value_keytoken
      },
    ).then((response) async {
      var res = json.decode(response.body);
      print(response.body);
      // print(res['status']);
      // print(res['data'][0]);
      var data = Job.fromJson(res['data'][0]);

      // print("${data.id}");
      // print("${data.vehicleColor}");

      if (res["status"] == "success") {
        setState(
          () {
            //  datacoming = true;
            colorcontroller.text = data.vehicleColor;
            rentcontroller.text = data.vehicleRentPerDay;
            descriptioncontroller.text = data.vehicleDescription;
            insuranceexpirycontroller.text =
                data.vehicleInsuranceExpireDate.toString().substring(0, 10);
            mileagecontroller.text = data.vehicleMileage;

            conditioncontroller.text = data.vehicleCondition;

            _selectedState = data.vehicleType;
            _selectedLGA = data.vehicleModel;
            // _lgas=data.vehicleType;

            _lgas = List.from(_lgas)
              ..addAll(repo.getLocalByState(data.vehicleType));
            vehicaleyear = data.vehicleYear;
            vehicaledoor = data.vehicleDoor;
            vehicaleseat = data.vehicleSeatCapacity;

/*--------------------------------------------------------------------------------------------------------------------------------------------- -------------------*/
//7
            Uint8List bytes7 = base64.decode(data.image1_encode);
            photo647 = data.image1_encode.toString();
            photopath70 = data.image1Name;

            _image7 = File("$dir/" + data.image1Name);
            _image7.writeAsBytes(bytes7);
            print("7" + _image7.toString());
            print("photo647" + photo647);
            print("photopath70" + photopath70);

/*--------------------------------------------------------------------------------------------------------------------------------------------- -------------------*/
//8

            Uint8List bytes8 = base64.decode(data.image2_encode);

            photo648 = data.image2_encode.toString();
            photopath80 = data.image2Name;

            _image8 = File("$dir/" + data.image2Name);
            _image8.writeAsBytes(bytes8);

/*--------------------------------------------------------------------------------------------------------------------------------------------- -------------------*/
            // 9
            Uint8List bytes9 = base64.decode(data.image3_encode);

            photo649 = data.image3_encode.toString();
            photopath90 = data.image3Name;

            _image9 = File("$dir/" + data.image3Name);
            _image9.writeAsBytes(bytes9);

/*--------------------------------------------------------------------------------------------------------------------------------------------- -------------------*/
            // 10
            Uint8List bytes10 = base64.decode(data.image4_encode);

            photo6410 = data.image4_encode.toString();
            photopath100 = data.image4Name;

            _image10 = File("$dir/" + data.image4Name);
            _image10.writeAsBytes(bytes10);

/*--------------------------------------------------------------------------------------------------------------------------------------------- -------------------*/
// 1
            Uint8List bytes1 = base64.decode(data.front_left_encode);

            print("photo641" + photo641);
            print("photopath101" + photopath101);
            print("_image1" + _image1.toString());

            // if (data.front_left_encode == null) {
            //   photo641 = null;
            //   photopath101 = null;
            // } else {
            photo641 = data.front_left_encode.toString();
            photopath101 = data.front_left_encode;
            _image1 = File("$dir/" + data.front_left_encode);
            _image1.writeAsBytes(bytes1);
            //   }

/*--------------------------------------------------------------------------------------------------------------------------------------------- -------------------*/
            Uint8List bytes2 = base64.decode(data.front_right_encode);

            // if (data.front_right_encode == null) {
            //   photo642 = null;
            //   photopath20 = null;
            // } else {
            photo642 = data.front_right_encode.toString();
            photopath20 = data.front_right_encode;
            _image2 = File("$dir/" + data.front_right_encode);
            _image2.writeAsBytes(bytes2);
            // }

/*--------------------------------------------------------------------------------------------------------------------------------------------- -------------------*/
            Uint8List bytes3 = base64.decode(data.middle_left_encode);

            // if (data.middle_left_encode == null) {
            //   photo643 = null;
            //   photopath30 = null;
            // } else {
            photo643 = data.middle_left_encode.toString();
            photopath30 = data.middle_left_encode;

            _image3 = File("$dir/" + data.middle_left_encode);
            _image3.writeAsBytes(bytes3);
            //  }

/*--------------------------------------------------------------------------------------------------------------------------------------------- -------------------*/
            Uint8List bytes4 = base64.decode(data.middle_right_encode);

            // if (data.middle_right_encode == null) {
            //   photo644 = null;
            //   photopath40 = null;
            // } else {
            photo644 = data.middle_right_encode.toString();
            photopath40 = data.middle_right_encode;

            _image4 = File("$dir/" + data.middle_right_encode);
            _image4.writeAsBytes(bytes4);
            // }

/*--------------------------------------------------------------------------------------------------------------------------------------------- -------------------*/
            Uint8List bytes5 = base64.decode(data.back_left_encode);
            // if (data.back_left_encode == null) {
            //   photo645 = null;
            //   photopath50 = null;
            // } else {
            photo645 = data.back_left_encode.toString();
            photopath50 = data.back_left_encode;

            _image5 = File("$dir/" + data.back_left_encode);
            _image5.writeAsBytes(bytes5);
            //  }

/*--------------------------------------------------------------------------------------------------------------------------------------------- -------------------*/
            Uint8List bytes6 = base64.decode(data.back_right_encode);
            // if (data.back_right_encode == null) {
            //   photo646 = null;
            //   photopath60 = null;
            // } else {
            photo646 = data.back_right_encode.toString();
            photopath60 = data.back_right_encode;

            _image6 = File("$dir/" + data.back_right_encode);
            _image6.writeAsBytes(bytes6);
            // }

/*--------------------------------------------------------------------------------------------------------------------------------------------- -------------------*/

            middleRightSidecontroller.text = data.middleRightSideText;
            backRightSidecontroller.text = data.backRightSideText;
            frontRightSidecontroller.text = data.frontRightSideText;
            middleLeftSidecontroller.text = data.middleLeftSideText;
            backLeftSidecontroller.text = data.backLeftSideText;
            frontLeftSidecontroller.text = data.frontLeftSideText;

            mymarker = [];
            mymarker.add(
              Marker(
                  markerId: MarkerId(
                    LatLng(double.parse(data.latitude),
                            double.parse(data.longitude))
                        .toString(),
                  ),
                  position: LatLng(double.parse(data.latitude),
                      double.parse(data.longitude))),
            );

            custom_latitude = double.parse(data.latitude);
            custom_longitude = double.parse(data.longitude);

            selected1 = data.frontLeftSideTick == "1" ? true : false;
            selected2 = data.frontRightSideTick == "1" ? true : false;
            selected3 = data.middleLeftSideTick == "1" ? true : false;
            selected4 = data.middleRightSideTick == "1" ? true : false;
            selected5 = data.backLeftSideTick == "1" ? true : false;
            selected6 = data.backRightSideTick == "1" ? true : false;
          },
        );
      }
    });
  }

/*--------------------------------------------------------------------------------------------------------------------------------------------- -------------------*/

  Position position;
  double custom_latitude;
  double custom_longitude;
  @override
  void initState() {
    getCurrentLocation();
    _states = List.from(_states)..addAll(repo.getStates());
    getStringValuesSF();
    getdata();

    super.initState();
  }

  void getCurrentLocation() async {
    Position res = await Geolocator().getCurrentPosition();
    setState(() {
      position = res;
      custom_latitude = position.latitude;
      custom_longitude = position.longitude;
    });
  }

  List<Marker> mymarker = [];
  var latitudeorginal;
  var longnitudeoriginal;

  var localityuser;
/*--------------------------------------------------------------------------------------------------------------------------------------------- -------------------*/
// dependent car list
  Repository repo = Repository();

  List<String> _states = ["Choose a Type"];
  List<String> _lgas = ["Choose .."];
  String _selectedState = "Choose a Type";
  String _selectedLGA = "Choose ..";

/*--------------------------------------------------------------------------------------------------------------------------------------------- -------------------*/

/*--------------------------------------------------------------------------------------------------------------------------------------------- -------------------*/
  // for dialogbox makes statefull widget
  StateSetter _setState;

  String vehicaletype = "Honda";
  String vehicalemodel = "Accord";
  String vehicaleyear = "2020-year";
  String vehicaledoor = "2-Doors";
  String vehicaleseat = "2-Seats";

  bool selected1 = true;
  bool selected2 = true;
  bool selected3 = true;
  bool selected4 = true;
  bool selected5 = true;
  bool selected6 = true;

  File _image1;
  File _image2;
  File _image3;
  File _image4;
  File _image5;
  File _image6;

  String photopath1;
  String photopath2;
  String photopath3;
  String photopath4;
  String photopath5;
  String photopath6;

  String photo641;
  String photo642;
  String photo643;
  String photo644;
  String photo645;
  String photo646;

/*------------------------------------------------------------------------------------------------------------------------------------------------------------- */

  File _image7;
  File _image8;
  File _image9;
  File _image10;

  String photopath7;
  String photopath8;
  String photopath9;
  String photopath10;
/*------------------------------------------------------------------------------------------------------------------------------------------------------------- */
  String photopath101;
  String photopath20;
  String photopath30;
  String photopath40;
  String photopath50;
  String photopath60;
  String photopath70;
  String photopath80;
  String photopath90;
  String photopath100;

/*------------------------------------------------------------------------------------------------------------------------------------------------------------- */

  String photo647;
  String photo648;
  String photo649;
  String photo6410;

/*------------------------------------------------------------------------------------------------------------------------------------------------------------- */

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(
            AppLocalizations.of(context).translate(
              'EditVehicle',
            ),
            style:
                TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(2))),
        flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment(0.8, 0.0),
          colors: [const Color(0xff042E6F), const Color(0xff00BAF2)],
        ))),
      ),
      body: Form(
          key: _form,
          child:
              //  datacoming
              //     ?
              ListView(
            padding: EdgeInsets.all(10.0),
            scrollDirection: Axis.vertical,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Color(0xff9BE8FF), width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(
                  children: <Widget>[
/*------------------------------------------------------------------------------------------------------------------------------------------------------------- */
//dependent drop down
// Text(value_keytoken),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8, top: 4, bottom: 4),
                          child: DropdownButton<String>(
                            underline: Container(),
                            isExpanded: true,
                            items: _states.map((String dropDownStringItem) {
                              return DropdownMenuItem<String>(
                                value: dropDownStringItem,
                                child: Text(dropDownStringItem),
                              );
                            }).toList(),
                            onChanged: (value) => _onSelectedState(value),
                            value: _selectedState,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8, top: 4, bottom: 4),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            underline: Container(),
                            items: _lgas.map((String dropDownStringItem) {
                              return DropdownMenuItem<String>(
                                value: dropDownStringItem,
                                child: Text(dropDownStringItem),
                              );
                            }).toList(),
                            // onChanged: (value) => print(value),
                            onChanged: (value) => _onSelectedLGA(value),
                            value: _selectedLGA,
                          ),
                        ),
                      ),
                    ),
/*------------------------------------------------------------------------------------------------------------------------------------------------------------- */
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8, top: 4, bottom: 4),
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white))),
                            isExpanded: true,
                            value: vehicaleyear,
                            hint: Text("year"),
                            items: <String>[
                              '2020-year',
                              '2019-year',
                              '2018-year',
                              '2017-year'
                            ].map((String value) {
                              return new DropdownMenuItem<String>(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                vehicaleyear = value;
                                print(vehicaleyear);
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          controller: colorcontroller,
                          keyboardType: TextInputType.text,
                          validator: (val) {
                            if (val.isEmpty) return 'Empty';
                            return null;
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Vehicale Color',
                              hintText: 'Red'),
                        )),
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          controller: rentcontroller,
                          keyboardType: TextInputType.number,
                          validator: (val) {
                            if (val.isEmpty) return 'Empty';
                            return null;
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Rent per day',
                              hintText: '500'),
                        )),
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          controller: descriptioncontroller,
                          keyboardType: TextInputType.text,
                          validator: (val) {
                            if (val.isEmpty) return 'Empty';
                            return null;
                          },
                          decoration: InputDecoration(
                              //  border: InputBorder.none,
                              border: OutlineInputBorder(),
                              labelText: 'Description',
                              hintText: 'About Car'),
                        )),
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          readOnly: true,
                          validator: (val) {
                            if (val.isEmpty) return 'Empty';
                            return null;
                          },
                          controller: insuranceexpirycontroller,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Insurance Expiry Date',
                            hintText: '14 - 11 - 1985',
                            suffixIcon: IconButton(
                              icon: Icon(
                                Icons.date_range,
                                color: Color(0xff00BAF2),
                              ),
                              onPressed: () {
                                showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(4000),
                                    builder:
                                        (BuildContext context, Widget picker) {
                                      return Theme(
                                        data: ThemeData.dark().copyWith(
                                          colorScheme: ColorScheme.dark(
                                            primary: Colors.blue,
                                            onPrimary: Colors.white,
                                            surface: Colors.blue,
                                            onSurface: Colors.black,
                                          ),
                                          dialogBackgroundColor: Colors.white,
                                        ),
                                        child: picker,
                                      );
                                    }).then((selectedDate) {
                                  if (selectedDate != null) {
                                    insuranceexpirycontroller.text =
                                        selectedDate
                                            .toString()
                                            .substring(0, 10);
                                  } else {
                                    insuranceexpirycontroller.text = null;
                                  }
                                });
                              },
                            ),
                          ),
                        )),
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          controller: mileagecontroller,
                          keyboardType: TextInputType.number,
                          validator: (val) {
                            if (val.isEmpty) return 'Empty';
                            return null;
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'mileage',
                              hintText: '150km'),
                        )),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Choose Location"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        height: 70,
                        width: double.infinity,
                        child: FittedBox(
                          child: InkWell(
                              child: Image.asset('assets/images/map.png'),
                              onTap: () {
                                showAlertDialogmap(context);
                              }),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Text("Pls click on map and Choose location"),
                    /*-------------------------------------------------------------------------------------------------------------------*/
                    // drop down for seat and door of car
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Container(
                        width: _width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8, top: 4, bottom: 4),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: vehicaledoor,
                            underline: Container(),
                            hint: Text("Car Door"),
                            items: <String>[
                              '2-Doors',
                              '4-Doors',
                              '6-Doors',
                              '8-Doors'
                            ].map((String value) {
                              return new DropdownMenuItem<String>(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                vehicaledoor = value;
                                print(vehicaledoor);
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Container(
                        width: _width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey)),
                        child: Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, right: 8, top: 4, bottom: 4),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: vehicaleseat,
                              underline: Container(),
                              hint: Text("Seating Capacity"),
                              items: <String>[
                                '2-Seats',
                                '4-Seats',
                                '6-Seats',
                                '8-Seats'
                              ].map((String value) {
                                return new DropdownMenuItem<String>(
                                  value: value,
                                  child: new Text(value),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  vehicaleseat = value;
                                  print(vehicaleseat);
                                });
                              },
                            )),
                      ),
                    ),
/*-------------------------------------------------------------------------------------------------------------------*/

                    Padding(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          controller: conditioncontroller,
                          keyboardType: TextInputType.text,
                          validator: (val) {
                            if (val.isEmpty) return 'Empty';
                            return null;
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'vehicles condition',
                              hintText: 'Good'),
                        )),

/*-------------------------------------------------------------------------------------------------------------------*/
                    // car photo and tapable button on car
                    Container(
                      child: Column(
                        children: [
                          Text(
                            "Tap on vehicle image to add further details",
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Tajawal',
                                fontWeight: FontWeight.bold),
                          ),

                          // car tape able
                          Stack(
                            children: [
                              SizedBox(
                                height: 200,
                                width: 200,
                                child: SvgPicture.asset(
                                    "assets/images/car-grid-view.svg"),
                              ),
                              Positioned(
                                right: 55,
                                top: 20,
                                child: InkWell(
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    // color: Colors.red,
                                    child: Center(
                                        child: CircleAvatar(
                                            backgroundColor: Colors.black,
                                            radius: 13,
                                            child: Text(
                                              "2",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ))),
                                  ),
                                  onTap: () {
                                    showAlertDialogcar2(context);
                                  },
                                ),
                              ),
                              Positioned(
                                right: 55,
                                top: 80,
                                child: InkWell(
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    // color: Colors.red,
                                    child: Center(
                                        child: CircleAvatar(
                                            backgroundColor: Colors.black,
                                            radius: 13,
                                            child: Text(
                                              "4",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ))),
                                  ),
                                  onTap: () {
                                    showAlertDialogcar4(context);
                                  },
                                ),
                              ),
                              Positioned(
                                right: 55,
                                top: 140,
                                child: InkWell(
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    // color: Colors.red,
                                    child: Center(
                                        child: CircleAvatar(
                                            backgroundColor: Colors.black,
                                            radius: 13,
                                            child: Text(
                                              "6",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ))),
                                  ),
                                  onTap: () {
                                    showAlertDialogcar6(context);
                                  },
                                ),
                              ),

                              //left
                              Positioned(
                                left: 55,
                                top: 20,
                                child: InkWell(
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    // color: Colors.red,
                                    child: Center(
                                        child: CircleAvatar(
                                            backgroundColor: Colors.black,
                                            radius: 13,
                                            child: Text(
                                              "1",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ))),
                                  ),
                                  onTap: () {
                                    showAlertDialogcar1(context);
                                  },
                                ),
                              ),
                              Positioned(
                                left: 55,
                                top: 80,
                                child: InkWell(
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    //color: Colors.red,
                                    child: Center(
                                        child: CircleAvatar(
                                            backgroundColor: Colors.black,
                                            radius: 13,
                                            child: Text(
                                              "3",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ))),
                                  ),
                                  onTap: () {
                                    showAlertDialogcar3(context);
                                  },
                                ),
                              ),
                              Positioned(
                                left: 55,
                                top: 140,
                                child: InkWell(
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    // color: Colors.red,
                                    child: Center(
                                        child: CircleAvatar(
                                            backgroundColor: Colors.black,
                                            radius: 13,
                                            child: Text(
                                              "5",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ))),
                                  ),
                                  onTap: () {
                                    showAlertDialogcar5(context);
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          Text(
                            "Upload Vehicale images",
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Tajawal',
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
/*-------------------------------------------------------------------------------------------------------------------*/

/*-------------------------------------------------------------------------------------------------------------------*/
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Row(children: [
                          Container(
                            color: Colors.grey,
                            height: _height / 10,
                            width: _width / 5,
                            child: InkWell(
                              child: _image7 == null
                                  ? Icon(
                                      Icons.add,
                                      size: 20,
                                    )
                                  : Stack(children: <Widget>[
                                      Container(
                                        height: _height / 10,
                                        width: _width / 5,
                                        child: Image.file(
                                          _image7,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _image7 = null;
                                            });
                                          },
                                          child: Icon(
                                            Icons.delete,
                                            color: Color(0xffff741A),
                                          ),
                                        ),
                                      )
                                    ]),
                              // Image.file(
                              //     _image7,
                              //     fit: BoxFit.fill,
                              //   ),
                              onTap: () async {
                                var imagepath = await ImagePicker.pickImage(
                                    source: ImageSource.gallery);
                                final bytes = imagepath.readAsBytesSync();
                                String _img647 = base64Encode(bytes);
                                print(_img647);
                                print("image");
                                setState(() {
                                  _image7 = imagepath;
                                  photopath7 =
                                      (imagepath.toString().split('/').last);
                                  photopath70 =
                                      (photopath7.toString().split("'").first);
                                  photo647 = _img647;
                                  print(photopath7);
                                });
                              },
                            ),
                          ),
                          Spacer(),
                          Container(
                            color: Colors.grey,
                            height: _height / 10,
                            width: _width / 5,
                            child: InkWell(
                              child: _image8 == null
                                  ? Icon(
                                      Icons.add,
                                      size: 20,
                                    )
                                  : Stack(children: <Widget>[
                                      Container(
                                        height: _height / 10,
                                        width: _width / 5,
                                        child: Image.file(
                                          _image8,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _image8 = null;
                                            });
                                          },
                                          child: Icon(
                                            Icons.delete,
                                            color: Color(0xffff741A),
                                          ),
                                        ),
                                      )
                                    ]),
                              //  Image.file(
                              //     _image8,
                              //     fit: BoxFit.fill,
                              //   ),
                              onTap: () async {
                                var imagepath = await ImagePicker.pickImage(
                                    source: ImageSource.gallery);
                                final bytes = imagepath.readAsBytesSync();
                                String _img648 = base64Encode(bytes);
                                print(_img648);
                                print("image");
                                print(imagepath);
                                setState(() {
                                  _image8 = imagepath;
                                  photopath8 =
                                      (imagepath.toString().split('/').last);
                                  photopath80 =
                                      (photopath8.toString().split("'").first);
                                  photo648 = _img648;
                                });
                              },
                            ),
                          ),
                          Spacer(),
                          Container(
                            color: Colors.grey,
                            height: _height / 10,
                            width: _width / 5,
                            child: InkWell(
                              child: _image9 == null
                                  ? Icon(
                                      Icons.add,
                                      size: 20,
                                    )
                                  : Stack(children: <Widget>[
                                      Container(
                                        height: _height / 10,
                                        width: _width / 5,
                                        child: Image.file(
                                          _image9,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _image9 = null;
                                            });
                                          },
                                          child: Icon(
                                            Icons.delete,
                                            color: Color(0xffff741A),
                                          ),
                                        ),
                                      )
                                    ]),
                              // Image.file(
                              //     _image9,
                              //     fit: BoxFit.fill,
                              //   ),
                              onTap: () async {
                                var imagepath = await ImagePicker.pickImage(
                                    source: ImageSource.gallery);
                                final bytes = imagepath.readAsBytesSync();
                                String _img649 = base64Encode(bytes);
                                print(_img649);
                                print("image");
                                print(imagepath);
                                setState(() {
                                  _image9 = imagepath;
                                  photopath9 =
                                      (imagepath.toString().split('/').last);
                                  photopath90 = (photopath9
                                      .toString()
                                      .split(" ' ")
                                      .first);
                                  photo649 = _img649;
                                });
                              },
                            ),
                          ),
                          Spacer(),
                          Container(
                            color: Colors.grey,
                            height: _height / 10,
                            width: _width / 5,
                            child: InkWell(
                              child: _image10 == null
                                  ? Icon(
                                      Icons.add,
                                      size: 20,
                                    )
                                  : Stack(children: <Widget>[
                                      Container(
                                        height: _height / 10,
                                        width: _width / 5,
                                        child: Image.file(
                                          _image10,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _image10 = null;
                                            });
                                          },
                                          child: Icon(
                                            Icons.delete,
                                            color: Color(0xffff741A),
                                          ),
                                        ),
                                      )
                                    ]),

                              // Image.file(
                              //     _image10,
                              //     fit: BoxFit.fill,
                              //   ),
                              onTap: () async {
                                var imagepath = await ImagePicker.pickImage(
                                    source: ImageSource.gallery);
                                final bytes = imagepath.readAsBytesSync();
                                //  String  basename  =basename(imagepath.path);
                                String _img6410 = base64Encode(bytes);
                                print(_img6410);
                                print("image");
                                print(imagepath);

                                setState(() {
                                  _image10 = imagepath;
                                  photopath10 =
                                      (imagepath.toString().split('/').last);
                                  photopath100 =
                                      (photopath10.toString().split("'").first);
                                  photo6410 = _img6410;
                                  print(photopath10);
                                  print(photopath100);
                                });
                              },
                            ),
                          ),
                        ]),
                      ),
                    ),

/*-------------------------------------------------------------------------------------------------------------------*/

                    SizedBox(height: 10),
                    SizedBox(
                      width: _width,
                      child: isloding
                          ? RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              onPressed: () {},
                              color: Color(0xFF042E6F),
                              padding: EdgeInsets.all(16.0),
                              textColor: Colors.white,
                              child: CircularProgressIndicator(),
                            )
                          : RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              onPressed: () {
                                if (_form.currentState.validate() &&
                                    _image7 != null &&
                                    _image8 != null &&
                                    _image9 != null &&
                                    _image10 != null) {
                                  setState(() {
                                    isloding = true;
                                  });

                                  http.post(
                                    'https://ajerrha.com/api/edit/vehicle',
                                    body: jsonEncode({
                                      "id": widget.vehicaleid,
                                      "vehicaleType": _selectedState,
                                      "vehicaleModel": _selectedLGA,
                                      "vehicaleYear": vehicaleyear,
                                      "vehicaleColor": colorcontroller.text,
                                      "VehicaleRentPerDay": rentcontroller.text,
                                      "vehicaleDescription":
                                          descriptioncontroller.text,
                                      "vehicaleInsuranceExpiredDate":
                                          insuranceexpirycontroller.text,
                                      "vehicaleMileage": mileagecontroller.text,
                                      "vehicaleMapcordinatelangitude":
                                          latitudeorginal,
                                      "vehicaleMapcordinatelongnitude":
                                          longnitudeoriginal,
                                      "vehicaleLocality": localityuser,
                                      "vehicaleDoor": vehicaledoor,
                                      "vehicaleSeatCapacity": vehicaleseat,
                                      "vehicaleCondition":
                                          conditioncontroller.text,
                                      /*-------------------------------------------------------------------------------------------------------------------*/

                                      "frontleftsideTick": selected1,
                                      "frontleftsideTicktext":
                                          frontLeftSidecontroller.text,
                                      "frontleftsideTickimage": photo641,
                                      "frontleftsideTickimagepath":
                                          photopath101,
                                      /*-------------------------------------------------------------------------------------------------------------------*/

                                      "frontrightsideTick": selected2,
                                      "frontrightsideTicktext":
                                          frontRightSidecontroller.text,
                                      "frontrightsideTickimage": photo642,
                                      "frontrightsideTickimagepath":
                                          photopath20,

                                      /*-------------------------------------------------------------------------------------------------------------------*/

                                      "middleleftsideTick": selected3,
                                      "middleleftsideTicktext":
                                          middleLeftSidecontroller.text,
                                      "middleleftsideTickimage": photo643,
                                      "middleleftsideTickimagepath":
                                          photopath30,

                                      /*-------------------------------------------------------------------------------------------------------------------*/

                                      "middlerightsideTick": selected4,
                                      "middlerightsideTicktext":
                                          middleRightSidecontroller.text,
                                      "middlerightsideTickimage": photo644,
                                      "middlerightsideTickimagepath":
                                          photopath40,

                                      /*-------------------------------------------------------------------------------------------------------------------*/

                                      "backleftsideTick": selected5,
                                      "backleftsideTicktext":
                                          backLeftSidecontroller.text,
                                      "backleftsideTickimage": photo645,
                                      "backleftsideTickimagepath": photopath50,

                                      /*-------------------------------------------------------------------------------------------------------------------*/

                                      "backrightsideTick": selected6,
                                      "backrightsideTicktext":
                                          backRightSidecontroller.text,
                                      "backrightsideTickimage": photo646,
                                      "backrightsideTickimagepath": photopath60,

                                      /*-------------------------------------------------------------------------------------------------------------------*/

                                      "vehicaleUploadimages7": photo647,
                                      "vehicaleUploadimages7path": photopath70,
                                      "vehicaleUploadimages8": photo648,
                                      "vehicaleUploadimages8path": photopath80,
                                      "vehicaleUploadimages9": photo649,
                                      "vehicaleUploadimages9path": photopath90,
                                      "vehicaleUploadimages10": photo6410,
                                      "vehicaleUploadimages10path":
                                          photopath100,
                                    }),
                                    headers: {
                                      'Content-Type': 'application/json',
                                      'Authorization':
                                          'Bearer ' + value_keytoken,
                                    },
                                  ).then((response) async {
                                    final res = json.decode(response.body);
                                    print(response.body);
                                    print(res["status"]);

                                    if (res["status"] == "success") {
                                      print(response.body);
                                      print(res["status"]);
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => Myvehiclecards()),
                                        (Route<dynamic> route) => false,
                                      );
                                    } else {
                                      setState(() {
                                        isloding = false;
                                      });
                                    }
                                  });
                                } else {
                                  showAlertDialogerror(context);
                                  setState(() {
                                    isloding = false;

                                    print("all image select");
                                  });
                                }
                              },
                              color: Color(0xFF042E6F),
                              padding: EdgeInsets.all(16.0),
                              textColor: Colors.white,
                              child: Text(
                                "Save Changes",
                                // AppLocalizations.of(context).translate(
                                //   'EditVehicle',
                                // ),
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Tajawal'),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ],
          )
          //    : Center(child: CircularProgressIndicator()),
          ),
    );
    //   ),
  }

  /*-------------------------------------------------------------------------------------------------------------------*/
//dialog box for map
  showAlertDialogmap(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Center(child: Text("Choose Location")),
      content: StatefulBuilder(
        // You need this, notice the parameters below:
        builder: (BuildContext context, StateSetter setState) {
          _setState = setState;
          return SingleChildScrollView(
            child: Container(
              width: _width,
              child: Column(
                children: [
                  FlatButton(
                    color: Color(0xff042E6F),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.gps_fixed,
                          color: Colors.white,
                        ),
                        Text(
                          " Use current location",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    onPressed: () {
                      //   Navigator.pop(context);
                      //  print()
                      setState(() {
                        mymarker = [];
                        mymarker.add(
                          Marker(
                              markerId: MarkerId(
                                "Vehicale Id",
                              ),
                              position: LatLng(
                                  position.latitude, position.longitude)),
                        );
                        latitudeorginal = position.latitude;
                        longnitudeoriginal = position.longitude;
                        print(position.toString());
                      });
                    },
                  ),
                  Container(
                    height: _height / 2,
                    width: _width,
                    child: GoogleMap(
                      mapType: MapType.normal,
                      markers: Set.from(mymarker),
                      initialCameraPosition: CameraPosition(
                        target: LatLng(custom_latitude, custom_longitude),
                        zoom: 12.0,
                      ),
                      onTap: (LatLng latLng) {
                        print(latLng);
                        setState(() {
                          mymarker = [];
                          mymarker.add(
                            Marker(
                                markerId: MarkerId(
                                  latLng.toString(),
                                ),
                                position: latLng),
                          );
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: _width,
                    child: FlatButton(
                      color: Colors.green,
                      child: Text(
                        " Save Location",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        var addresses = await Geocoder.local
                            .findAddressesFromCoordinates(Coordinates(
                                latitudeorginal, longnitudeoriginal));
                        var first = addresses.first;
                        localityuser = first.locality;
                        print("${first.locality}");
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      actions: [],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  /*-------------------------------------------------------------------------------------------------------------------*/

  /*-------------------------------------------------------------------------------------------------------------------*/
//All dialog box for car tapable area
  showAlertDialogcar1(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    AlertDialog alert = AlertDialog(
      title: Text("Front -Left Side  "),
      content: StatefulBuilder(
        // You need this, notice the parameters below:
        builder: (BuildContext context, StateSetter setState) {
          _setState = setState;
          return SingleChildScrollView(
            child: Column(
              children: [
                CheckboxListTile(
                  title: Text(
                      "No issue with this side, seems to be perfectly fine"),
                  value: selected1,
                  onChanged: (newvalue) {
                    setState(() {
                      selected1 = newvalue;
                    });
                  },
                  controlAffinity:
                      ListTileControlAffinity.leading, //  <-- leading Checkbox
                ),
                selected1
                    ? Container(color: Colors.white)
                    : Container(
                        width: _width,
                        height: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey)),
                        child: TextFormField(
                          controller: frontLeftSidecontroller,
                          validator: (val) {
                            if (val.isEmpty) return 'Empty';
                            return null;
                          },
                          maxLines: null,
                          expands: true,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                // This is optional

                SizedBox(
                  height: 5,
                ),
                selected1
                    ? Container(color: Colors.white // This is optional
                        )
                    : Container(
                        width: _width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Upload vehicle image"),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Container(
                                  color: Colors.black12,
                                  height: 100.0,
                                  width: _width / 2.5,
                                  child: Center(
                                    child: _image1 == null
                                        ? Text("No image")
                                        : Stack(children: [
                                            Container(
                                              height: 100.0,
                                              width: _width / 2.5,
                                              child: Image.file(_image1),
                                            ),
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    _image1 = null;
                                                  });
                                                },
                                                child: Icon(
                                                  Icons.delete,
                                                  color: Color(0xffff741A),
                                                ),
                                              ),
                                            )
                                          ]),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    FlatButton(
                                      //  heroTag: "btn1",
                                      onPressed: () async {
                                        var imagepath =
                                            await ImagePicker.pickImage(
                                                source: ImageSource.camera);
                                        final bytes =
                                            imagepath.readAsBytesSync();
                                        String _img641 = base64Encode(bytes);
                                        print(_img641);
                                        print("image");
                                        print(imagepath);
                                        setState(() {
                                          _image1 = imagepath;
                                          photopath1 = (imagepath
                                              .toString()
                                              .split('/')
                                              .last);
                                          photopath101 = (photopath1
                                              .toString()
                                              .split("'")
                                              .first);
                                          photo641 = _img641;
                                        });
                                      },
                                      // tooltip: "pickImage",
                                      child: Icon(
                                        Icons.add_a_photo,
                                        color: Color(0xFF042E6F),
                                      ),
                                    ),
                                    FlatButton(
                                      //  heroTag: "btn2",
                                      onPressed: () async {
                                        var imagepath =
                                            await ImagePicker.pickImage(
                                                source: ImageSource.gallery);
                                        final bytes =
                                            imagepath.readAsBytesSync();
                                        String _img641 = base64Encode(bytes);
                                        print(_img641);
                                        print("image");
                                        print(imagepath);
                                        setState(() {
                                          _image1 = imagepath;
                                          photopath1 = (imagepath
                                              .toString()
                                              .split('/')
                                              .last);
                                          photopath101 = (photopath1
                                              .toString()
                                              .split("'")
                                              .first);
                                          photo641 = _img641;
                                        });
                                      },
                                      //  tooltip: "Pick Image",
                                      child: Icon(
                                        Icons.camera_alt,
                                        color: Color(0xFF042E6F),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                SizedBox(height: 10),
                SizedBox(
                  width: _width,
                  child: FlatButton(
                    color: Color(0xff042E6F),
                    child: Text(
                      " Submit",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      actions: [],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialogcar2(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    AlertDialog alert = AlertDialog(
      title: Text("Front -Right Side "),
      content: StatefulBuilder(
        // You need this, notice the parameters below:
        builder: (BuildContext context, StateSetter setState) {
          _setState = setState;
          return SingleChildScrollView(
            child: Column(
              children: [
                CheckboxListTile(
                  title: Text(
                      "No issue with this side, seems to be perfectly fine"),
                  value: selected2,
                  onChanged: (newvalue) {
                    setState(() {
                      selected2 = newvalue;
                    });
                  },
                  controlAffinity:
                      ListTileControlAffinity.leading, //  <-- leading Checkbox
                ),
                selected2
                    ? Container(color: Colors.white // This is optional
                        )
                    : Container(
                        width: _width,
                        height: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey)),
                        child: TextFormField(
                          controller: frontRightSidecontroller,
                          validator: (val) {
                            if (val.isEmpty) return 'Empty';
                            return null;
                          },
                          maxLines: null,
                          expands: true,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                SizedBox(
                  height: 5,
                ),
                selected2
                    ? Container(color: Colors.white // This is optional
                        )
                    : Container(
                        width: _width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Upload vehicle image"),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Container(
                                  color: Colors.black12,
                                  height: 100.0,
                                  width: _width / 2.5,
                                  child: Center(
                                    child: _image2 == null
                                        ? Text("No image")
                                        : Stack(children: [
                                            Container(
                                              height: 100.0,
                                              width: _width / 2.5,
                                              child: Image.file(_image2),
                                            ),
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    _image2 = null;
                                                  });
                                                },
                                                child: Icon(
                                                  Icons.delete,
                                                  color: Color(0xffff741A),
                                                ),
                                              ),
                                            )
                                          ]),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    FlatButton(
                                      //  heroTag: "btn1",
                                      onPressed: () async {
                                        var imagepath =
                                            await ImagePicker.pickImage(
                                                source: ImageSource.camera);
                                        final bytes =
                                            imagepath.readAsBytesSync();
                                        String _img642 = base64Encode(bytes);
                                        print(_img642);
                                        print("image");
                                        print(imagepath);
                                        setState(() {
                                          _image2 = imagepath;
                                          photopath2 = (imagepath
                                              .toString()
                                              .split('/')
                                              .last);
                                          photopath20 = (photopath2
                                              .toString()
                                              .split("'")
                                              .first);
                                          photo642 = _img642;
                                        });
                                      },
                                      // tooltip: "pickImage",
                                      child: Icon(
                                        Icons.add_a_photo,
                                        color: Color(0xFF042E6F),
                                      ),
                                    ),
                                    FlatButton(
                                      //  heroTag: "btn2",
                                      onPressed: () async {
                                        var imagepath =
                                            await ImagePicker.pickImage(
                                                source: ImageSource.gallery);
                                        final bytes =
                                            imagepath.readAsBytesSync();
                                        String _img642 = base64Encode(bytes);
                                        print(_img642);
                                        print("image");
                                        print(imagepath);
                                        setState(() {
                                          _image2 = imagepath;
                                          photopath2 = (imagepath
                                              .toString()
                                              .split('/')
                                              .last);
                                          photopath20 = (photopath2
                                              .toString()
                                              .split("'")
                                              .first);
                                          photo642 = _img642;
                                        });
                                      },
                                      //  tooltip: "Pick Image",
                                      child: Icon(
                                        Icons.camera_alt,
                                        color: Color(0xFF042E6F),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                SizedBox(height: 10),
                SizedBox(
                  width: _width,
                  child: FlatButton(
                    color: Color(0xff042E6F),
                    child: Text(
                      " Save change",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      actions: [],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialogcar3(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    AlertDialog alert = AlertDialog(
      title: Text("Middle -Left Side "),
      content: StatefulBuilder(
        // You need this, notice the parameters below:
        builder: (BuildContext context, StateSetter setState) {
          _setState = setState;
          return SingleChildScrollView(
            child: Column(
              children: [
                CheckboxListTile(
                  title: Text(
                      "No issue with this side, seems to be perfectly fine"),
                  value: selected3,
                  onChanged: (newValue) {
                    setState(() {
                      selected3 = newValue;
                    });
                  },
                  controlAffinity:
                      ListTileControlAffinity.leading, //  <-- leading Checkbox
                ),
                selected3
                    ? Container(color: Colors.white // This is optional
                        )
                    : Container(
                        width: _width,
                        height: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey)),
                        child: TextFormField(
                          controller: middleLeftSidecontroller,
                          validator: (val) {
                            if (val.isEmpty) return 'Empty';
                            return null;
                          },
                          maxLines: null,
                          expands: true,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                SizedBox(
                  height: 5,
                ),
                selected3
                    ? Container(color: Colors.white // This is optional
                        )
                    : Container(
                        width: _width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Upload vehicle image"),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Container(
                                  color: Colors.black12,
                                  height: 100.0,
                                  width: _width / 2.5,
                                  child: Center(
                                    child: _image3 == null
                                        ? Text("No image")
                                        : Stack(children: [
                                            Container(
                                              height: 100.0,
                                              width: _width / 2.5,
                                              child: Image.file(_image3),
                                            ),
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    _image3 = null;
                                                  });
                                                },
                                                child: Icon(
                                                  Icons.delete,
                                                  color: Color(0xffff741A),
                                                ),
                                              ),
                                            )
                                          ]),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    FlatButton(
                                      //  heroTag: "btn1",
                                      onPressed: () async {
                                        var imagepath =
                                            await ImagePicker.pickImage(
                                                source: ImageSource.camera);
                                        final bytes =
                                            imagepath.readAsBytesSync();
                                        String _img643 = base64Encode(bytes);
                                        print(_img643);
                                        print("image");
                                        print(imagepath);
                                        setState(() {
                                          _image3 = imagepath;
                                          photopath3 = (imagepath
                                              .toString()
                                              .split('/')
                                              .last);
                                          photopath30 = (photopath3
                                              .toString()
                                              .split(" ' ")
                                              .first);
                                          photo643 = _img643;
                                        });
                                      },
                                      // tooltip: "pickImage",
                                      child: Icon(
                                        Icons.add_a_photo,
                                        color: Color(0xFF042E6F),
                                      ),
                                    ),
                                    FlatButton(
                                      //  heroTag: "btn2",
                                      onPressed: () async {
                                        var imagepath =
                                            await ImagePicker.pickImage(
                                                source: ImageSource.gallery);
                                        final bytes =
                                            imagepath.readAsBytesSync();
                                        String _img643 = base64Encode(bytes);
                                        print(_img643);
                                        print("image");
                                        print(imagepath);
                                        setState(() {
                                          _image3 = imagepath;
                                          photopath3 = (imagepath
                                              .toString()
                                              .split('/')
                                              .last);
                                          photopath30 = (photopath3
                                              .toString()
                                              .split(" ' ")
                                              .first);
                                          photo643 = _img643;
                                        });
                                      },
                                      //  tooltip: "Pick Image",
                                      child: Icon(
                                        Icons.camera_alt,
                                        color: Color(0xFF042E6F),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                SizedBox(height: 10),
                SizedBox(
                  width: _width,
                  child: FlatButton(
                    color: Color(0xff042E6F),
                    child: Text(
                      " Save change",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      actions: [],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialogcar4(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    AlertDialog alert = AlertDialog(
      title: Text("Middle -Right Side "),
      content: StatefulBuilder(
        // You need this, notice the parameters below:
        builder: (BuildContext context, StateSetter setState) {
          _setState = setState;
          return SingleChildScrollView(
            child: Column(
              children: [
                CheckboxListTile(
                  title: Text(
                      "No issue with this side, seems to be perfectly fine"),
                  value: selected4,
                  onChanged: (newValue) {
                    setState(() {
                      selected4 = newValue;
                    });
                  },
                  controlAffinity:
                      ListTileControlAffinity.leading, //  <-- leading Checkbox
                ),
                selected4
                    ? Container(color: Colors.white // This is optional
                        )
                    : Container(
                        width: _width,
                        height: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey)),
                        child: TextFormField(
                          controller: middleRightSidecontroller,
                          validator: (val) {
                            if (val.isEmpty) return 'Empty';
                            return null;
                          },
                          maxLines: null,
                          expands: true,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                SizedBox(
                  height: 5,
                ),
                selected4
                    ? Container(color: Colors.white // This is optional
                        )
                    : Container(
                        width: _width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Upload vehicle image"),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Container(
                                  color: Colors.black12,
                                  height: 100.0,
                                  width: _width / 2.5,
                                  child: Center(
                                    child: _image4 == null
                                        ? Text("No image")
                                        : Stack(children: [
                                            Container(
                                              height: 100.0,
                                              width: _width / 2.5,
                                              child: Image.file(_image4),
                                            ),
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    _image4 = null;
                                                  });
                                                },
                                                child: Icon(
                                                  Icons.delete,
                                                  color: Color(0xffff741A),
                                                ),
                                              ),
                                            )
                                          ]),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    FlatButton(
                                      //  heroTag: "btn1",
                                      onPressed: () async {
                                        var imagepath =
                                            await ImagePicker.pickImage(
                                                source: ImageSource.camera);
                                        final bytes =
                                            imagepath.readAsBytesSync();
                                        String _img644 = base64Encode(bytes);
                                        print(_img644);
                                        print("image");
                                        print(imagepath);
                                        setState(() {
                                          _image4 = imagepath;
                                          photopath4 = (imagepath
                                              .toString()
                                              .split('/')
                                              .last);
                                          photopath40 = (photopath4
                                              .toString()
                                              .split("'")
                                              .first);
                                          photo644 = _img644;
                                        });
                                      },
                                      // tooltip: "pickImage",
                                      child: Icon(
                                        Icons.add_a_photo,
                                        color: Color(0xFF042E6F),
                                      ),
                                    ),
                                    FlatButton(
                                      //  heroTag: "btn2",
                                      onPressed: () async {
                                        var imagepath =
                                            await ImagePicker.pickImage(
                                                source: ImageSource.gallery);
                                        final bytes =
                                            imagepath.readAsBytesSync();
                                        String _img644 = base64Encode(bytes);
                                        print(_img644);
                                        print("image");
                                        print(imagepath);
                                        setState(() {
                                          _image4 = imagepath;
                                          photopath4 = (imagepath
                                              .toString()
                                              .split('/')
                                              .last);
                                          photopath40 = (photopath4
                                              .toString()
                                              .split("'")
                                              .first);
                                          photo644 = _img644;
                                        });
                                      },
                                      //  tooltip: "Pick Image",
                                      child: Icon(
                                        Icons.camera_alt,
                                        color: Color(0xFF042E6F),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                SizedBox(height: 10),
                SizedBox(
                  width: _width,
                  child: FlatButton(
                    color: Color(0xff042E6F),
                    child: Text(
                      " Save change",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      actions: [],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialogcar5(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    AlertDialog alert = AlertDialog(
      title: Text("Back -Left Side "),
      content: StatefulBuilder(
        // You need this, notice the parameters below:
        builder: (BuildContext context, StateSetter setState) {
          _setState = setState;
          return SingleChildScrollView(
            child: Column(
              children: [
                CheckboxListTile(
                  title: Text(
                      "No issue with this side, seems to be perfectly fine"),
                  value: selected5,
                  onChanged: (newValue) {
                    setState(() {
                      selected5 = newValue;
                    });
                  },
                  controlAffinity:
                      ListTileControlAffinity.leading, //  <-- leading Checkbox
                ),
                selected5
                    ? Container(color: Colors.white // This is optional
                        )
                    : Container(
                        width: _width,
                        height: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey)),
                        child: TextFormField(
                          controller: backLeftSidecontroller,
                          validator: (val) {
                            if (val.isEmpty) return 'Empty';
                            return null;
                          },
                          maxLines: null,
                          expands: true,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                SizedBox(
                  height: 5,
                ),
                selected5
                    ? Container(color: Colors.white // This is optional
                        )
                    : Container(
                        width: _width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Upload vehicle image"),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Container(
                                  color: Colors.black12,
                                  height: 100.0,
                                  width: _width / 2.5,
                                  child: Center(
                                    child: _image5 == null
                                        ? Text("No image")
                                        : Stack(children: [
                                            Container(
                                              height: 100.0,
                                              width: _width / 2.5,
                                              child: Image.file(_image5),
                                            ),
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    _image5 = null;
                                                  });
                                                },
                                                child: Icon(
                                                  Icons.delete,
                                                  color: Color(0xffff741A),
                                                ),
                                              ),
                                            )
                                          ]),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    FlatButton(
                                      //  heroTag: "btn1",
                                      onPressed: () async {
                                        var imagepath =
                                            await ImagePicker.pickImage(
                                                source: ImageSource.camera);
                                        final bytes =
                                            imagepath.readAsBytesSync();
                                        String _img645 = base64Encode(bytes);
                                        print(_img645);
                                        print("image");
                                        print(imagepath);
                                        setState(() {
                                          _image5 = imagepath;
                                          photopath5 = (imagepath
                                              .toString()
                                              .split('/')
                                              .last);
                                          photopath50 = (photopath5
                                              .toString()
                                              .split("'")
                                              .first);
                                          photo645 = _img645;
                                        });
                                      },
                                      // tooltip: "pickImage",
                                      child: Icon(
                                        Icons.add_a_photo,
                                        color: Color(0xFF042E6F),
                                      ),
                                    ),
                                    FlatButton(
                                      //  heroTag: "btn2",
                                      onPressed: () async {
                                        var imagepath =
                                            await ImagePicker.pickImage(
                                                source: ImageSource.gallery);
                                        final bytes =
                                            imagepath.readAsBytesSync();
                                        String _img645 = base64Encode(bytes);
                                        print(_img645);
                                        print("image");
                                        print(imagepath);
                                        setState(() {
                                          _image5 = imagepath;
                                          photopath5 = (imagepath
                                              .toString()
                                              .split('/')
                                              .last);
                                          photopath50 = (photopath5
                                              .toString()
                                              .split("'")
                                              .first);
                                          photo645 = _img645;
                                        });
                                      },
                                      //  tooltip: "Pick Image",
                                      child: Icon(
                                        Icons.camera_alt,
                                        color: Color(0xFF042E6F),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                SizedBox(height: 10),
                SizedBox(
                  width: _width,
                  child: FlatButton(
                    color: Color(0xff042E6F),
                    child: Text(
                      " Save change",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      actions: [],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialogcar6(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    AlertDialog alert = AlertDialog(
      title: Text("Back -Right Side "),
      content: StatefulBuilder(
        // You need this, notice the parameters below:
        builder: (BuildContext context, StateSetter setState) {
          _setState = setState;
          return SingleChildScrollView(
            child: Column(
              children: [
                CheckboxListTile(
                  title: Text(
                      "No issue with this side, seems to be perfectly fine"),
                  value: selected6,
                  onChanged: (newValue) {
                    setState(() {
                      selected6 = newValue;
                    });
                  },
                  controlAffinity:
                      ListTileControlAffinity.leading, //  <-- leading Checkbox
                ),
                selected6
                    ? Container(color: Colors.white // This is optional
                        )
                    : Container(
                        width: _width,
                        height: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey)),
                        child: TextFormField(
                          controller: backRightSidecontroller,
                          validator: (val) {
                            if (val.isEmpty) return 'Empty';
                            return null;
                          },
                          maxLines: null,
                          expands: true,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                SizedBox(
                  height: 5,
                ),
                selected6
                    ? Container(color: Colors.white // This is optional
                        )
                    : Container(
                        width: _width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Upload vehicle image"),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Container(
                                  color: Colors.black12,
                                  height: 100.0,
                                  width: _width / 2.5,
                                  child: Center(
                                    child: _image6 == null
                                        ? Text("No image")
                                        : Stack(children: [
                                            Container(
                                              height: 100.0,
                                              width: _width / 2.5,
                                              child: Image.file(_image6),
                                            ),
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    _image6 = null;
                                                  });
                                                },
                                                child: Icon(
                                                  Icons.delete,
                                                  color: Color(0xffff741A),
                                                ),
                                              ),
                                            )
                                          ]),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    FlatButton(
                                      //  heroTag: "btn1",
                                      onPressed: () async {
                                        var imagepath =
                                            await ImagePicker.pickImage(
                                                source: ImageSource.camera);
                                        final bytes =
                                            imagepath.readAsBytesSync();
                                        String _img646 = base64Encode(bytes);
                                        print(_img646);
                                        print("image");
                                        print(imagepath);
                                        setState(() {
                                          _image6 = imagepath;
                                          photopath6 = (imagepath
                                              .toString()
                                              .split('/')
                                              .last);
                                          photopath60 = (photopath6
                                              .toString()
                                              .split("'")
                                              .first);
                                          photo646 = _img646;
                                        });
                                      },
                                      // tooltip: "pickImage",
                                      child: Icon(
                                        Icons.add_a_photo,
                                        color: Color(0xFF042E6F),
                                      ),
                                    ),
                                    FlatButton(
                                      //  heroTag: "btn2",
                                      onPressed: () async {
                                        var imagepath =
                                            await ImagePicker.pickImage(
                                                source: ImageSource.gallery);
                                        final bytes =
                                            imagepath.readAsBytesSync();
                                        String _img646 = base64Encode(bytes);
                                        print(_img646);
                                        print("image");
                                        print(imagepath);
                                        setState(() {
                                          _image6 = imagepath;
                                          photopath6 = (imagepath
                                              .toString()
                                              .split('/')
                                              .last);
                                          photopath60 = (photopath6
                                              .toString()
                                              .split("'")
                                              .first);
                                          photo646 = _img646;
                                        });
                                      },
                                      //  tooltip: "Pick Image",
                                      child: Icon(
                                        Icons.camera_alt,
                                        color: Color(0xFF042E6F),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                SizedBox(height: 10),
                SizedBox(
                  width: _width,
                  child: FlatButton(
                    color: Color(0xff042E6F),
                    child: Text(
                      " Save change",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      actions: [],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  /*-------------------------------------------------------------------------------------------------------------------*/
//dependent car list

  void _onSelectedState(String value) {
    setState(() {
      _selectedLGA = "Choose ..";
      _lgas = ["Choose .."];
      _selectedState = value;
      _lgas = List.from(_lgas)..addAll(repo.getLocalByState(value));
    });
  }

  void _onSelectedLGA(String value) {
    setState(() => _selectedLGA = value);
  }

  showAlertDialogerror(BuildContext context) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Warning"),
      content: Text("Please Fill Completly And Please Upload vehicale Images"),
      actions: [
        new FlatButton(
          onPressed: () {
            // dismisses only the dialog and returns nothing
            Navigator.pop(context);
          },
          child: new Text('OK'),
        ),
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
