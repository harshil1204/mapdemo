import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static final LatLng _kMapCenter =
  LatLng(23.013840, 72.505232);
  Completer<GoogleMapController> _controller = Completer();
  
  List<Marker> _markers=[];
   List<Marker> _list=[
    Marker(markerId:MarkerId("1"),
    position: LatLng(23.013840, 72.505232),
      infoWindow: InfoWindow(
        title: "My Position",
        snippet: "hello"
      )
    ),
    Marker(markerId:MarkerId("2"),
        position: LatLng(23.013020, 72.508365),
        infoWindow: InfoWindow(
            title: "My Position",
            snippet: "hello"
        )
    )
  ];
  
  Future<Position?> getUserCurrentLocation() async{
    await Geolocator.requestPermission().then((value) {
      
    }).onError((error, stackTrace) {
      print(error.toString());
    });

    return await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    _markers.addAll(_list);
    // TODO: implement initState
    super.initState();
  }
  static final CameraPosition _kInitialPosition =
  CameraPosition(target: _kMapCenter, zoom: 14.0, tilt: 0, bearing: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        compassEnabled: false,
          myLocationEnabled: true,
          markers: Set<Marker>.of(_markers),
          initialCameraPosition: _kInitialPosition,
        onMapCreated: (controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: ()async{
        // GoogleMapController controller =await _controller.future;
        // controller.animateCamera(CameraUpdate.newCameraPosition(
        //   CameraPosition(target: LatLng(23.013840, 72.505232),zoom: 14)
        // ));
        
        getUserCurrentLocation().then((value) async{
          print("my location.....");
          print(value?.latitude);
          print(value?.latitude.toString() ?? "" +" "+value!.longitude.toString() ?? "");
          _markers.add(
            Marker(markerId:MarkerId("3"),
            position: LatLng(value!.latitude,value.longitude),
              infoWindow: InfoWindow(title: "My location")
            )
          );
          CameraPosition cameraPosition=CameraPosition(target:LatLng(value!.latitude,value!.longitude),
            zoom: 14,
          );
          final GoogleMapController controller=await _controller.future;
            controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
            setState(() {});
          });
        setState(() {

        });
      },
      child: Icon(Icons.location_city),
      ),
    );
  }
}
