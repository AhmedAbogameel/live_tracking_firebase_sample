import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserView extends StatefulWidget {
  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {

  late GoogleMapController _googleMapController;

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('tacking').snapshots(),
        builder: (context, snapshot) {
          LatLng? latLng;
          if(snapshot.hasData){
            final position = snapshot.data!.docs.first.get('driver_location') as GeoPoint;
            latLng = LatLng(position.latitude, position.longitude);
            _googleMapController.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(target: latLng, zoom: 16)
            ));
          }
          return GoogleMap(
            initialCameraPosition: CameraPosition(target: latLng ?? LatLng(31, 31), zoom: 14),
            markers: {
              if(latLng != null)
                Marker(
                  markerId: MarkerId('driver'),
                  position: latLng,
                  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta)
                ),
            },
            onMapCreated: (controller) => _googleMapController = controller,
          );
        },
      ),
    );
  }
}
