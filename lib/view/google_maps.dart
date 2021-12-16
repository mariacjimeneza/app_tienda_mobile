import 'dart:async';
import 'package:app_tienda_mobile/model/store.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

//void main() => runApp(GoogleMapsWidget( ));

class GoogleMapsWidget extends StatelessWidget {
  final Store comercio;
  GoogleMapsWidget(this.comercio);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('TuComercio'),
          backgroundColor: Color.fromRGBO(165, 42, 42, 1.0),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: GoogleMapsView(comercio),
      ),
    );
  }
}

class GoogleMapsView extends StatefulWidget {
  final Store comercio;
  GoogleMapsView(this.comercio);

  @override
  State<GoogleMapsView> createState() => GoogleMapsViewState();


}

class GoogleMapsViewState extends State<GoogleMapsView> {
  Completer<GoogleMapController> _controller = Completer();
  @override
  Widget build(BuildContext context) {
    final CameraPosition _mainCamera = CameraPosition(
      target: LatLng(widget.comercio.latitude, widget.comercio.longitude),
      zoom: 18,
    );

    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _mainCamera,
        markers: {
          Marker(markerId: MarkerId("100"),
          position: LatLng(widget.comercio.latitude, widget.comercio.longitude),
          infoWindow: InfoWindow(title: widget.comercio.name))
        },
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      /*
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('To the lake!'),
        icon: Icon(Icons.directions_boat),
      ),
      */
    );
  }

  /*Future<void> _goToTheLake() async {
  }
  */

}
