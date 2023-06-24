import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:http/http.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = new TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("This is init state");
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    print("set state called");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("widget destroyed");
  }

  @override
  Widget build(BuildContext context) {
    //list variable for showing city names in searchbar
    var city_name = ["Odisha", "Delhi", "Mumbai"];
    final _random = new Random();
    var city = city_name[_random.nextInt(city_name.length)];
    //retrieving data from loading route
    Map? info = ModalRoute.of(context)?.settings.arguments as Map?;

    String temp=((info!['temp_value']).toString());
    String air =(( info['air_speed_value']));
    if(temp == "NA"){print("NA");}
    else{
      temp = ((info['temp_value']).toString()).substring(0,4);
      air = ((info['air_speed_value']).toString()).substring(0,4);
    }

    String icon =info['icon_value'];
    String get_city = info['city_value'];
    String hum = info['hum_value'];
    String desc = info['des_value'];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // manual way of creating color for status bar
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Colors.blue,
        ),
      ),
      /*appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child:GradientAppBar(
          gradient: LinearGradient(
            colors: [
              Colors.pinkAccent,
              Colors.blue
            ],
          ),
        ) ,
      ),*/
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                // stops: [ ],
                colors: [Colors.blue.shade800, Colors.blue.shade300],
              ),
            ),
            child: Column(
              children: [
                //search wala container
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  margin: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: ()
            {
            if((searchController.text).replaceAll(" ", "") == ""){
            print("blank search");
            }else{
            Navigator.pushReplacementNamed(context,"/loading", arguments:
            { "searchText":searchController.text });
            }
            },
                        child: Container(
                          child: Icon(
                            Icons.search,
                            color: Colors.blueAccent,
                          ),
                          margin: EdgeInsets.fromLTRB(3, 0, 7, 0),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search $city",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white.withOpacity(0.5),
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 25),
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                           Image.network("https://openweathermap.org/img/wn/$icon@2x.png"),
                            SizedBox(width: 20,),
                            Column(
                              children: [
                                Text(
                                  "$desc",
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "In $get_city",
                                  style: TextStyle(
                         fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white.withOpacity(0.5),
                        ),
                        margin:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                        padding: EdgeInsets.all(26),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Icon(WeatherIcons.thermometer),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("$temp",style: TextStyle(
                                  fontSize: 70
                                ),),
                                Text("C",style: TextStyle(
                                  fontSize: 30,
                                ),),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              //dholu bholu container
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white.withOpacity(0.5),
                        ),
                        margin: EdgeInsets.fromLTRB(20, 0, 10, 0),
                        padding: EdgeInsets.all(26),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(WeatherIcons.windy),
                              ],
                            ),
                            SizedBox(height: 20),
                            Text("$air",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
                            Text("Km/hr"),
                          ],
                        ),
                        height: 200,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white.withOpacity(0.5),
                        ),
                        margin: EdgeInsets.fromLTRB(10, 0, 20, 0),
                        padding: EdgeInsets.all(26),
                        height: 200,
                        child:Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(WeatherIcons.humidity),
                              ],
                            ),
                            SizedBox(height: 20),
                            Text("$hum",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
                            Text("Percent"),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 70,),
                Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Made By Peachy"),
                      Text("Data provided by OpenWeather.org"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
