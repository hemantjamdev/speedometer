import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String text = "00";

  var geolocator = Geolocator();
  requestPermission() {
    Permission.location.request().then((value) {
      if (value.isGranted) getSpeed();
    });
  }

  getSpeed() async {
    await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    Geolocator.getPositionStream().listen((position) {
      double speedInMps =
          double.parse((position.speed * 3.6).toStringAsFixed(2));
      if (kDebugMode) {
        print(text);
      }
      setState(() {
        text = speedInMps.toStringAsFixed(2);
      });
    });
  }

  @override
  void initState() {
    requestPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: getSpeed,
      ),
      appBar: AppBar(
        title: const Text("Speedo Meter"),
        centerTitle: true,
      ),
      body: SfRadialGauge(
        title: const GaugeTitle(
          text: 'Speedometer',
          textStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        axes: <RadialAxis>[
          RadialAxis(
            minimum: 0,
            maximum: 150,
            ranges: <GaugeRange>[
              GaugeRange(
                startValue: 0,
                endValue: 50,
                color: Colors.green,
                startWidth: 10,
                endWidth: 10,
              ),
              GaugeRange(
                startValue: 50,
                endValue: 100,
                color: Colors.orange,
                startWidth: 10,
                endWidth: 10,
              ),
              GaugeRange(
                startValue: 100,
                endValue: 150,
                color: Colors.red,
                startWidth: 10,
                endWidth: 10,
              )
            ],
            pointers: <GaugePointer>[
              NeedlePointer(
                value: double.parse(text),
              ),
            ],
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                widget: Text(
                  text,
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                ),
                angle: 90,
                positionFactor: 0.5,
              )
            ],
          ),
        ],
      ),
    );
  }
}
