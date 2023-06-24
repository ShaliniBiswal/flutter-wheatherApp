import 'dart:convert';
import 'package:http/http.dart';

class worker{

  String?location;
  //constructor
  worker({this.location}){
    location = this.location;
  }

  String?temp;
  String?humidity;
  String?air_speed;
  String?description;
  String?main;
  String?icon;

  //method - get us every value based on location
  Future<void> getData()async {
    try {
      Response response = await get (Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?q=$location&appid=96e7587335c517d08e1419eb762d9bac"));
      Map data = jsonDecode(response.body);

      //getting description
      List weather_data = data['weather'];
      Map weather_main_data = weather_data[0];
      String getmain_des = weather_main_data['main'];
      String getdesc = weather_main_data['description'];


      //getting temp,humidity
      Map temp_data = data['main'];
      String gethumidity = temp_data['humidity'].toString();
      double gettemp = temp_data['temp'] -  271.15; // kelvin to farenheite

      //getting air
      Map wind = data['wind'];
      double getair_speed = wind['speed']/0.27777777777778;

      //assigning values
      temp = gettemp.toString();
      humidity = gethumidity;
      air_speed = getair_speed.toString();
      description = getdesc;
      main = getmain_des;
      icon = weather_main_data["icon"].toString();
    }catch(e){
      //assigning default value w
      temp = "NA";
      humidity = "NA";
      air_speed =  "NA";
      description =  "Can't find data!";
      main =  "NA";
      icon ="11d";
    }

  }



}
