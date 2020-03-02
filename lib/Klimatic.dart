import 'dart:async';
import 'dart:core';
import 'package:flutter/material.dart';
import './util/utils.dart' as util;
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;

class Klimatic extends StatefulWidget {
  @override
  _KlimaticState createState() => _KlimaticState();
}

class _KlimaticState extends State<Klimatic> {
  void showStuff() async {
    Map data = await getWeather(util.appId, util.defaultCity);
    print(data.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: new Text("Weather App"),
        backgroundColor: Colors.blue[200],
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.menu),
            onPressed: showStuff,
          )
        ],
      ),


      body: new Stack(
        children: <Widget>[
          new Center(
            child: new Image.asset(
              'images/umbrella.png',
              width: 470.0,
              height: 1200.0,
              fit: BoxFit.fill,
            ),
          ),
          new Container(
            alignment: Alignment.topRight,
            margin: const EdgeInsets.fromLTRB(0.0, 10.9, 20.9, 0.0),
            child: new Text(
              'Weather',
              style: cityStyle(),
            ),
          ),

          new Container(
            alignment: Alignment.center,
            child: new Image.asset(
              'images/light_rain.png',
            ),
          ),

          //Weather Container
          new Container(
            margin: new EdgeInsets.fromLTRB(30.0, 290.0, 0.0, 0.0),
            child: updateTempWidget("Hyderabad"),
          )
        ],
      ),
    );
  }

  Future<Map> getWeather(String appID, String city) async {
    String apiURL =
        'http://api.openweathermap.org/data/2.5/weather?q=$city&appid=${util.appId}&units=metric';
    http.Response response = await http.get(apiURL);

    return JSON.jsonDecode(response.body);
  }

  Widget updateTempWidget(String city) {
    return new FutureBuilder(
      future: getWeather(util.appId, city),
      builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
        // here we are going to set all the widgets for getting data & operations
        // snapshot contains data which is received by future object
        //FutureBuilder helps to get all the data from future type and builds it.
        if (snapshot.hasData) {
          Map content = snapshot.data;
          return new Container(
            child: new Column(
              children: <Widget>[
                new ListTile(
                  title: new Text(
                    content['main']['temp'].toString(),
                    style: new TextStyle(
                        fontSize: 49.9,
                        fontStyle: FontStyle.normal,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
          );
        }
      },
    );
  }
}

TextStyle cityStyle() {
  return new TextStyle(
    color: Colors.white,
    fontSize: 22.9,
    fontStyle: FontStyle.italic,
  );
}

TextStyle tempStyle() {
  return new TextStyle(
      color: Colors.white,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 49.9);
}
