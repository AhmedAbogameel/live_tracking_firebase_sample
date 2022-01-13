import 'package:flutter/material.dart';
import 'package:tracking/driver.dart';
import 'package:tracking/location_services/location_services.dart';
import 'package:tracking/user.dart';

class SplashView extends StatefulWidget {
  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  @override
  void initState() {
    LocationServices.getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => UserView(),));
              },
              child: Text('User'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => DriverView(),));
              },
              child: Text('Driver'),
            ),
          ],
        ),
      ),
    );
  }
}
