import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:madaresco/core/language/app_loclaizations.dart';
import 'package:maps_launcher/maps_launcher.dart';

class MapPage extends StatefulWidget {
  final double ?lat;
  final double ?long;
  MapPage({this.lat, this.long});
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();
  List<Marker> _markers = <Marker>[];
  CameraPosition ?studentLocation;

  @override
  void initState() {
    super.initState();
    studentLocation = CameraPosition(
      target: LatLng(widget.lat ?? 0, widget.long ?? 0),
      zoom: 14.4746,
    );
    _markers.add(Marker(
      markerId: MarkerId('SomeId'),
      position: LatLng(widget.lat ?? 0, widget.long ?? 0),
    ));
  }

  openMap() {
    MapsLauncher.launchCoordinates(widget.lat ?? 0, widget.long ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    return new Scaffold(
      appBar: AppBar(
        title: Text('${local.translate("trackSon")}'),
        backgroundColor: Color(0xFF001068),
      ),
      floatingActionButton: widget.lat == null || widget.long == null
          ? Container()
          : FloatingActionButton(
              backgroundColor: Color(0xFF001068),
              onPressed: openMap,
              child: Icon(Icons.directions),
            ),
      body: widget.lat == null || widget.long == null
          ? Center(
              child: Column(
                children: [
                  Image.asset('assets/images/noLocationFound.png'),
                  Text("${local.translate("mapNotavailable")}"),
                ],
              ),
            )
          : GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: studentLocation!,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              rotateGesturesEnabled: true,
              tiltGesturesEnabled: true,
              zoomGesturesEnabled: true,
              compassEnabled: true,
              zoomControlsEnabled: true,
              mapToolbarEnabled: true,
              scrollGesturesEnabled: true,
              myLocationEnabled: false,
              indoorViewEnabled: true,
              myLocationButtonEnabled: false,
              buildingsEnabled: true,
              trafficEnabled: true,
              markers: Set<Marker>.of(_markers),
            ),
    );
  }
}
