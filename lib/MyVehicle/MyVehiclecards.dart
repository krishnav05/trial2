import 'dart:async';
import 'dart:convert';
import 'package:Ajreeha/Drawer%20screen/myvehicles.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'EditmyCar.dart';

class Job {
  /*------------------------------------------------------------------------------------------*/
  int id;
  String userId;
  String vehicleType;
  String vehicleModel;
  String vehicleYear;
  String vehicleColor;
  String vehicleRentPerDay;
  String vehicleDescription;
  DateTime vehicleInsuranceExpireDate;
  String vehicleMileage;
  String vehicleDoor;
  String vehicleSeatCapacity;
  String vehicleCondition;
  String city;
  String latitude;
  String longitude;
  String frontLeftSideTick;
  String frontLeftSideText;
  dynamic frontLeftSideImage;
  String frontLeftSideName;
  String frontRightSideTick;
  dynamic frontRightSideText;
  dynamic frontRightSideImage;
  dynamic frontRightSideName;
  String middleLeftSideTick;
  dynamic middleLeftSideText;
  dynamic middleLeftSideImage;
  dynamic middleLeftSideName;
  String middleRightSideTick;
  dynamic middleRightSideText;
  dynamic middleRightSideImage;
  dynamic middleRightSideName;
  String backLeftSideTick;
  dynamic backLeftSideText;
  dynamic backLeftSideImage;
  dynamic backLeftSideName;
  String backRightSideTick;
  dynamic backRightSideText;
  dynamic backRightSideImage;
  dynamic backRightSideName;
  dynamic image1;
  dynamic image1Name;
  dynamic image2;
  String image2Name;
  dynamic image3;
  String image3Name;
  dynamic image4;
  dynamic image4Name;
  DateTime createdAt;
  DateTime updatedAt;
  String image1_encode;
  String front_left_encode;
  String front_right_encode;
  String middle_left_encode;
  String middle_right_encode;
  String back_left_encode;
  String back_right_encode;
  String image2_encode;
  String image3_encode;
  String image4_encode;

  /*------------------------------------------------------------------------------------------*/

  Job({
    this.id,
    this.userId,
    this.vehicleType,
    this.vehicleModel,
    this.vehicleYear,
    this.vehicleColor,
    this.vehicleRentPerDay,
    this.vehicleDescription,
    this.vehicleInsuranceExpireDate,
    this.vehicleMileage,
    this.vehicleDoor,
    this.vehicleSeatCapacity,
    this.vehicleCondition,
    this.city,
    this.latitude,
    this.longitude,
    this.frontLeftSideTick,
    this.frontLeftSideText,
    this.frontLeftSideImage,
    this.frontLeftSideName,
    this.frontRightSideTick,
    this.frontRightSideText,
    this.frontRightSideImage,
    this.frontRightSideName,
    this.middleLeftSideTick,
    this.middleLeftSideText,
    this.middleLeftSideImage,
    this.middleLeftSideName,
    this.middleRightSideTick,
    this.middleRightSideText,
    this.middleRightSideImage,
    this.middleRightSideName,
    this.backLeftSideTick,
    this.backLeftSideText,
    this.backLeftSideImage,
    this.backLeftSideName,
    this.backRightSideTick,
    this.backRightSideText,
    this.backRightSideImage,
    this.backRightSideName,
    this.image1,
    this.image1Name,
    this.image2,
    this.image2Name,
    this.image3,
    this.image3Name,
    this.image4,
    this.image4Name,
    this.createdAt,
    this.updatedAt,
    this.image1_encode,
    this.front_left_encode,
    this.front_right_encode,
    this.middle_left_encode,
    this.middle_right_encode,
    this.back_left_encode,
    this.back_right_encode,
    this.image2_encode,
    this.image3_encode,
    this.image4_encode,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json["id"],
      userId: json["user_id"],
      vehicleType: json["vehicle_type"],
      vehicleModel: json["vehicle_model"],
      vehicleYear: json["vehicle_year"],
      vehicleColor: json["vehicle_color"],
      vehicleRentPerDay: json["vehicle_rent_per_day"],
      vehicleDescription: json["vehicle_description"],
      vehicleInsuranceExpireDate:
          DateTime.parse(json["vehicle_insurance_expire_date"]),
      vehicleMileage: json["vehicle_mileage"],
      vehicleDoor: json["vehicle_door"],
      vehicleSeatCapacity: json["vehicle_seat_capacity"],
      vehicleCondition: json["vehicle_condition"],
      city: json["city"],
      latitude: json["latitude"],
      longitude: json["longitude"],
      frontLeftSideTick: json["front_left_side_tick"],
      frontLeftSideText: json["front_left_side_text"],
      frontLeftSideImage: json["front_left_side_image"],
      frontLeftSideName: json["front_left_side_name"],
      frontRightSideTick: json["front_right_side_tick"],
      frontRightSideText: json["front_right_side_text"],
      frontRightSideImage: json["front_right_side_image"],
      frontRightSideName: json["front_right_side_name"],
      middleLeftSideTick: json["middle_left_side_tick"],
      middleLeftSideText: json["middle_left_side_text"],
      middleLeftSideImage: json["middle_left_side_image"],
      middleLeftSideName: json["middle_left_side_name"],
      middleRightSideTick: json["middle_right_side_tick"],
      middleRightSideText: json["middle_right_side_text"],
      middleRightSideImage: json["middle_right_side_image"],
      middleRightSideName: json["middle_right_side_name"],
      backLeftSideTick: json["back_left_side_tick"],
      backLeftSideText: json["back_left_side_text"],
      backLeftSideImage: json["back_left_side_image"],
      backLeftSideName: json["back_left_side_name"],
      backRightSideTick: json["back_right_side_tick"],
      backRightSideText: json["back_right_side_text"],
      backRightSideImage: json["back_right_side_image"],
      backRightSideName: json["back_right_side_name"],
      image1: json["image1"],
      image1Name: json["image1name"],
      image2: json["image2"],
      image2Name: json["image2name"],
      image3: json["image3"],
      image3Name: json["image3name"],
      image4: json["image4"],
      image4Name: json["image4name"],
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
      image1_encode: json["image1_encode"],
      front_left_encode: json["front_left_encode"],
      front_right_encode: json["front_right_encode"],
      middle_left_encode: json["middle_left_encode"],
      middle_right_encode: json["middle_right_encode"],
      back_left_encode: json["back_left_encode"],
      back_right_encode: json["back_right_encode"],
      image2_encode: json["image2_encode"],
      image3_encode: json["image2_encode"],
      image4_encode: json["image4_encode"],
    );
  }
}

class Myvehiclecards extends StatefulWidget {
  @override
  _MyvehiclecardsState createState() => _MyvehiclecardsState();
}

class _MyvehiclecardsState extends State<Myvehiclecards> {
  SharedPreferences prefs;
  String token;
  bool emptyVehicle = false;
  List jsonResponse;
  Future<List<Job>> _fetchJobs() async {
    prefs = await SharedPreferences.getInstance();
    token = prefs.getString('value_key');
    final jobsListAPIUrl = 'https://ajerrha.com/api/my/vehicles';
    final response = await http
        .get(jobsListAPIUrl, headers: {'Authorization': 'Bearer ' + token});
    // print("tokenvehicale" + token);
    if (response.statusCode == 200) {
      // if (json.decode(response.body)) {
      //   setState(() {
      //     emptyVehicle = true;
      //     //   print("check" + emptyVehicle.toString());
      //   });
      // }
      jsonResponse = json.decode(response.body);
      // print("json" + json.decode(response.body));
      return jsonResponse.map((job) => new Job.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  @override
  void initState() {
    _fetchJobs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Job>>(
      future: _fetchJobs(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          //  print(snapshot.data);
          List<Job> data = snapshot.data;
          // print(data.length);
          if (data.length > 0) {
            return MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(
                        thickness: 1,
                        height: 1,
                        color: Colors.black12,
                      ),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    print(emptyVehicle);
                    return Card(
                      elevation: 0.0,
                      child: Row(
                        children: [
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, top: 8.0, bottom: 8, right: 8),
                                child: Container(
                                    height:
                                        MediaQuery.of(context).size.height / 9,
                                    width:
                                        MediaQuery.of(context).size.width / 3.4,
                                    decoration: new BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            'https://ajerrha.com/vehicles/${data[index].id}/${data[index].image2Name}'),
                                        fit: BoxFit.fill,
                                      ),
                                      borderRadius: BorderRadius.circular(5.0),
                                    )),
                              ),
                              Container(
                                height: MediaQuery.of(context).size.height / 8,
                                // color: Colors.blue,
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 9,
                                    ),
                                    Text(
                                      data[index]
                                          .vehicleType, // new_data[index]['name'],
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                          fontFamily: 'Tajawal'),
                                    ),
                                    SizedBox(
                                      height: 9,
                                    ),

                                    Text(
                                      data[index].vehicleDescription,
                                      //  new_data[index]['ownername'],
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily: 'Tajawal',
                                        fontWeight: FontWeight.w700,
                                        // color: Color(0xffFF741A)
                                      ),
                                    ),

                                    SizedBox(
                                      height: 9,
                                    ),
                                    // Text( AppLocalizations.of(context).translate(new_data[index]['price']))
                                    Text(
                                      data[index].vehicleRentPerDay +
                                          " SAR Per Day",
                                      // new_data[index]['price'],
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily: 'Tajawal',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Container(
                                  // color: Colors.blue,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      FlatButton(
                                        // heroTag: "btn1",
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => EditmyCar(
                                                vehicaleid:
                                                    data[index].id.toString(),
                                              ),
                                            ),
                                          );
                                        },
                                        child: Icon(Icons.edit),
                                      ),
                                      FlatButton(
                                        onPressed: () {
                                          http.post(
                                            'https://ajerrha.com/api/my/delete',
                                            body: jsonEncode({
                                              "id": data[index].id.toString(),
                                            }),
                                            headers: {
                                              'Content-Type':
                                                  'application/json',
                                              'Authorization': 'Bearer ' + token
                                            },
                                          ).then((response) async {
                                            final res = json.decode(response
                                                .body); // Retrieve value later
                                            print(res["token"]);
                                            print(res["status"]);

                                            if (res["status"] == "success") {
                                              print("Delete carlist");

                                              Navigator.pop(context);
                                              Navigator.pop(context);

                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MyVehicles()),
                                              );
                                            } else {
                                              print("Delete carlist error");
                                            }
                                          });
                                        },
                                        child: Icon(Icons.delete),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
            );
          } else {
            return Center(child: Text("No vehicle Added"));
          }
        } else if (snapshot.hasError) {
          return Center(
            child: Column(
              children: [
                Text(" Network Issues"),
                Text("${snapshot.error}"),
              ],
            ),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
