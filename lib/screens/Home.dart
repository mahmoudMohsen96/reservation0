import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart' as ICON;
import 'package:reservation/widgets/imageSlider.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_file.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //
  Future<void> getData() async {
    HttpOverrides.global = new MyHttpOverrides();
    final response = await http
        .get("https://run.mocky.io/v3/3a1ec9ff-6a95-43cf-8be7-f5daa2122a34");
    final data = json.decode(response.body);
    return data;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
        bottomNavigationBar: Container(
          width: deviceSize.width,
          height: 55,
          color: Colors.purple[800],
          child: Center(
              child: Text(
            "قم بالحجز الان",
            style: TextStyle(
              color: Colors.white,
            ),
          )),
        ),
        body: FutureBuilder(
            future: getData(),
            builder: (ctx, snapShot) {
              if (snapShot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return SingleChildScrollView(
                  child: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            ImageSlider(deviceSize, snapShot.data['img']),
                            AppBar(
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              actions: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: IconButton(
                                    icon: Icon(Icons.share),
                                    onPressed: () {},
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: IconButton(
                                    icon: Icon(Icons.star_border),
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "#${snapShot.data['interest']}",
                                style: TextStyle(color: Colors.grey),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                "${snapShot.data['title']}",
                                style: TextStyle(fontSize: 19),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Wrap(
                                direction: Axis.horizontal,
                                children: <Widget>[
                                  Icon(
                                    Icons.event,
                                    color: Colors.grey,
                                  ),
                                  Text(
                                    DateFormat.MMMMEEEEd().format(
                                            DateTime.parse(
                                                snapShot.data['date'])) +
                                        ", " +
                                        DateFormat.Hm().format(DateTime.parse(
                                            snapShot.data['date'])),
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Wrap(
                                direction: Axis.horizontal,
                                children: <Widget>[
                                  Icon(
                                    ICON.FontAwesomeIcons.thumbtack,
                                    size: 23,
                                    color: Colors.grey,
                                  ),
                                  Text(
                                    "  ${snapShot.data['address']}",
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Divider(
                          thickness: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 2, right: 8, left: 8, bottom: 2),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Wrap(
                                direction: Axis.horizontal,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: <Widget>[
                                  CircleAvatar(
                                    radius: 17,
                                    backgroundImage: NetworkImage(
                                        "${snapShot.data['trainerImg']}"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      "${snapShot.data['trainerName']}",
                                      style: TextStyle(
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                "${snapShot.data['trainerInfo']}",
                                style: TextStyle(
                                  color: Colors.grey[700],
                                ),
                              )
                            ],
                          ),
                        ),
                        Divider(
                          thickness: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 2, right: 8, left: 8, bottom: 2),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "عن الدورة",
                                style: TextStyle(
                                  color: Colors.grey[700],
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "${snapShot.data['occasionDetail']}",
                                style: TextStyle(
                                  color: Colors.grey[700],
                                ),
                              )
                            ],
                          ),
                        ),
                        Divider(
                          thickness: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 2, right: 8, left: 8, bottom: 2),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "تكلفه الدورة",
                                style: TextStyle(
                                  color: Colors.grey[700],
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "الحجز العادي",
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  Text(
                                    "SAR  ${snapShot.data['price']}",
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "الحجز المميز",
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  Text(
                                    "SAR  ${snapShot.data['price']}",
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "الحجز السريع",
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  Text(
                                    "SAR  ${snapShot.data['price']}",
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                );
              }
            }));
  }
}
