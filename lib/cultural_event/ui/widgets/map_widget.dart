import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapWidget extends StatelessWidget {
  const MapWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(-17.3927, -66.1590),
        zoom: 9.2,
      ),
      nonRotatedChildren: [
        AttributionWidget.defaultWidget(
          source: 'OpenStreetMap contributors',
          onSourceTapped: null,
        ),
      ],
      layers: [
        TileLayerOptions(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.cochabambacultural',
        ),
      ],
    );
  }
}
