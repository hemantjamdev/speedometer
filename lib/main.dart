import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'home_page.dart';
void main(){
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((value) => runApp(const SpeedoMeterApp()));
}
class SpeedoMeterApp extends StatelessWidget {
  const SpeedoMeterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
