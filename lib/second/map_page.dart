
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  static final LatLng _kMapCenter = LatLng(23.013840, 72.505232);
  static final LatLng _eMapCenter = LatLng(23.013020, 72.508365);
  LatLng? _currentP=null;
  Location _locationController=new Location();


  @override
  void initState() {
    getLocationUpdates();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map '),
      ),
      body: _currentP == null ? Center(child: Text("Loading"),):GoogleMap(
          initialCameraPosition: CameraPosition(target: _kMapCenter,zoom: 13),
        markers: {
            Marker(markerId: MarkerId("currentvalue"),icon: BitmapDescriptor.defaultMarker,position: _currentP!),
            Marker(markerId: const MarkerId("sourcevalue"),icon: BitmapDescriptor.defaultMarker,position: _eMapCenter),
            Marker(markerId: MarkerId("destinationvalue"),icon: BitmapDescriptor.defaultMarker,position: _kMapCenter),
        },
      ),
    );
  }

  Future<bool?> getLocationUpdates() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled=await _locationController.serviceEnabled();
    // if(_serviceEnabled){
    //   _serviceEnabled=(await _locationController.requestPermission()) as bool;
    // }
    // else{
    //   return true;
    // }
    // _permissionGranted=await _locationController.hasPermission();
    // if(_permissionGranted==PermissionStatus.denied){
    //   _permissionGranted!=await _locationController.requestPermission();
    //   if(_permissionGranted==PermissionStatus.granted){
    //     return true;
    //   }
    // }

    _locationController.onLocationChanged.listen((event) {
      if(event.latitude !=null && event.longitude !=null){
        setState(() {
          _currentP=LatLng(event.latitude!,event.longitude!);
        print('print:::${_currentP}');
        });
      }
    });

  }

}
