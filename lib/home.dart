import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:proximity_sensor/proximity_sensor.dart';

class DetectionApp extends StatefulWidget {
  const DetectionApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DetectionAppState createState() => _DetectionAppState();
}

class _DetectionAppState extends State<DetectionApp> {

  // ignore: unused_field
  bool _far = true;
  Color _ccolor = const Color.fromARGB(255, 102, 15, 9);
  String _value= '5.0 cm away ';
  Color _apcolor= const Color.fromARGB(255, 102, 15, 9);
  
  late StreamSubscription<dynamic> _stream;

  @override
  void initState() {
    super.initState();
    listenSensor();
  }

  @override
  void dispose() {
    super.dispose();
    _stream.cancel();
  }

Future<void> listenSensor() async {
  FlutterError.onError = (FlutterErrorDetails details) {
    if (foundation.kDebugMode) {
     FlutterError.dumpErrorToConsole(details);
    }
    };
_stream = ProximitySensor.events.listen((int event) {
   setState(() {
    _far = (event > 0) ? true:false;
      if (_far=( event >0)){
       _ccolor = const Color.fromARGB(255, 3, 62, 5);
       _value='less than 5.0 cm away ';
      _apcolor=const Color.fromARGB(255, 3, 62, 5);
       
      } else {
       _ccolor = const Color.fromARGB(255, 102, 15, 9);
       _value='5.0 cm away ';
       _apcolor=const Color.fromARGB(255, 102, 15, 9);
                            
     }
    });
    });
  }
 @override
  Widget build(BuildContext context) {
    return MaterialApp(
    debugShowCheckedModeBanner:false,
    home: Scaffold(
      appBar: AppBar(
         title: const Text('Detect object within a range of 5cm.'),
          backgroundColor:_apcolor,
        ),
    body: Padding(
     padding: const EdgeInsets.all(8.0),
      child: Center(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.start,
        children: [
         const SizedBox(height: 50,
          width: 20,),
         Text(
          "Cover your device's top ",
           style: GoogleFonts.actor
            ( fontSize:  25,fontWeight: FontWeight.bold), ),
         const SizedBox(height: 100,),
         // ignore: avoid_unnecessary_containers
         Container(
          child: Container(
           width: 150,
           height: 150,
           decoration: BoxDecoration(
             shape: BoxShape.circle,
             color: _ccolor, ),),
             ),
         const SizedBox(height: 20,),
         Text(_value, style: GoogleFonts.akayaKanadaka( fontSize:  20),),
          ],
         ),       
        ),
      ),
    ),
   );
  }
}