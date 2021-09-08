import 'dart:async';

import 'package:aranacaklar/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'screens/mainscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Graphik',
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  bool showSnackbar=false;
  Timer ?_timer;
  int _start = 4;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();

    getData();
  }
  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }
  getData() async {

    await  FirebaseFirestore.instance.collection('allBusinesses').get().then((value){


      if(value.size!=0)
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MainPage(docs:value.docs)));
      else {
        if (!showSnackbar) {
          final snackBar = SnackBar(
              content: Text('Check your internet connection!'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          setState(() {
            showSnackbar = true;
          });
        }
      }
    });





  }
  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          setState(() {

            timer.cancel();
          });

        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          return Container(
            color: darkBlue,
            child: Center(
              child: Text(
                'aranacaklar',
                style: TextStyle(
                  fontSize: 42,
                  color: backgroundColor,
                  fontFamily: 'Arista Pro',
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.3,
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
