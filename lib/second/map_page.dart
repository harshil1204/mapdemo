import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'contant/constant.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  static final LatLng _kMapCenter = LatLng(23.02648824695604, 72.5648773579418);
  static final LatLng _eMapCenter = LatLng(23.021810797790337, 72.5649603008669);
  LatLng? _currentP = null;
  final Location _locationController = Location();
  final Completer<GoogleMapController> _mapController = Completer<GoogleMapController>();

  Map<PolylineId,Polyline> polylines = {};

  @override
  void initState() {
    getLocationUpdates().then((value) {
      getPolyLinePoints().then((coordinates) {
        generatePolyLineFromPonits(coordinates);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentP == null
          ? const Center(
              child: Text("Loading"),
            )
          : GoogleMap(
              initialCameraPosition: CameraPosition(target: _kMapCenter, zoom: 13),
              markers: {
                Marker(markerId: const MarkerId("currentvalue"), icon: BitmapDescriptor.defaultMarker, position: _currentP!),
                // Marker(markerId: const MarkerId("sourcevalue"),icon: BitmapDescriptor.defaultMarker,position: _eMapCenter),
                // Marker(markerId: MarkerId("destinationvalue"),icon: BitmapDescriptor.defaultMarker,position: _kMapCenter),
              },
              polylines: Set<Polyline>. of(polylines.values),
              onMapCreated: (controller) => _mapController.complete(controller),
            ),
    );
  }

  Future<void> getLocationUpdates() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _locationController.serviceEnabled();
    if (_serviceEnabled) {
      _serviceEnabled = (await _locationController.requestService());
    } else {
      return;
    }
    _permissionGranted = await _locationController.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _locationController.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationController.onLocationChanged.listen((event) {
      if (event.latitude != null && event.longitude != null) {
        setState(() {
          _currentP = LatLng(event.latitude!, event.longitude!);
          _cameraToPosition(_currentP!);
        });
      }
    });
  }

  Future<void> _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition _newCameraPosition = CameraPosition(target: pos, zoom: 13);

    await controller.animateCamera(CameraUpdate.newCameraPosition(_newCameraPosition));
  }

  Future<List<LatLng>> getPolyLinePoints() async {
    List<LatLng> polylineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      GOOGLE_MAP_API,
      PointLatLng(_kMapCenter.latitude, _kMapCenter.longitude!),
      PointLatLng(_eMapCenter.latitude, _eMapCenter.longitude!),
      travelMode: TravelMode.driving
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print("yessssssssssssssss:${result.errorMessage}");
    }

    return polylineCoordinates;
  }

  void generatePolyLineFromPonits(List<LatLng> polylinecoordinates) async{
    PolylineId polylineId = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: polylineId,
        color: Colors.purple,
        width: 8,
        points: polylinecoordinates
    );
    setState(() {
      polylines[polylineId] = polyline;
    });
  }

}
