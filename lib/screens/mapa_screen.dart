import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qr_scan/models/scan_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaScreen extends StatefulWidget {
  const MapaScreen({Key? key}) : super(key: key);

  @override
  State<MapaScreen> createState() => _MapaScreenState();
}

class _MapaScreenState extends State<MapaScreen> {
  Completer<GoogleMapController> _controller = Completer();
  MapType _defaultMapType = MapType.normal;

  @override
  Widget build(BuildContext context) {
    final ScanModel scan =
        ModalRoute.of(context)!.settings.arguments as ScanModel;
    final CameraPosition _puntIncial = CameraPosition(
      target: scan.getLatLng(),
      zoom: 17,
      tilt: 50,
    );
    //Afegeix un marcador a la coordenada inicial
    Set<Marker> markers = new Set<Marker>();
    markers.add(new Marker(
      markerId: MarkerId("id1"),
      position: scan.getLatLng(),
    ));
    return Scaffold(
      appBar: AppBar(
        title: Text("Mapa"),
        actions: [
          IconButton(
              onPressed: () {
                _onCenterMap(scan.getLatLng());
              },
              icon: Icon(Icons.location_on))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Opcions de mapa",
        child: Icon(Icons.layers),
        onPressed: () {
          _changeMapType();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: GoogleMap(
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        mapType: _defaultMapType,
        markers: markers,
        initialCameraPosition: _puntIncial,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }

  //Canvia l'estat del mapa de normal a satel·lit i a l'inversa
  void _changeMapType() {
    setState(() {
      _defaultMapType = _defaultMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  //Mètode reb les coordenades de l'Scan i centra el mapa a les coordenades
  void _onCenterMap(LatLng coord) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLng(coord));
  }
}
