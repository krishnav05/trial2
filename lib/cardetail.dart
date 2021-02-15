import 'package:circular_check_box/circular_check_box.dart';
import 'package:f_datetimerangepicker/f_datetimerangepicker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'localization/App_localization.dart';
import 'package:Ajreeha/login/loginui.dart';
import 'package:Ajreeha/localization/App_localization.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:carousel_slider/carousel_slider.dart';

// ignore: camel_case_types
class vehicleDetails extends StatefulWidget {
  final vehicleid;
  final String vehiclename;
  final String vehicle1;
  final String vehicle2;
  final String vehicle3;
  final String vehicle4;
  final String vehiclerate;
  final String vehiclemilage;
  final String vehicledescprition;
  var vehicleinsurance;
  var vehicalelang;
  var vehicalelong;

  vehicleDetails({
    Key key,
    this.vehicleid,
    this.vehiclename,
    this.vehicle1,
    this.vehicle2,
    this.vehicle3,
    this.vehicle4,
    this.vehiclerate,
    this.vehiclemilage,
    this.vehicledescprition,
    this.vehicleinsurance,
    this.vehicalelang,
    this.vehicalelong,
  }) : super(key: key);
  @override
  _vehicleDetailsState createState() => _vehicleDetailsState();
}

// ignore: camel_case_types
class _vehicleDetailsState extends State<vehicleDetails> {
  CarouselController buttonCarouselController = CarouselController();

  bool selected = false;
  ScrollController _scrollController;
  Color _theme;
  bool showtext = false;
  bool datechoose = false;
  bool wrongdatechoose = false;
  String token;
  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(token);
    token = prefs.getString('value_key');
  }

  var now = new DateTime.now();
  var bookingTo;
  var bookingFrom;

  @override
  void initState() {
    getStringValuesSF();
    super.initState();

    // getCurrentLocation();
    _theme = Colors.black;

    _scrollController = ScrollController()
      ..addListener(() {
        if (_isAppBarExpanded) {
          if (_theme != Colors.white) {
            setState(() {
              showtext = true;
              _theme = Colors.white;
              print('setState is called with white');
            });
          }
        } else {
          if (_theme != Colors.black) {
            setState(() {
              showtext = false;
              _theme = Colors.black;
              print('setState is called with black');
            });
          }
        }
      });
    super.initState();
  }

  bool get _isAppBarExpanded {
    return _scrollController.hasClients &&
        _scrollController.offset > (150 - kToolbarHeight);
  }

  Widget _child;

  Set<Marker> _createMarker() {
    return <Marker>[
      Marker(
          markerId: MarkerId("Vehicle Address"),
          position: LatLng(double.parse(widget.vehicalelang),
              double.parse(widget.vehicalelong)),
          icon: BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(title: "Vehicle Address"))
    ].toSet();
  }

  var days;
  var dayss;
  var ratevehicale;

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    ratevehicale = int.parse(widget.vehiclerate);
    List<String> imageLinks = [
      'https://ajerrha.com/vehicles/' +
          widget.vehicleid.toString() +
          '/' +
          widget.vehicle1.toString(),
      'https://ajerrha.com/vehicles/' +
          widget.vehicleid.toString() +
          '/' +
          widget.vehicle2.toString(),
      'https://ajerrha.com/vehicles/' +
          widget.vehicleid.toString() +
          '/' +
          widget.vehicle3.toString(),
      'https://ajerrha.com/vehicles/' +
          widget.vehicleid.toString() +
          '/' +
          widget.vehicle4.toString(),
    ];
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            actions: <Widget>[
              showtext
                  ? IconButton(
                      icon: Icon(
                        Icons.search,
                        color: _theme, // Here
                      ),
                      onPressed: () {},
                    )
                  : SizedBox.shrink()
            ],
            expandedHeight: ResponsiveFlutter.of(context).hp(15),
            floating: false,
            pinned: true,
            toolbarHeight: 40,
            flexibleSpace: FlexibleSpaceBar(
              title: showtext
                  ? SafeArea(
                      child: Padding(
                      padding: const EdgeInsets.only(top: 5, left: 2),
                      child: Text('Vehicles'),
                    ))
                  : Text(''),
              background: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment(0.8, 0.0),
                  colors: [const Color(0xff042E6F), const Color(0xff00BAF2)],
                )),
                child: Padding(
                  padding: const EdgeInsets.only(top: 65, left: 30, right: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        children: [
                          Text(widget.vehiclename,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                          Icon(
                            Icons.star,
                            color: Color(0xffFFA53E),
                          ),
                          Icon(
                            Icons.star,
                            color: Color(0xffFFA53E),
                          ),
                          Icon(
                            Icons.star,
                            color: Color(0xffFFA53E),
                          ),
                          Icon(
                            Icons.star,
                            color: Color(0xffFFA53E),
                          ),
                          Icon(
                            Icons.star,
                            color: Color(0xffFFA53E),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ];
      }, body: Builder(
        builder: (BuildContext context) {
          return OfflineBuilder(
              connectivityBuilder: (BuildContext context,
                  ConnectivityResult connectivity, Widget child) {
                final bool connected = connectivity != ConnectivityResult.none;
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    child,
                    Positioned(
                      left: 0.0,
                      right: 0.0,
                      height: 32.0,
                      bottom: 1,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        color: connected ? Color(0xFFFFF) : Color(0xFFEE4400),
                        child: connected
                            ? Row()
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "OFFLINE",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  SizedBox(
                                    width: 12.0,
                                    height: 12.0,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.0,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ],
                );
              },
              child: Padding(
                padding: EdgeInsets.only(
                    left: _width * 0.030, right: _width * 0.030, top: 10),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Color(0xff9BE8FF), width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: ListView(
                    padding: EdgeInsets.all(0.0),
                    scrollDirection: Axis.vertical,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: double.infinity,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                CarouselSlider(
                                  options: CarouselOptions(
                                    height: 200.0,
                                    aspectRatio: 16 / 9,
                                    viewportFraction: 1,
                                  ),
                                  carouselController: buttonCarouselController,
                                  items: imageLinks.map((imageLink) {
                                    return Builder(
                                      builder: (BuildContext context) {
                                        return Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 5.0),
                                            child: Image.network(
                                              imageLink,
                                              fit: BoxFit.cover,
                                            ));
                                      },
                                    );
                                  }).toList(),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                    height: 50,
                                    width: _width - _width * 0.060 - 16,
                                    child: Row(
                                      children: [
                                        InkWell(
                                          child: Image.network(imageLinks[0],
                                              fit: BoxFit.cover,
                                              width: (_width -
                                                      _width * 0.060 -
                                                      16) /
                                                  4.5),
                                          onTap: () {
                                            setState(() {
                                              buttonCarouselController
                                                  .jumpToPage(0);
                                            });
                                          },
                                        ),
                                        Spacer(),
                                        InkWell(
                                          child: Image.network(imageLinks[1],
                                              fit: BoxFit.cover,
                                              width: (_width -
                                                      _width * 0.060 -
                                                      16) /
                                                  4.5),
                                          onTap: () {
                                            setState(() {
                                              buttonCarouselController
                                                  .jumpToPage(1);
                                            });
                                          },
                                        ),
                                        Spacer(),
                                        InkWell(
                                          child: Image.network(imageLinks[2],
                                              fit: BoxFit.cover,
                                              width: (_width -
                                                      _width * 0.060 -
                                                      16) /
                                                  4.5),
                                          onTap: () {
                                            setState(() {
                                              buttonCarouselController
                                                  .jumpToPage(2);
                                            });
                                          },
                                        ),
                                        Spacer(),
                                        InkWell(
                                          child: Image.network(imageLinks[3],
                                              fit: BoxFit.cover,
                                              width: (_width -
                                                      _width * 0.060 -
                                                      16) /
                                                  4.5),
                                          onTap: () {
                                            setState(() {
                                              buttonCarouselController
                                                  .jumpToPage(3);
                                            });
                                          },
                                        ),
                                      ],
                                    ))
                              ]),
                        ),
                      ),
                      SizedBox(
                        height: 0.044 * _height,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.vehiclerate + " SAR",
                              // '600 SAR',
                              textScaleFactor: 1.2,
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.84),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Mileage " + widget.vehiclemilage,
                              // AppLocalizations.of(context).translate(
                              //   'mileage',
                              // ),
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Tajawal',
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 0.014 * _height,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Text(
                          AppLocalizations.of(context).translate(
                            'cd_200km',
                          ),
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Tajawal',
                              color: Colors.grey),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Divider(
                          color: Color(0xFF707070),
                        ),
                      ),
                      SizedBox(
                        height: 0.014 * _height,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Text(
                          "Insurance Expired Date  " +
                              widget.vehicleinsurance
                                  .toString()
                                  .substring(0, 10),
                          // AppLocalizations.of(context).translate(
                          //   'Insurance',
                          // ),
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Tajawal'),
                        ),
                      ),
                      SizedBox(
                        height: 0.038 * _height,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Container(
                          height: _height / 4,
                          child: GoogleMap(
                            mapType: MapType.normal,
                            markers: _createMarker(),
                            initialCameraPosition: CameraPosition(
                              target: LatLng(double.parse(widget.vehicalelang),
                                  double.parse(widget.vehicalelong)),
                              zoom: 15.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 0.037 * _height,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Text(
                          widget.vehicledescprition,
                          // AppLocalizations.of(context).translate(
                          //   'Map_text',
                          // ),
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Tajawal'),
                        ),
                      ),
                      SizedBox(
                        height: 0.015 * _height,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                AppLocalizations.of(context).translate(
                                  'cd_booking_date',
                                ),
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Tajawal'),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            datechoose
                                ? InkWell(
                                    onTap: () {
                                      setState(() {
                                        wrongdatechoose = false;
                                        datechoose = false;
                                        dayss = "";
                                      });
                                    },
                                    child: Image.asset(
                                      'assets/images/ic-calendar.png',
                                      width: 20,
                                      height: 20,
                                      color: Color(0xFF00BAF2),
                                    ),
                                  )
                                : Container(
                                    color: Colors.white,
                                  ),
                            Spacer(),
                            Row(
                              children: [
                                days == null
                                    ? Text("")
                                    : Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Text(
                                          dayss.toString(),
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                SizedBox(
                                  width: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    AppLocalizations.of(context).translate(
                                      'cd_sar',
                                    ),
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Tajawal'),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 0.015 * _height,
                      ),
                      wrongdatechoose
                          ? Container(
                              color: Colors.white,
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Card(
                                  elevation: 1.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Padding(
                                      padding: EdgeInsets.only(
                                          top: 0.020 * _height,
                                          left: 0.045 * _width,
                                          bottom: 0.030 * _height,
                                          right: 0.045 * _width),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            AppLocalizations.of(context)
                                                .translate(
                                              'cd_date_time',
                                            ),
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.normal,
                                                fontFamily: 'Tajawal'),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)
                                                    .translate(
                                                  'cd_choose_date_time',
                                                ),
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontFamily: 'Tajawal'),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  DateTimeRangePicker(
                                                      startText: "From",
                                                      endText: "To",
                                                      doneText: "Yes",
                                                      cancelText: "Cancel",
                                                      interval: 5,
                                                      initialStartTime:
                                                          DateTime.now(),
                                                      initialEndTime: now.add(
                                                          Duration(days: 2)),
                                                      mode:
                                                          DateTimeRangePickerMode
                                                              .dateAndTime,
                                                      minimumTime: now.subtract(
                                                          Duration(days: 5)),
                                                      maximumTime: now.add(
                                                          Duration(days: 250)),
                                                      onConfirm: (start, end) {
                                                        setState(() {
                                                          bookingFrom = start;
                                                          bookingTo = end;
                                                          datechoose = true;
                                                          wrongdatechoose =
                                                              true;

                                                          days = (DateTime.parse(
                                                                          bookingTo
                                                                              .toString())
                                                                      .difference(
                                                                          DateTime.parse(bookingFrom
                                                                              .toString()))
                                                                      .inMinutes *
                                                                  double.parse(
                                                                      widget
                                                                          .vehiclerate)) /
                                                              1440;

                                                          dayss = days
                                                              .toStringAsFixed(
                                                                  2);
                                                        });
                                                        print(start.toString());
                                                        print(end.toString());
                                                        print(days);
                                                      }).showPicker(context);
                                                },
                                                child: Image.asset(
                                                  'assets/images/ic-calendar.png',
                                                  width: 20,
                                                  height: 20,
                                                  color: Color(0xFF00BAF2),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ))),
                            ),
                      datechoose
                          ? Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Card(
                                //  elevation: 1.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: 0.020 * _height,
                                    //  left: 0.045 * _width,
                                    bottom: 0.010 * _height,
                                    // right: 0.045 * _width
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        "From: " +
                                            bookingFrom.toString().substring(
                                                0,
                                                bookingFrom.toString().length -
                                                    7),
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      // SizedBox(
                                      //   height: 10,
                                      // ),
                                      Divider(
                                        color: Colors.grey,
                                      ),
                                      Text(
                                        "To:  " +
                                            bookingTo.toString().substring(
                                                0,
                                                bookingTo.toString().length -
                                                    7),
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              color: Colors.white,
                            ),
                      SizedBox(
                        height: 0.035 * _height,
                      ),
                      ListTile(
                        leading: CircularCheckBox(
                            value: this.selected,
                            checkColor: Colors.white,
                            activeColor: Color(0xffFF741A),
                            inactiveColor: Color(0xffFF741A),
                            disabledColor: Colors.red,
                            onChanged: (val) => this.setState(() {
                                  this.selected = !this.selected;
                                })),
                        title: Text(
                          AppLocalizations.of(context).translate(
                            'cd_valid_license',
                          ),
                          style: TextStyle(
                              color: Color(0xffFF741A),
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Tajawal'),
                        ),
                        onTap: () => this.setState(() {
                          this.selected = !this.selected;
                        }),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child:
                              //selected?
                              RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            onPressed: () {
                              selected
                                  ? token == ""
                                      ? Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => LoginUi(),
                                          ),
                                        )
                                      : showAlertDialogconfirmBook(context)
                                  : showAlertDialogtermcheck(context);
                            },
                            color: Color(0xFF042E6F),
                            padding: EdgeInsets.all(16.0),
                            textColor: Colors.white,
                            child: Text(
                              AppLocalizations.of(context).translate(
                                'cd_book_now',
                              ),
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Tajawal'),
                            ),
                          )),
                      SizedBox(
                        height: 0.035 * _height,
                      ),
                    ],
                  ),
                ),
              ));
        },
      )),
    );
  }

  showAlertDialogtermcheck(BuildContext context) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Please Tick Valid Driver Licenses"),
      content: Text("Have a Good Day"),
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
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialogconfirmBook(BuildContext context) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Your request has been submitted !"),
      content: Text("You can Track it on My Bookings"),
      actions: [
        new FlatButton(
          onPressed: () {
            // dismisses only the dialog and returns nothing
            Navigator.pop(context);
            Navigator.pop(context);
          },
          child: new Text('OK'),
        ),
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
