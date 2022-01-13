import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tracking/location_services/location_services.dart';

class DriverView extends StatefulWidget {
  @override
  State<DriverView> createState() => _DriverViewState();
}

class _DriverViewState extends State<DriverView> {
  bool tracking = false;

  StreamSubscription? _streamSubscription;

  @override
  void dispose() {
    if(_streamSubscription != null)
      _streamSubscription!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text(tracking ? 'TRACKING...' : 'Start'),
          onPressed: tracking ? null : () {
            setState(() => tracking = true);
            _streamSubscription = LocationServices.getStreamingLocation().listen((event) {
              print("Lat : ${event.latitude} - Lon : ${event.longitude}");
              FirebaseFirestore.instance.collection('tacking').doc('dOBsSiEnmkoajpcqDci5').update({
                'driver_location': GeoPoint(event.latitude, event.longitude),
              });
            });
          },
        ),
      ),
    );
  }
}
