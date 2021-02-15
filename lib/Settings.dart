import 'dart:convert';
import 'dart:io';
import 'package:Ajreeha/Api/util/validators.dart';
import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/material.dart';
import 'package:Ajreeha/localization/App_localization.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:Ajreeha/Dialog/Dialogmobilecheck.dart';
import 'dart:async';
import 'package:sms_otp_auto_verify/sms_otp_auto_verify.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool onTapcreate = false;
  bool isregister = false;
  File _image;
  var photopath;
  var photopath10;
  String photo64;
  bool isOtpScreenVisible = false;
  bool completeaccount = false;

  // ignore: non_constant_identifier_names
  void open_camera() async {
    // ignore: deprecated_member_use
    var imagepath = await ImagePicker.pickImage(source: ImageSource.camera);
    final bytes = imagepath.readAsBytesSync();
    String _img64 = base64Encode(bytes);
    print(_img64);
    print("image");
    print(imagepath);

    setState(() {
      _image = imagepath;
      photopath = (imagepath.toString().split('/').last);
      photopath10 = (photopath.toString().split("'").first);
      photo64 = _img64;
    });
  }

  // ignore: non_constant_identifier_names
  void open_gallery() async {
    // ignore: deprecated_member_use
    var imagepath = await ImagePicker.pickImage(source: ImageSource.gallery);
    final bytes = imagepath.readAsBytesSync();
    String _img64 = base64Encode(bytes);
    print(_img64);
    print("image");
    print(imagepath);

    setState(() {
      _image = imagepath;
      photopath = (imagepath.toString().split('/').last);
      photopath10 = (photopath.toString().split("'").first);
      photo64 = _img64;
    });
  }

  bool validate = false;
  bool selected = false;

  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final GlobalKey<FormState> _form2 = GlobalKey<FormState>();
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController mobilecontroller = TextEditingController();
  TextEditingController dobcontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController idcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final TextEditingController confirmpasswordcontroller =
      TextEditingController();

  final TextEditingController controller = TextEditingController();
  String newisoCode;
  String initialCountry = 'SA';
  PhoneNumber number = PhoneNumber(isoCode: 'SA');
  var mobile_no = "";
  var save_mobile;
  @override
  void initState() {
    super.initState();
    dobcontroller = TextEditingController();
    _getSignatureCode();
  }

  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 5), child: Text("Loading")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialogerror(BuildContext context) {
    AlertDialog alert = AlertDialog(
      //  title:
      content: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                  child: Icon(
                Icons.error_outline,
                color: Color(0xffFF741A),
                size: 40,
              )),
              Center(
                  child: Text(
                "Error",
                textScaleFactor: 1.5,
                style: TextStyle(color: Color(0xffFF741A)),
              )),
              SizedBox(height: 5),
              Text("you are fill something wrong"),
              Text("else left empty some field "),
              Text("or No image "),
              Text(" or Please Agree Condition "),
            ],
          ),
        ),
      ),
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
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  _verifyOtpsender() {
    http.post(
      'https://ajerrha.com/api/check/mobile',
      body: jsonEncode({
        'mobile': mobile_no,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    ).then((response) {
      final res = json.decode(response.body);
      print(res["status"]);
      if (res["status"] == "success") {
        setState(() {
          isOtpScreenVisible = true;
        });
      } else if (res["status"] == "error") {
        showAlertDialogerrormobilecheck(context);
        setState(() {
          isOtpScreenVisible = false;
        });
      }

      print(mobilecontroller.text);
      print(response.body);
      print(isregister);
    });
  }

/*-----------------------------------------------------------------------------------------------------*/
  int _otpCodeLength = 4;
  bool _isLoadingButton = false;
  bool _enableButton = false;
  String _otpCode = "";
  bool resendbtncolor = false;

  _getSignatureCode() async {
    String signature = await SmsRetrieved.getAppSignature();
    print("signature $signature");
  }

  _onSubmitOtp() {
    setState(() {
      _isLoadingButton = !_isLoadingButton;
      _verifyOtpCode();
    });
  }

  _onOtpCallBack(String otpCode, bool isAutofill) {
    setState(() {
      this._otpCode = otpCode;
      if (otpCode.length == _otpCodeLength && isAutofill) {
        _enableButton = false;
        _isLoadingButton = true;
        _verifyOtpCode();
      } else if (otpCode.length == _otpCodeLength && !isAutofill) {
        _enableButton = true;
        _isLoadingButton = false;
      } else {
        _enableButton = false;
      }
    });
  }

  _verifyOtpCode() {
    _verifyOtp();
    FocusScope.of(context).requestFocus(new FocusNode());
    Timer(Duration(milliseconds: 4000), () {
      setState(() {
        _isLoadingButton = false;
        _enableButton = false;
      });
    });
  }

  _verifyOtp() {
    http.post(
      'https://ajerrha.com/api/verify/mobile',
      body: jsonEncode({
        'mobile': mobile_no,
        "otp": _otpCode,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    ).then((response) async {
      final res = json.decode(response.body);
      print(res["status"]);
      // bool   isregister = false;

      if (res["status"] == "success") {
        setState(() {
          isOtpScreenVisible = false;
          number = PhoneNumber(
              phoneNumber: mobilecontroller.text, isoCode: newisoCode);
          isregister = true;
        });
      }
      print(response.body);
      //  print(isregister);
    });
  }

  _resend() {
    http.post(
      'https://ajerrha.com/api/resend/mobile',
      body: jsonEncode({
        'mobile': mobile_no,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    ).then((response) {
      final res = json.decode(response.body);
      print(res["status"]);
      if (res["status"] == "success") {
        setState(() {
          resendbtncolor = true;
        });
      }
      print("ResendCode" + response.body);
    });
  }

/*-----------------------------------------------------------------------------------------------------*/

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    //  AuthProvider auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Edit Account",
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
      body: Builder(
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
                      height: 30.0,
                      bottom: 1,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        color: connected ? Color(0xFFFFFF) : Color(0xFFEE4400),
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
              child: isOtpScreenVisible
                  ? WillPopScope(
                      onWillPop: () async => false,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Verification",
                                style: TextStyle(
                                    color: Color(0xffFF741A), fontSize: 40),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Enter the 4 digit verification code you got on your phone",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(mobile_no),
                              SizedBox(
                                height: 15,
                              ),
                              TextFieldPin(
                                // filled: true,
                                filledColor: Color(0xffFF741A),
                                codeLength: _otpCodeLength,
                                boxSize: 40,
                                filledAfterTextChange: false,
                                textStyle: TextStyle(fontSize: 16),
                                onOtpCallback: (code, isAutofill) =>
                                    _onOtpCallBack(code, isAutofill),
                              ),
                              SizedBox(
                                height: 32,
                              ),
                              Container(
                                width: _width / 1.2,
                                child: MaterialButton(
                                  onPressed:
                                      _enableButton ? _onSubmitOtp : null,
                                  child: _setUpButtonChild(),
                                  color: Color(0xff042E6F),
                                  disabledColor: Color(0xff042E6F),
                                ),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              InkWell(
                                child: Text(
                                  "ReSend",
                                  style: TextStyle(
                                      color: resendbtncolor
                                          ? Colors.green
                                          : Colors.black),
                                ),
                                onTap: () {
                                  _resend();
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : SingleChildScrollView(
                      child: Container(
                        child: Column(
                          children: [
                            Form(
                              key: _form2,
                              child: ListView(
                                padding: EdgeInsets.all(10.0),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                primary: false,
                                physics: NeverScrollableScrollPhysics(),
                                children: [
                                  completeaccount
                                      ? Text(
                                          "Basic Information",
                                          style: TextStyle(
                                              color: Color(0xffFF741A),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        )
                                      : Container(
                                          color: Colors.white,
                                        ),
                                  Padding(
                                      padding: EdgeInsets.all(10),
                                      child: TextFormField(
                                        enabled: completeaccount ? false : true,
                                        controller: namecontroller,
                                        validator: (val) {
                                          if (val.isEmpty) return 'Empty';
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Name',
                                            hintText: 'Sayed'),
                                      )),
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Container(
                                      height: 75,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border:
                                              Border.all(color: Colors.grey)),
                                      child: InternationalPhoneNumberInput(
                                        isEnabled: isregister ? false : true,
                                        inputBorder: InputBorder.none,
                                        ignoreBlank: false,
                                        spaceBetweenSelectorAndTextField: 0,
                                        onInputChanged: (PhoneNumber number) {
                                          print(number.isoCode);
                                          setState(() {
                                            mobile_no = number.phoneNumber;
                                            initialCountry = "AX";
                                            newisoCode = number.isoCode;
                                            PhoneNumber(phoneNumber: mobile_no);
                                          });
                                        },
                                        selectorConfig: SelectorConfig(
                                          selectorType: PhoneInputSelectorType
                                              .BOTTOM_SHEET,
                                        ),
                                        selectorTextStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                        initialValue: number,
                                        textFieldController: mobilecontroller,
                                        formatInput: false,
                                        keyboardType:
                                            TextInputType.numberWithOptions(
                                                signed: true, decimal: true),
                                      ),
                                    ),
                                  ),
                                  isregister
                                      ? Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            width: _width,
                                            child: FlatButton(
                                                color: Colors.grey,
                                                child: Text(
                                                  "Verify",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                onPressed: () {}),
                                          ),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            width: _width,
                                            child: FlatButton(
                                                color: Color(0xffFF741A),
                                                child: Text(
                                                  "Verify",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                onPressed: () {
                                               //   _verifyOtpsender();
                                                }),
                                          ),
                                        ),
                                  Padding(
                                      padding: EdgeInsets.all(10),
                                      child: TextFormField(
                                        enabled: completeaccount ? false : true,
                                        controller: passwordcontroller,
                                        keyboardType: TextInputType.text,
                                        validator: (x) => x.length > 7
                                            ? null
                                            : 'Too short pls make password atleast 8 digit',
                                        obscureText: true,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Password',
                                            hintText: 'Password'),
                                      )),
                                  Padding(
                                      padding: EdgeInsets.all(10),
                                      child: TextFormField(
                                        enabled: completeaccount ? false : true,
                                        keyboardType: TextInputType.text,
                                        controller: confirmpasswordcontroller,
                                        validator: (value) {
                                          if (value !=
                                              passwordcontroller.text) {
                                            return 'Not Match Password';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'confirm Password',
                                            hintText: 'confirm Password'),
                                      )),
                                  completeaccount
                                      ? Container(
                                          color: Colors.white,
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: FlatButton(
                                            child: Text(
                                              "Submit",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            color: Colors.blue,
                                            onPressed: () {
                                              if (_form2.currentState
                                                  .validate()) {
                                                setState(() {
                                                  completeaccount = true;
                                                  save_mobile = mobile_no;
                                                });
                                              }
                                            },
                                          ),
                                        )
                                ],
                              ),
                            ),
                            Form(
                              key: _form,
                              child: ListView(
                                padding: EdgeInsets.all(10.0),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                primary: false,
                                physics: NeverScrollableScrollPhysics(),
                                children: [
                                  Text(
                                    "Additional Information",
                                    style: TextStyle(
                                        color: Color(0xffFF741A),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.all(10),
                                      child: TextFormField(
                                        readOnly: true,
                                        controller: dobcontroller,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Date of Birth',
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
                                                  firstDate: DateTime(1949, 1),
                                                  lastDate: DateTime.now(),
                                                  builder:
                                                      (BuildContext context,
                                                          Widget picker) {
                                                    return Theme(
                                                      data: ThemeData.dark()
                                                          .copyWith(
                                                        colorScheme:
                                                            ColorScheme.dark(
                                                          primary: Colors.blue,
                                                          onPrimary:
                                                              Colors.white,
                                                          surface: Colors.blue,
                                                          onSurface:
                                                              Colors.black,
                                                        ),
                                                        dialogBackgroundColor:
                                                            Colors.white,
                                                      ),
                                                      child: picker,
                                                    );
                                                  }).then((selectedDate) {
                                                if (selectedDate != null) {
                                                  dobcontroller.text =
                                                      selectedDate
                                                          .toString()
                                                          .substring(0, 10);
                                                } else {
                                                  dobcontroller.text = null;
                                                }
                                              });
                                            },
                                          ),
                                        ),
                                      )),
                                  Padding(
                                      padding: EdgeInsets.all(10),
                                      child: TextFormField(
                                        controller: emailcontroller,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        validator: validateEmail,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Email',
                                            hintText: 'Syeedd777@hotmail.com'),
                                      )),
                                  Padding(
                                      padding: EdgeInsets.all(10),
                                      child: TextFormField(
                                        controller: idcontroller,
                                        validator: (val) {
                                          if (val.isEmpty) return 'Empty';
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'ID',
                                          hintText: '3677 2595 6999',
                                        ),
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Upload License images"),
                                          SizedBox(height: 5),
                                          Row(
                                            children: [
                                              Container(
                                                color: Colors.black12,
                                                height: 100.0,
                                                width: 210.0,
                                                child: Center(
                                                  child: _image == null
                                                      ? Text("No image")
                                                      : Stack(children: [
                                                          Container(
                                                            height: 100.0,
                                                            width: 210.0,
                                                            child: Image.file(
                                                                _image),
                                                          ),
                                                          Align(
                                                            alignment: Alignment
                                                                .topRight,
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  _image = null;
                                                                });
                                                              },
                                                              child: Icon(
                                                                Icons.delete,
                                                                color: Color(
                                                                    0xffff741A),
                                                              ),
                                                            ),
                                                          )
                                                        ]),
                                                ),
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: <Widget>[
                                                  FlatButton(
                                                    //  heroTag: "btn1",
                                                    onPressed: open_camera,

                                                    // tooltip: "pickImage",
                                                    child: Icon(
                                                      Icons.add_a_photo,
                                                      color: Color(0xFF042E6F),
                                                    ),
                                                  ),
                                                  FlatButton(
                                                    //  heroTag: "btn2",
                                                    onPressed: open_gallery,

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
                                  ),
                                  ListTile(
                                    leading: CircularCheckBox(
                                        value: this.selected,
                                        checkColor: Colors.white,
                                        activeColor: Color(0xffFF741A),
                                        inactiveColor: Color(0xffFF741A),
                                        disabledColor: Colors.grey,
                                        onChanged: (val) => this.setState(() {
                                              this.selected = !this.selected;
                                            })),
                                    title: Text(
                                      AppLocalizations.of(context).translate(
                                        'valid',
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
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: SizedBox(
                                          width: _width * 0.90,
                                          child: onTapcreate
                                              ? RaisedButton(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                  ),
                                                  onPressed: () {},
                                                  color: Color(0xFF042E6F),
                                                  padding: EdgeInsets.all(16.0),
                                                  textColor: Colors.white,
                                                  child:
                                                      CircularProgressIndicator(),
                                                )
                                              : RaisedButton(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                  ),
                                                  onPressed: isregister
                                                      ? () async {
                                                          if (_form.currentState
                                                                  .validate() &&
                                                              _image != null) {
                                                            setState(() {
                                                              onTapcreate =
                                                                  true;
                                                            });
                                                            //  print(save_mobile);
                                                            http.post(
                                                              'https://ajerrha.com/api/register',
                                                              body: jsonEncode({
                                                                'name':
                                                                    namecontroller
                                                                        .text,
                                                                'email':
                                                                    emailcontroller
                                                                        .text,
                                                                'password':
                                                                    passwordcontroller
                                                                        .text,
                                                                'mobile':
                                                                    save_mobile,
                                                                'dob':
                                                                    dobcontroller
                                                                        .text,
                                                                'license_id':
                                                                    idcontroller
                                                                        .text,
                                                                'license_name':
                                                                    photopath10
                                                                        .toString(),
                                                                'image':
                                                                    photo64,
                                                              }),
                                                              headers: {
                                                                'Content-Type':
                                                                    'application/json',
                                                              },
                                                            ).then((response) {
                                                              final res =
                                                                  json.decode(
                                                                      response
                                                                          .body);
                                                              print(res);
                                                              print(res[
                                                                  "status"]);
                                                              if (res["status"] ==
                                                                  "success") {
                                                                isregister =
                                                                    true;

                                                                Navigator.pop(
                                                                    context);
                                                              } else {
                                                                setState(() {
                                                                  print(
                                                                      "error not success");
                                                                  onTapcreate =
                                                                      false;
                                                                });
                                                              }
                                                            });
                                                          } else {
                                                            setState(() {
                                                              onTapcreate =
                                                                  false;
                                                            });
                                                            showAlertDialogerror(
                                                                context);
                                                          }
                                                        }
                                                      : null,
                                                  color: Color(0xFF042E6F),
                                                  padding: EdgeInsets.all(16.0),
                                                  textColor: Colors.white,
                                                  child: Text(
                                                    "Save Changes",
                                                    // AppLocalizations.of(context)
                                                    //     .translate(
                                                    //   'Create account',
                                                    // ),
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily: 'Tajawal'),
                                                  ),
                                                ))),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ));
        },
      ),
    );
  }

  showAlertDialogcompletesucessfull(BuildContext context) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Account SuccessFully Created "),
      content: Text("Have a Good Day"),
      actions: [
        new FlatButton(
          onPressed: () {
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

  Widget _setUpButtonChild() {
    if (_isLoadingButton) {
      return Container(
        width: 19,
        height: 19,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    } else {
      return Text(
        "Verify",
        style: TextStyle(color: Colors.white),
      );
    }
  }
}
