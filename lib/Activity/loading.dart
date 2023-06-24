
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mausam/Worker/worker.dart';
class LoadingState extends StatefulWidget {
  const LoadingState({Key? key}) : super(key: key);

  @override
  State<LoadingState> createState() => _LoadingStateState();
}

class _LoadingStateState extends State<LoadingState> {

  String  city = "Odisha";
  String ?temp;
  String ?hum;
  String ?air_speed;
  String ?desc;
  String ?main;
  String ?icon;


  void startApp(String city) async{
    worker instance = worker(location:city);
    await instance.getData();
    temp = instance.temp;
    hum = instance.humidity;
    air_speed=instance.air_speed;
    desc =instance.description;
    main = instance.main;
    icon = instance.icon;

    //for delay loading screen
    Future.delayed(Duration(seconds: 3),(){

      //throw value to the homepage
      Navigator.pushReplacementNamed(context, '/home',
          arguments: {
            "temp_value" : temp,
            "hum_value" : hum,
            "air_speed_value" : air_speed,
            "des_value" : desc,
            "main_value" : main,
            "icon_value" :icon,
            "city_value" : city,
          }
      );
    });


  }
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
      Map? search =ModalRoute.of(context)?.settings.arguments as Map?;
      //city = search?['searchText'] ?? city;
      if(search?.isNotEmpty ?? false){
        city = search!['searchText'];
      }
      startApp(city);
      return Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 180,),
                Image.asset("images/mlogo.png",height:240,width: 240),
                Text("Mausam App",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text("Made by Peachy",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
                ),
           SizedBox(height: 30),
           SpinKitWave(
              color: Colors.white,
              size: 50.0,
            ),
          ],
            ),
          ),
        ),
        backgroundColor: Colors.blue.shade300,
    );
  }
}
