
import 'package:flutter/material.dart';

import 'Activity/home.dart';
import 'Activity/loading.dart';

// @dart=2.9
void main() {
  runApp(MaterialApp(
    routes: {
      //1st one is default page
      "/":(context) => LoadingState(),
      "/home" :(context) => Home(),
      "/loading" :(context) => LoadingState(),
    },
  ));
}
