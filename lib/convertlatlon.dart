import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class Convertltg extends StatefulWidget {
  const Convertltg({super.key});

  @override
  State<Convertltg> createState() => _ConvertltgState();
}

class _ConvertltgState extends State<Convertltg> {
  var saddress="";
  var st="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Convert lat and lag"),
      ),
      body: Column(
        children: [
          Text(saddress),
          Text(st),
          Center(
            child: InkWell(
              onTap: ()async{
                List<Location> locations = await locationFromAddress("Gronausestraat 710, Enschede");
                List<Placemark> placemarks = await placemarkFromCoordinates(23.013020, 72.508365);
                setState(() {
                  saddress=locations.last.longitude.toString() +" " +locations.last.latitude.toString();
                  st=placemarks.reversed.last.country.toString() +" "
                      +placemarks.reversed.last.locality.toString()+" "
                      +placemarks.reversed.last.subLocality.toString()+" "
                      +placemarks.reversed.last.street.toString();
                });

                },

              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(10)
                ),
                child:Text("Convert"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
